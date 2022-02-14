;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects gems 'irb' 'rdo'c 'solargraph', recommended 'pry' for setting breakpoints

(add-to-list 'spartan-package-list 'inf-ruby)

(when (executable-find "solargraph")
        (with-eval-after-load 'eglot
          (add-hook 'ruby-mode-hook 'eglot-ensure)))

(with-eval-after-load 'ruby-mode
  (define-key ruby-mode-map (kbd "M-m rr") 'ruby-send-region)
  (define-key ruby-mode-map (kbd "M-m rb") 'ruby-send-buffer)
  (define-key ruby-mode-map (kbd "M-m rR") 'inf-ruby))

(defun our-ruby-cfg ()
  (interactive)
  ;; Thx https://github.com/bbatsov/prelude/blob/master/modules/prelude-ruby.el
  ;; We never want to edit Rubinius bytecode
  (add-to-list 'completion-ignored-extensions ".rbc")
  ;; Don't auto-insert encoding comments
  ;; Those are almost never needed in Ruby 2+
  (setq ruby-insert-encoding-magic-comment nil)
  (inf-ruby-minor-mode +1)
  ;; CamelCase aware editing operations
  (subword-mode +1))

(add-hook 'ruby-mode-hook 'our-ruby-cfg)

(provide 'spartan-ruby)
