;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/ethereum/emacs-solidity

(add-to-list 'spartan-package-list 'solidity-mode)

(with-eval-after-load 'solidity-mode
  ;; (setq solidity-comment-style 'slash)
  (setq solidity-comment-style 'star)

  (define-key solidity-mode-map (kbd "M-m g") 'solidity-estimate-gas-at-point))

;; https://blog.soliditylang.org/2021/12/20/solidity-0.8.11-release-announcement/
;; The LSP is currently only implemented for the native binary of Solidity (i.e. it does not work if you install Solidity via javascript / npm). You need to download the binary and provide the path to your IDE, plus the option --lsp.

(when (executable-find "solc")
        (with-eval-after-load 'eglot
          ;; (setq solidity-solc-path "/home/lefteris/ew/cpp-ethereum/build/solc/solc")
          (add-to-list 'eglot-server-programs
                   `(solidity-mode . ("solc" "--lsp")))
          (add-hook 'solidity-mode-hook 'eglot-ensure)))

(provide 'spartan-solidity)
