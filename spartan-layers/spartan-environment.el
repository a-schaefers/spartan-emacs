;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; Explicitly set an Emacs environment as desired.
;; NO MORE editing .bash_profile or whatever or messing with packages like `exec-path-from-shell' !

(require 'subr-x)

;; if EDITOR is not set already, set it.
(or (getenv "EDITOR")
    (progn
      (setenv "EDITOR" "emacsclient")
      (setenv "VISUAL" (getenv "EDITOR"))))

;; if PAGER is not set already, set it
(or (getenv "PAGER")
    (setenv "PAGER" "cat"))

;; 'PATH' modifications

(setq spartan-path-insert '(
                            "~/bin"
                            "~/.local/bin"
                            ))

(setq spartan-path-append '(
                            ;; "~/Put/To/End/Of/PATH"
                            ))

;; Help out MacOS users to make dev env more like-linux
;; HINT: brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep

(when (file-directory-p "/opt/homebrew")
  (setq gnubin-locations
        (split-string (shell-command-to-string "find /opt/homebrew -name \"*gnubin*\" -type d") "\n" t))
  (add-to-list 'gnubin-locations "/opt/homebrew/bin" t)
  (add-to-list 'gnubin-locations "/opt/homebrew/sbin" t)

  (dolist (item gnubin-locations)
    (add-to-list 'spartan-path-insert item)))

;; SET matching exec-path and 'PATH' values with inserts/appends

(dolist (item spartan-path-insert)
  (add-to-list 'exec-path item))

(dolist (item spartan-path-append)
  (add-to-list 'exec-path item t))

(setenv "PATH" (string-trim-right (string-join exec-path ":") ":$"))

(provide 'spartan-environment)
