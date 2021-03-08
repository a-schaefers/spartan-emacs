;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; for terminal Emacs only (emacs -nw)

(defun spartan-emacs-nw-hook ()
  (global-set-key (kbd "C-x ;") 'comment-line) ; "C-x C-;" is interpreted this way in some terminals

  (xterm-mouse-mode 1) ; mouse support

  (require 'clipetty) ; clipboard support
  (global-clipetty-mode +1))

(or window-system
    (progn
      (add-to-list 'spartan-package-list 'clipetty)
      (add-hook 'after-init-hook 'spartan-emacs-nw-hook)))

(provide 'spartan-emacs-nw)
