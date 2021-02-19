;;; -*- lexical-binding: t; -*-

(setq c-default-style "linux")
(add-hook 'c-mode-hook
          (lambda () (setq indent-tabs-mode t)))

(provide 'spartan-c)
