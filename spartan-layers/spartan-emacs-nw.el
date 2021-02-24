;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; for terminal Emacs only (emacs -nw)

(defun spartan-paste-mode ()
  "Experimental. This may or may not work. For pasting in to terminal Emacs. Anyone have a better idea?"
  (interactive)
  (if (bound-and-true-p spartan-paste-on)
    (progn
      (funcall spartan-paste-stored-mode)
      (setq spartan-paste-on nil)
      (message "PASTE MODE OFF"))
  (progn
    (setq spartan-paste-stored-mode major-mode
	  spartan-paste-on t)
    (fundamental-mode)
    (message "PASTE MODE ON"))))

(defun spartan-emacs-nw-hook ()

  (global-set-key (kbd "C-x ;") 'comment-line) ; "C-x C-;" is interpreted this way in some terminals

  (xterm-mouse-mode 1)

  (require 'clipetty)
  (global-clipetty-mode +1)

  (global-set-key (kbd "<f7>") 'spartan-paste-mode))

(or window-system
    (progn
      (add-to-list 'spartan-package-list 'clipetty)
      (add-hook 'after-init-hook 'spartan-emacs-nw-hook)))

(provide 'spartan-emacs-nw)
