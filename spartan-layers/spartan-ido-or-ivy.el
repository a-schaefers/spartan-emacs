;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package amx
  :if (string-match-p spartan-ido-or-ivy "ido")
  :straight t
  :demand t
  :config
  (setq amx-ignored-command-matchers nil
        amx-show-key-bindings nil)
  (amx-mode 1))

(use-package ido
  :if (string-match-p spartan-ido-or-ivy "ido")
  :straight t
  :demand t
  :config
  (setq ido-create-new-buffer 'always
        ido-auto-merge-work-directories-length -1
        ido-enable-flex-matching t
        ido-use-filename-at-point 'guess
        ido-use-faces nil)

  (ido-mode 1)
  (ido-everywhere 1))

(use-package ido-completing-read+
  :if (string-match-p spartan-ido-or-ivy "ido")
  :straight t
  :demand t
  :config
  (ido-ubiquitous-mode 1))

(use-package browse-kill-ring
  :if (string-match-p spartan-ido-or-ivy "ido")
  :straight t
  :demand t)

(use-package ivy
  :if (string-match-p spartan-ido-or-ivy "ivy")
  :straight t
  :demand t
  :config
  (ivy-mode 1))

(use-package counsel
  :if (string-match-p spartan-ido-or-ivy "ivy")
  :straight t
  :demand t
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))

(provide 'spartan-ido-or-ivy)
