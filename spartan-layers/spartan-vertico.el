;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; Really good minibuffer completion, with ido-like extension

(use-package vertico
  :ensure t ;(:files (:defaults "extensions/*"))
  :bind ( :map vertico-map
          ("RET" . vertico-directory-enter)
          ("DEL" . vertico-directory-delete-char)
          ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy)
  :defer t
  :init
  (vertico-mode 1))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(savehist-mode 1)

;; A few more useful configurations...

(defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t)

;; fuzz

(use-package prescient
  :ensure t)

(use-package vertico-prescient
  :after (vertico prescient)
  :ensure (:wait t)
  :init (vertico-prescient-mode 1)
  :config (prescient-persist-mode 1))

(provide 'spartan-vertico)
