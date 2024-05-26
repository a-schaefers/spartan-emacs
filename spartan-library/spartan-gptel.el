;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; https://github.com/karthink/gptel

;; M-x gptel to open interactive buffer
;; C-c RET runs gptel-send to interact

(use-package gptel
 :straight t
 :defer t
 :config
 (setq gptel-model "gpt-3.5-turbo")
 ;; (setq gptel-model "gpt-4-turbo")

 ;; obtain API key from https://platform.openai.com/
 ;; spartan.d is gitignored, but be sure not to store this file in git if you override that in some way.
 ;; A better option is the .authinfo method, described here https://github.com/karthink/gptel?tab=readme-ov-file#chatgpt
 (setq gptel-api-key "YOUR_KEY_HERE"))
