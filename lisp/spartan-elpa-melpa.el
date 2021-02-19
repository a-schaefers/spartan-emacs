;;; -*- lexical-binding: t; -*-

(setq package-list '(
                     magit ;; pulls in dash, with-editor, transient

                     eglot ;; only requires Emacs.
                     ))

(require 'package)

;; Prefer GNU ELPA > MELPA [stable] (fallback)
(setq package-archives
      '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
        ("MELPA Stable" . "https://stable.melpa.org/packages/"))
      package-archive-priorities
      '(("GNU ELPA"     . 10)
        ("MELPA Stable" . 5)))

(setq package-enable-at-startup nil)

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'magit)
(require 'eglot)

(provide 'spartan-elpa-melpa)
