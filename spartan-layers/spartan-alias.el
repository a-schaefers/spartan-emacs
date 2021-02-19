;;; -*- lexical-binding: t; -*-

(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'sh 'better-shell-for-current-dir)
(defalias 'ff 'find-name-dired)
(defalias 'gf 'grep)
(defalias 'git 'magit)
(defalias 'lint 'flymake-show-diagnostics-buffer)
(defalias 'ed 'ediff)
(defalias 'tbb 'buffer-to-termbin)
(defalias 'tbr 'region-to-termbin)
(defalias 'kr 'browse-kill-ring)

(provide 'spartan-alias)
