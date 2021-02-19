;;; -*- lexical-binding: t; -*-

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

(add-hook 'after-init-hook (lambda ()
                             (unless package-archive-contents
                                 (package-refresh-contents))

                               (dolist (package spartan-package-list)
                                 (unless (package-installed-p package)
                                   (package-install package)))))

(provide 'spartan-elpa-melpa)
