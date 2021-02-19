;;; -*- lexical-binding: t; -*-

(add-hook 'prog-mode-hook 'goto-address-mode)

(add-hook 'window-setup-hook #'(lambda ()
                                 (require 'server)
                                 (or (server-running-p)
                                     (server-start))))

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(global-eldoc-mode 1)

(winner-mode 1)

(electric-pair-mode 1)

(delete-selection-mode)

(show-paren-mode 1)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(add-hook 'before-save-hook 'whitespace-cleanup)

(save-place-mode 1)

(recentf-mode 1)

(savehist-mode 1)

(ido-mode 1)

(with-eval-after-load 'flymake
  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake))
(add-hook 'prog-mode-hook 'flymake-mode)

(provide 'spartan-builtins)
