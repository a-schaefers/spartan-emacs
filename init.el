;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; startup

(setq package-enable-at-startup nil
      load-prefer-newer t
      inhibit-startup-screen t)

;; straight+use-package

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

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
           :straight t
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

(add-hook 'after-init-hook #'spartan-configure-eglot-autostart)

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

(add-hook 'after-init-hook 'spartan-user-local-hook)

;;; init.el ends here
