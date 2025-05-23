;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; startup

(setq package-enable-at-startup nil
      load-prefer-newer t
      inhibit-startup-screen t)

(add-hook 'after-init-hook #'(lambda ()
                               (interactive)
                               (require 'server)
                               (or (server-running-p)
                                   (server-start))))

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

(setq use-package-compute-statistics t)

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
             (after  `(progn ,@(let ((val (plist-get props :after)))  (if (listp val) val (list val)))))
             (defer  (plist-get props :defer)))
        `(use-package ,pkg
           :straight t
           ,@(when (plist-member props :init)   `(:init ,init))
           ,@(when (plist-member props :defer)  `(:defer ,defer))
           ,@(when (plist-member props :after)  `(:after ,after))
           ,@(when (plist-member props :config) `(:config ,config))
           ,@(when (plist-member props :bind)   `(:bind ,bind)))))
    specs)))


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

(or (file-exists-p spartan-config)
    (progn
      (with-temp-file spartan-config
        (insert ";;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spartan.el Emacs General Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq user-full-name    \"John Doe\"
      user-mail-address \"john.doe@example.com\"
      spartan-projects  \"~/repos\" ; where your Projects live
      )

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load layers
;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq spartan-layers '(
                       spartan-better-defaults ; Based on technomancy's better defaults
                       spartan-better-scratch  ; Persistent, unkillable org-mode scratch buffer
                       spartan-theme           ; Cleans up UI in a way that is minimal
                       spartan-vertico         ; Adds fancier minibuffer
                       spartan-flymake         ; M-x lint
                       spartan-crux            ; Adds misc. helper binds
                       spartan-magit           ; M-x git
                       spartan-projectile      ; M-x pro
                       spartan-eglot           ; Adds lsp support
                       spartan-company         ; Adds autocompletion drop-down menu
                       spartan-shell           ; M-x sh
                       spartan-treesit         ; Turns on treesitter everywhere as much as possible
                       ))

(add-to-list 'load-path (concat user-emacs-directory \"spartan-layers\"))
(dolist (layer spartan-layers)
  (require layer))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modes that will autostart the corresponding eglot LSP server if found on PATH
;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq spartan-eglot-autostart-langs
      '(
        (c-ts-mode-hook . clangd)
        (c++-ts-mode-hook . clangd)
        (lua-ts-mode-hook . lua-language-server)
        (python-ts-mode-hook . pylsp)
        (go-ts-mode-hook . gopls)
        (rust-ts-mode-hook . rust-analyzer)
        (ruby-ts-mode-hook . solargraph)
        (elixir-ts-mode . elixir-ls)
        (html-ts-mode-hook . vscode-html-language-server)
        (css-ts-mode-hook . vscode-css-language-server)
        (typescript-ts-mode-hook . typescript-language-server)
        (js-ts-mode-hook . typescript-language-server)

        ;; (php-mode-hook . true)          ; workaround, php lang server is not available on PATH but via required lib
        ;; (zig-mode-hook . zigls)
        ;; (terraform-mode-hook . terraform-ls)
        ;; (nix-mode . rnix-lsp)
        ;; (haskell-mode . haskell-language-server-wrapper)
        ;; (ocaml-mode-hook . ocaml-lsp)
        ;; (forth-mode-hook . forth-lsp)
        ;; (erlang-mode-hook . erlang_ls)
        ;; (racket-mode-hook . true)       ; workaround, racket lang server is not available on PATH but via required lib
        ))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Eglot LSP binds
;;;;;;;;;;;;;;;;;;;;;;;;;;

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd \"M-m r\") 'eglot-rename)
  (define-key eglot-mode-map (kbd \"M-m o\") 'eglot-code-action-organize-imports)
  (define-key eglot-mode-map (kbd \"M-m h\") 'eldoc)
  (define-key eglot-mode-map (kbd \"M-m =\") 'eglot-format)
  (define-key eglot-mode-map (kbd \"M-m ?\") 'xref-find-references)
  (define-key eglot-mode-map (kbd \"M-.\")   'xref-find-definitions))

;; iterate key value list of mode hooks and lsp bins and eglot-ensure
(dolist (pair spartan-eglot-autostart-langs)
    (let ((hook (car pair))
          (lsp-bin (symbol-name (cdr pair))))
      (when (executable-find lsp-bin)
        (add-hook hook #'eglot-ensure))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Additional package setup, supports :defer :bind :config :init :after
;;;;;;;;;;;;;;;;;;;;;;;;;;

(spartan-pkg
  (modus-themes :config ((load-theme 'modus-operandi t)))

  ;; (evil :config (evil-mode 1))

  ;; Additional langs that aren't supported yet OOTB yet by treesitter

  ;; (markdown-mode :defer t)
  ;; (php-mode :defer t)
  ;; (haskell-mode :defer t)
  ;; (zig-mode :defer t)
  ;; (terraform-mode :defer t)
  ;; (nix-mode :defer t )
  ;; (systemd-mode :defer t)
  ;; (dockerfile-mode :defer t)
  ;; (nginx-mode :defer t)
  ;; (tuareg-mode :defer t) ; ocaml
  ;; (forth-mode :defer t)
  ;; (erlang :defer t)

  ;;;; LISP general
  (paredit
   :defer t
   :init
   ((add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
   (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
   (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
   ;; lisps
   (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
   (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
   ;; schemes
   (add-hook 'scheme-mode-hook           #'enable-paredit-mode)
   ;; clojure
   (with-eval-after-load 'clojure-mode
     (add-hook 'clojure-mode-hook          #'enable-paredit-mode))
   ;; racket
   (with-eval-after-load 'racket-mode
     (add-hook 'racket-mode-hook          #'enable-paredit-mode))))

  ;; (clojure-mode :defer t)
  ;; (cider :defer t :after clojure-mode)

  ;; (slime :init
  ;;        ((setq inferior-lisp-program \"sbcl\")
  ;;         (add-to-list 'auto-mode-alist '(\"\\\\.cl\\\\'\" . lisp-mode))
  ;;         (add-to-list 'auto-mode-alist '(\"\\\\.sbclrc\\\\'\" . lisp-mode))))

  ;; (racket-mode :defer t)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Additional config
;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-face-attribute 'default nil :family \"Monospace\" :height 200) ; font size

(setq
 ;; https://www.kernel.org/doc/html/v4.10/process/coding-style.html
 c-default-style \"linux\"
 ;; tabs are 8 spaces
 c-basic-offset 8)

;; tabs are tabs
(add-hook 'makefile-mode-hook (lambda ()
                                (setq-local indent-tabs-mode t)))

(add-hook 'c-ts-mode-hook (lambda ()
                                (setq-local indent-tabs-mode t)))

(add-hook 'c++-ts-mode-hook (lambda ()
                                (setq-local indent-tabs-mode t)))
"))))

(load-file spartan-config)

;;; init.el ends here
