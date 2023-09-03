;;; -*- lexical-binding: t; no-byte-compile: t; -*-

;; install theme(s)

(defmacro spartan-install-themes (&rest packages)
  ;; Thanks https://emacs.stackexchange.com/questions/32744/dynamic-package-name-with-use-package
      (declare (indent defun))
      (macroexp-progn
       (mapcar (lambda (package)
                 `(use-package ,package :straight t :demand))
               packages)))

;; remove hostname from the GUI titlebar
(setq-default frame-title-format '("Emacs"))

;; simple mode-line

;; https://emacs.stackexchange.com/questions/5529/how-to-right-align-some-items-in-the-modeline
(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT, and RIGHT
 aligned respectively."
  (let* ((available-width (- (window-width) (length left) 2)))
    (format (format " %%s %%%ds " available-width) left right)))

(setq-default mode-line-format
      '((:eval (simple-mode-line-render
                ;; left
                (format-mode-line "%* %b %l")
                ;; right
                (format-mode-line "%m")))))

;; ;; modeline to top

;; (setq-default header-line-format mode-line-format)
;; (setq-default mode-line-format nil)

;; a glorious scratch message

  (setq initial-scratch-message "
; _______  _____  _______  ______ _______ _______
; |______ |_____] |_____| |_____/    |    |_____|
; ______| |       |     | |    \\_    |    |     |

")

;; better scratch https://www.reddit.com/r/emacs/comments/4cmfwp/scratch_buffer_hacks_to_increase_its_utility/

(defun immortal-scratch ()
  (if (eq (current-buffer) (get-buffer "*scratch*"))
      (progn (bury-buffer)
             nil)
  t))

(add-hook 'kill-buffer-query-functions 'immortal-scratch)

(defun save-persistent-scratch ()
  "Save the contents of *scratch*"
  (with-current-buffer (get-buffer-create "*scratch*")
    (write-region (point-min) (point-max)
                  (concat user-emacs-directory "scratch"))))

(defun load-persistent-scratch ()
  "Reload the scratch buffer"
  (let ((scratch-file (concat user-emacs-directory "scratch")))
    (if (file-exists-p scratch-file)
        (with-current-buffer (get-buffer "*scratch*")
          (delete-region (point-min) (point-max))
          (insert-file-contents scratch-file)))))

(add-hook 'after-init-hook 'load-persistent-scratch)
(add-hook 'kill-emacs-hook 'save-persistent-scratch)

(run-with-idle-timer 300 t 'save-persistent-scratch)

(provide 'spartan-theme)
