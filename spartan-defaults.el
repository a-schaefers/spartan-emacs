;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spartan.el Emacs General Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set your name, email address, and directory where your code resides.
(setq user-full-name    "John Doe"
      user-mail-address "john.doe@example.com"
      magit-repository-directories '(("~/repos" . 1)))

;; spartan.el is generated from emacs.d/spartan-defaults.el
;; It may be necessary to manually update your spartan.el based on spartan-defaults.el periodically to obtain some new feature or other changes
;; The helper function `spartan-update-config-with-ediff' is available for this purpose, which will open an ediff session for doing this.

;; Edit spartan.el
(global-set-key (kbd "C-c i") 'spartan-edit-config)

;; Ediff spartan.el and spartan-defaults.el
(global-set-key (kbd "C-c I") 'spartan-update-config-with-ediff)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Appearance
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Note: Users who dislike this theme may want to remove this section,
;; and see the example below in the spartan-pkg macro for how to install and use another theme entirely.

(setq-default frame-title-format '("Emacs"))
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(fringe-mode -1)
(menu-bar-mode 1)
(tool-bar-mode -1)

(setq nano-splash-timeout nil
      nano-splash-timeout-sec 5
      nano-font-height 140
      nano-default-font "Roboto Mono") ; `nano-default-font' should support 'light and 'normal font shades

(add-to-list 'load-path (concat user-emacs-directory "nano-emacs"))

(require 'nano-minimal)
(require 'nano-splash)

;; (nano-dark)
(nano-light)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load layers
;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq spartan-layers '(
                       spartan-better-defaults ; Based on technomancy's better defaults
                       spartan-better-scratch  ; Persistent, unkillable org-mode scratch buffer
                       spartan-vertico         ; Adds fancier minibuffer
                       spartan-flymake         ; Configures flymake to be our linter
                       spartan-magit           ; A frontend to git
                       spartan-projectile      ; Git project awareness and find/grep tools
                       spartan-eglot           ; Adds lsp support
                       spartan-company         ; Adds autocompletion drop-down menu
                       spartan-treesit         ; Turns on treesitter everywhere as much as possible
                       ))

(add-to-list 'load-path (concat user-emacs-directory "spartan-layers"))
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
        (bash-ts-mode-hook . bash-language-server)
        (python-ts-mode-hook . pylsp)
        (go-ts-mode-hook . gopls)
        (rust-ts-mode-hook . rust-analyzer)
        (ruby-ts-mode-hook . solargraph)
        (elixir-ts-mode-hook . (:override elixir-ls))
        (html-ts-mode-hook . vscode-html-language-server)
        (css-ts-mode-hook . vscode-css-language-server)
        (typescript-ts-mode-hook . typescript-language-server)
        (js-ts-mode-hook . typescript-language-server)
        (yaml-ts-mode-hook . yaml-language-server)
        (json-ts-mode-hook . vscode-json-languageserver)
        (java-ts-mode-hook . jdtls)
        (csharp-ts-mode-hook . OmniSharp)

        ;; (markdown-mode-hook . marksman)
        ;; (php-mode-hook . true)          ; workaround, php lang server is not available on PATH but via required lib
        ;; (zig-mode-hook . zigls)
        ;; (terraform-mode-hook . terraform-ls)
        ;; (nix-mode-hook . rnix-lsp)
        ;; (haskell-mode-hook . haskell-language-server-wrapper)
        ;; (ocaml-mode-hook . ocaml-lsp)
        ;; (scala-mode-hook . metals)
        ;; (forth-mode-hook . forth-lsp)
        ;; (erlang-mode-hook . erlang_ls)
        ;; (racket-mode-hook . true)       ; workaround, racket lang server is not available on PATH but via required lib
        ;; (clojure-mode-hook . clojure-lsp)
        ))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Eglot LSP and Company binds
;;;;;;;;;;;;;;;;;;;;;;;;;;

(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "M-m r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "M-m o") 'eglot-code-action-organize-imports)
  (define-key eglot-mode-map (kbd "M-m h") 'eldoc)
  (define-key eglot-mode-map (kbd "M-m =") 'eglot-format)
  (define-key eglot-mode-map (kbd "M-m ?") 'xref-find-references)
  (define-key eglot-mode-map (kbd "M-.")   'xref-find-definitions))

;; Auto-completion bindings
(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Install and configure additional packages, this macro supports :defer :bind :config :init
;;;;;;;;;;;;;;;;;;;;;;;;;;

(spartan-pkg
  ;; Original spartan-emacs theme, left in-place for those who may dislike the nano theme,
  ;; or want an example of how to install and customize with another theme
  ;;  (modus-themes :config
  ;;                ((load-theme 'modus-vivendi t)

  ;;                 ;; Set Font and Font Size here
  ;;                 (set-face-attribute 'default nil :family "Monospace" :height 180)

  ;;                 ;; Clean look
  ;;                 (blink-cursor-mode -1)
  ;;                 (scroll-bar-mode -1)
  ;;                 (fringe-mode -1)
  ;;                 (menu-bar-mode -1)
  ;;                 (tool-bar-mode -1)

  ;;                 ;; Remove hostname from the GUI titlebar
  ;;                 (setq-default frame-title-format '("Emacs"))

  ;;                 ;; Clean mode-line

  ;;                 ;; https://emacs.stackexchange.com/questions/5529/how-to-right-align-some-items-in-the-modeline
  ;;                 (defun simple-mode-line-render (left right)
  ;;                   "Return a string of `window-width' length containing LEFT, and RIGHT
  ;; aligned respectively."
  ;;                   (let* ((available-width (- (window-width) (length left) 2)))
  ;;                     (format (format " %%s %%%ds " available-width) left right)))

  ;;                 (progn
  ;;                   (setq-default mode-line-format
  ;;                                 '((:eval (simple-mode-line-render
  ;;                                           ;; left
  ;;                                           (format-mode-line "%* %b %l")
  ;;                                           ;; right
  ;;                                           (format-mode-line "%m"))))))))

  ;; Extensible vi layer
  ;; (evil :config ((evil-mode 1)))
  ;; (evil-commentary :config ((evil-commentary-mode 1)))

  ;; Collection of Ridiculously Useful eXtensions
  (crux :defer t :init
        ((global-set-key (kbd "C-a") 'crux-move-beginning-of-line)
        (global-set-key (kbd "C-o") 'crux-smart-open-line)
        (global-set-key (kbd "C-x C-o") 'crux-other-window-or-switch-buffer)
        (global-set-key (kbd "C-c C-l") 'crux-duplicate-current-line-or-region)
        (global-set-key (kbd "C-c C--") 'crux-kill-whole-line)
        (global-set-key (kbd "C-c ;") 'crux-duplicate-and-comment-current-line-or-region)))

  ;; Additional langs that aren't supported OOTB yet by treesitter

  ;; (markdown-mode :defer t)
  ;; (php-mode :defer t)
  ;; (haskell-mode :defer t)
  ;; (zig-mode :defer t)
  ;; (terraform-mode :defer t)
  ;; (nix-mode :defer t )
  ;; (systemd-mode :defer t)
  ;; (nginx-mode :defer t)
  ;; (tuareg-mode :defer t) ; ocaml
  ;; (forth-mode :defer t)
  ;; (erlang :defer t)
  ;; (scala-mode :defer t)

  ;;;; LISP general
  (paredit
   :defer t
   :init
   ((add-hook 'emacs-lisp-mode-hook        #'enable-paredit-mode)
   (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
   (add-hook 'ielm-mode-hook               #'enable-paredit-mode)
   ;; lisps
   (add-hook 'lisp-interaction-mode-hook   #'enable-paredit-mode)
   (add-hook 'lisp-mode-hook               #'enable-paredit-mode)
   ;; schemes
   (add-hook 'scheme-mode-hook             #'enable-paredit-mode)
   ;; clojure
   (with-eval-after-load 'clojure-mode
     (add-hook 'clojure-mode-hook          #'enable-paredit-mode))
   ;; racket
   (with-eval-after-load 'racket-mode
     (add-hook 'racket-mode-hook           #'enable-paredit-mode))))

  ;; (clojure-mode :defer t)
  ;; (cider :defer t)

  ;; (slime :defer t :init
  ;;        ((setq inferior-lisp-program "sbcl")
  ;;         (add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))
  ;;         (add-to-list 'auto-mode-alist '("\\.sbclrc\\'" . lisp-mode))))

  ;; (racket-mode :defer t)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Additional config
;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq-default
 ;; these settings still should be set on a per language basis, this is just a general default
 indent-tabs-mode nil ; In general, we prefer spaces
 fill-column 79       ; python friendly
 )

;; C and C++ specific overrides (A language-specific override example)

(defun spartan-c-ts-modes ()
  ;; Use Linux kernel coding style in C and C++ (Tree-sitter modes)
  ;; https://www.kernel.org/doc/html/v4.10/process/coding-style.html
  (setq-local indent-tabs-mode t)               ; Use tabs
  (setq-local tab-width 8)                      ; Display width of tab
  ;; C-specific
  (setq-local c-ts-mode-indent-style 'linux)
  (setq-local c-ts-mode-indent-offset 8)
  ;; C++-specific
  (setq-local c++-ts-mode-indent-style 'linux)
  (setq-local c++-ts-mode-indent-offset 8))

(add-hook 'c-ts-mode-hook #'spartan-c-ts-modes)
(add-hook 'c++-ts-mode-hook #'spartan-c-ts-modes)

;; tabs are tabs in C family langs
(add-hook 'makefile-mode-hook (lambda ()
                                (setq-local indent-tabs-mode t)))

;; Set default compile command, for make or whatever.
(setq compile-command "make -k ")
;; M-x cc
(defalias 'cc 'compile)

;; M-x sh
(defalias 'sh 'shell)

;; M-x lint
(defalias 'lint 'spartan-lint)

;; M-x git
(defalias 'git 'magit)

;; M-x pro
(defalias 'pro 'projectile-commander)

;; Start the Emacs server for use by emacsclient
(add-hook 'after-init-hook #'(lambda ()
                               (interactive)
                               (require 'server)
                               (or (server-running-p)
                                   (server-start))))

;; Set EDITOR to emacsclient
(or (getenv "EDITOR")
    (progn
      (setenv "EDITOR" "emacsclient")
      (setenv "VISUAL" (getenv "EDITOR"))))

;; Set PAGER to cat, for proper viewing of man pages, etc. while in M-x shell
(or (getenv "PAGER")
    (setenv "PAGER" "cat"))
