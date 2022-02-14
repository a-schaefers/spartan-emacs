;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects 'python-language-server'

;;Thx https://github.com/bbatsov/prelude/blob/master/modules/prelude-c.el
(defun prelude-c-mode-common-defaults ()
  (setq c-default-style "k&r"
        c-basic-offset 4)
  (c-set-offset 'substatement-open 0))

(setq prelude-c-mode-common-hook 'prelude-c-mode-common-defaults)

(defun prelude-makefile-mode-defaults ()
  (whitespace-toggle-options '(tabs))
  (setq indent-tabs-mode t ))

(setq prelude-makefile-mode-hook 'prelude-makefile-mode-defaults)

(add-hook 'makefile-mode-hook (lambda ()
                                (run-hooks 'prelude-makefile-mode-hook)))

;; this will affect all modes derived from cc-mode, like
;; java-mode, php-mode, etc
(add-hook 'c-mode-common-hook (lambda ()
                                (run-hooks 'prelude-c-mode-common-hook)))
;;/Thx

(when (executable-find "clangd")
  (with-eval-after-load 'eglot
    (add-hook 'c-mode-hook 'eglot-ensure)))

(provide 'spartan-python)
