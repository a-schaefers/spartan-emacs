;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; expects gems 'irb' 'rdoc' 'solargraph', recommended 'pry' for setting breakpoints
;; usage: can't find a good doc, M-x ruby and look around

(add-to-list 'spartan-package-list 'inf-ruby)

(when (executable-find "solargraph")
        (with-eval-after-load 'eglot
          (add-hook 'ruby-mode-hook 'eglot-ensure)))

(add-hook 'makefile-mode-hook (lambda ()
                                ;; Thx https://github.com/bbatsov/prelude
                                ;; We never want to edit Rubinius bytecode
                                (add-to-list 'completion-ignored-extensions ".rbc")
                                ;; Don't auto-insert encoding comments
                                ;; Those are almost never needed in Ruby 2+
                                (setq ruby-insert-encoding-ma gic-comment nil)
                                (inf-ruby-minor-mode +1)
                                ;; CamelCase aware editing operations
                                (subword-mode +1)))

(provide 'spartan-ruby)
