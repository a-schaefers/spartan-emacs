;;; -*- lexical-binding: t; -*-

(with-eval-after-load 'spartan-vetted
  (require 'ido-completing-read+)
  (require 'amx)

  (setq ido-create-new-buffer 'always
        ido-auto-merge-work-directories-length -1
        ido-enable-flex-matching t
        ido-use-filename-at-point 'guess
        ido-use-faces nil)

  (with-eval-after-load 'ido-completing-read+
    (ido-ubiquitous-mode 1))

  (with-eval-after-load 'amx
    (setq amx-ignored-command-matchers nil
          amx-show-key-bindings nil)
    (amx-mode 1)))

(provide 'spartan-ido)
