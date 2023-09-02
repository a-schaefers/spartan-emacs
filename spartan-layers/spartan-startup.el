;;; -*- lexical-binding: t; no-byte-compile: t; -*-

(setq load-prefer-newer t)

(add-hook 'after-init-hook #'(lambda ()
                               (interactive)
                               (require 'server)
                               (or (server-running-p)
                                   (server-start))))

(provide 'spartan-startup)
