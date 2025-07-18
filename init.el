;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; startup

(setq package-enable-at-startup nil
      load-prefer-newer t
      inhibit-startup-screen t)

;; straight+use-package

(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))


(defmacro spartan-pkg (&rest specs)
  (declare (indent defun))
  (macroexp-progn
   (mapcar
    (lambda (spec)
      (let* ((pkg (if (listp spec) (car spec) spec))
             (props (if (listp spec) (cdr spec) '()))
             (init   `(progn ,@(let ((val (plist-get props :init)))   (if (listp val) val (list val)))))
             (config `(progn ,@(let ((val (plist-get props :config))) (if (listp val) val (list val)))))
             (bind   `(progn ,@(let ((val (plist-get props :bind)))   (if (listp val) val (list val)))))
             (defer  (plist-get props :defer)))
        `(use-package ,pkg
           :ensure t
           ,@(when (plist-member props :init)   `(:init ,init))
           ,@(when (plist-member props :defer)  `(:defer ,defer))
           ,@(when (plist-member props :config) `(:config ,config))
           ,@(when (plist-member props :bind)   `(:bind ,bind)))))
    specs)))

(defun spartan-configure-eglot-autostart ()
  "Configure eglot autostart hooks for specified language modes."
  (dolist (pair spartan-eglot-autostart-langs)
    (let* ((hook (car pair))
           (val (cdr pair))
           (mode (intern (string-remove-suffix "-hook" (symbol-name hook))))
           (override (and (consp val) (eq (car val) :override)))
           (lsp-bin (if override (cadr val) val))
           (cmd (cond
                 ((symbolp lsp-bin) (list (symbol-name lsp-bin)))
                 ((listp lsp-bin) lsp-bin)
                 (t nil))))
      (when (and cmd (executable-find (car cmd)))
        (add-hook hook #'eglot-ensure))
      (when override
        (eval-after-load 'eglot
          `(add-to-list 'eglot-server-programs
                        '(,mode . ,cmd)))))))

(add-hook 'elpaca-after-init-hook #'spartan-configure-eglot-autostart)

;; performance

;; https://emacs-lsp.github.io/lsp-mode/page/performance/
(setq gc-cons-threshold 100000000
      read-process-output-max (* 1024 1024))

;; https://www.masteringemacs.org/article/speed-up-emacs-libjansson-native-elisp-compilation
(if (and (fboundp 'native-comp-available-p)
         (native-comp-available-p))
    (setq comp-deferred-compilation t
          package-native-compile t)
  (message "Native complation is *not* available, lsp performance will suffer..."))

(unless (functionp 'json-serialize)
  (message "Native JSON is *not* available, lsp performance will suffer..."))

;; do not steal focus while doing async compilations
(setq warning-suppress-types '((comp)))

;; generate spartan configuration file

(setq spartan-config (concat user-emacs-directory "spartan.el"))
(setq spartan-default-config (concat user-emacs-directory "spartan-defaults.el"))

(or (file-exists-p spartan-config)
    (copy-file spartan-default-config spartan-config))

(load-file spartan-config)

;; define manual update mechanism for spartan.el

(defun spartan-update-config-with-ediff ()
  (interactive)
  (ediff-files spartan-config
               spartan-default-config))

(defun spartan-edit-config ()
  (interactive)
  (find-file spartan-config))

;; spartan.d/ loads last

(setq spartan-lisp-d (concat user-emacs-directory "spartan.d"))
(or
 (file-directory-p spartan-lisp-d)
 (make-directory spartan-lisp-d))

(defun spartan-user-local-hook ()
  (when (file-directory-p spartan-lisp-d)
    (dolist (file (directory-files spartan-lisp-d nil "^.*\.el$"))
      (load-file (concat spartan-lisp-d "/" file)))))

(add-hook 'elpaca-after-init-hook 'spartan-user-local-hook)

;;; init.el ends here
