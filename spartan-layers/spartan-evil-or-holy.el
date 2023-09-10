;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(use-package evil
  :if (string-match-p spartan-evil-or-holy "evil")
  :straight t
  :defer t
  :init
  (evil-mode 1))

(provide 'spartan-evil-or-holy)
