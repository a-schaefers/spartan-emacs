;; nano-emacs.el --- NANO Emacs (minimal version)     -*- lexical-binding: t -*-

;; Copyright (c) 2025  Nicolas P. Rougier
;; Released under the GNU General Public License 3.0
;; Author: Nicolas P. Rougier <nicolas.rougier@inria.fr>
;; URL: https://github.com/rougier/nano-emacs

;; This is NANO Emacs in 256 lines, without any dependency
;; Usage (command line):  emacs -Q -l nano.el -[light|dark]

;; --- Speed benchmarking -----------------------------------------------------
(setq init-start-time (current-time))

;; --- Typography stack -------------------------------------------------------
(set-face-attribute 'default nil
                    :height 140 :weight 'light :family "Roboto Mono")
(set-face-attribute 'bold nil :weight 'regular)
(set-face-attribute 'bold-italic nil :weight 'regular)
(set-display-table-slot standard-display-table 'truncation (make-glyph-code ?…))
(set-display-table-slot standard-display-table 'wrap (make-glyph-code ?–))

;; --- Frame / windows layout & behavior --------------------------------------
(setq default-frame-alist
      '((height . 44) (width  . 81) (left-fringe . 0) (right-fringe . 0)
        (internal-border-width . 32) (vertical-scroll-bars . nil)
        (bottom-divider-width . 0) (right-divider-width . 0)
        (undecorated-round . nil)))
(modify-frame-parameters nil default-frame-alist)
;; (setq-default pop-up-windows t)

;; --- Activate / Deactivate modes --------------------------------------------
(tool-bar-mode -1) (menu-bar-mode -1) (blink-cursor-mode -1)
(global-hl-line-mode 1) ;(icomplete-vertical-mode 1)
(pixel-scroll-precision-mode 1)

;; --- Minimal NANO (not a real) theme ----------------------------------------
(defface nano-default '((t)) "")   (defface nano-default-i '((t)) "")
(defface nano-highlight '((t)) "") (defface nano-highlight-i '((t)) "")
(defface nano-subtle '((t)) "")    (defface nano-subtle-i '((t)) "")
(defface nano-faded '((t)) "")     (defface nano-faded-i '((t)) "")
(defface nano-salient '((t)) "")   (defface nano-salient-i '((t)) "")
(defface nano-popout '((t)) "")    (defface nano-popout-i '((t)) "")
(defface nano-strong '((t)) "")    (defface nano-strong-i '((t)) "")
(defface nano-critical '((t)) "")  (defface nano-critical-i '((t)) "")

(defun nano-set-face (name &optional foreground background weight)
  "Set NAME and NAME-i faces with given FOREGROUND, BACKGROUND and WEIGHT"

  (apply #'set-face-attribute `(,name nil
                                ,@(when foreground `(:foreground ,foreground))
                                ,@(when background `(:background ,background))
                                ,@(when weight `(:weight ,weight))))
  (apply #'set-face-attribute `(,(intern (concat (symbol-name name) "-i")) nil
                                :foreground ,(face-background 'nano-default)
                                ,@(when foreground `(:background ,foreground))
                                :weight regular)))

(defun nano-link-face (sources faces &optional attributes)
  "Make FACES to inherit from SOURCES faces and unspecify ATTRIBUTES."

  (let ((attributes (or attributes
                        '( :foreground :background :family :weight
                           :height :slant :overline :underline :box))))
    (dolist (face (seq-filter #'facep faces))
      (dolist (attribute attributes)
        (set-face-attribute face nil attribute 'unspecified))
      (set-face-attribute face nil :inherit sources))))

(defun nano-install-theme ()
  "Install THEME"

  (set-face-attribute 'default nil
                      :foreground (face-foreground 'nano-default)
                      :background (face-background 'nano-default))
  (dolist (item '((nano-default .  (variable-pitch variable-pitch-text
                                    fixed-pitch fixed-pitch-serif))
                  (nano-highlight . (hl-line highlight))
                  (nano-subtle .    (match region
                                     lazy-highlight widget-field))
                  (nano-faded .     (shadow
                                     font-lock-comment-face
                                     font-lock-doc-face
                                     icomplete-section
                                     completions-annotations))
                  (nano-popout .    (warning
                                     font-lock-string-face))
                  (nano-salient .   (success link
                                     help-argument-name
                                     custom-visibility
                                     font-lock-type-face
                                     font-lock-keyword-face
                                     font-lock-builtin-face
                                     completions-common-part))
                  (nano-strong .    (font-lock-function-name-face
                                     font-lock-variable-name-face
                                     icomplete-first-match
                                     minibuffer-prompt))
                  (nano-critical .  (error
                                     completions-first-difference))
                  (nano-faded-i .   (help-key-binding))
                  (nano-default-i . (custom-button-mouse
                                     isearch))
                  (nano-critical-i . (isearch-fail))
                  ((nano-subtle nano-strong) . (custom-button
                                                icomplete-selected-match))
                  ((nano-faded-i nano-strong) . (show-paren-match))))
    (nano-link-face (car item) (cdr item)))

  ;; Mode & header lines
  (set-face-attribute 'header-line nil
                      :background 'unspecified
                      :underline nil
                      :box `( :line-width 1
                              :color ,(face-background 'nano-default))
                      :inherit 'nano-subtle)
  (set-face-attribute 'mode-line nil
                      :background (face-background 'default)
                      :underline (face-foreground 'nano-faded)
                      :height 40 :overline nil :box nil)
  (set-face-attribute 'mode-line-inactive nil
                      :background (face-background 'default)
                      :underline (face-foreground 'nano-faded)
                      :height 40 :overline nil :box nil))

(defun nano-light (&rest args)
  "NANO light theme (based on material colors)"

  (interactive)
  (nano-set-face 'nano-default "#37474F" "#FFFFFF") ;; Blue Grey / L800
  (nano-set-face 'nano-strong "#000000" nil 'regular) ;; Black
  (nano-set-face 'nano-highlight nil "#FAFAFA") ;; Very Light Grey
  (nano-set-face 'nano-subtle nil "#ECEFF1") ;; Blue Grey / L50
  (nano-set-face 'nano-faded "#90A4AE") ;; Blue Grey / L300
  (nano-set-face 'nano-salient "#673AB7") ;; Deep Purple / L500
  (nano-set-face 'nano-popout "#FFAB91") ;; Deep Orange / L200
  (nano-set-face 'nano-critical "#FF6F00") ;; Amber / L900
  (nano-install-theme))

(defun nano-dark (&rest args)
  "NANO dark theme (based on nord colors)"

  (interactive)
  (nano-set-face 'nano-default "#ECEFF4" "#2E3440") ;; Snow Storm 3
  (nano-set-face 'nano-strong "#ECEFF4" nil 'regular) ;; Polar Night 0
  (nano-set-face 'nano-highlight nil "#3B4252")  ;; Polar Night 1
  (nano-set-face 'nano-subtle nil "#434C5E") ;; Polar Night 2
  (nano-set-face 'nano-faded "#677691") ;;
  (nano-set-face 'nano-salient "#81A1C1")  ;; Frost 2
  (nano-set-face 'nano-popout "#D08770") ;; Aurora 1
  (nano-set-face 'nano-critical "#EBCB8B") ;; Aurora 2
  (nano-install-theme))

;; --- Command line theme chooser ---------------------------------------------
(add-to-list 'command-switch-alist '("-dark"  . nano-dark))
(add-to-list 'command-switch-alist '("-light" . nano-light))
(if (member "-dark" command-line-args) (nano-dark) (nano-light))

;; --- Minibuffer completion --------------------------------------------------
;; (setq tab-always-indent 'complete
;;       icomplete-delay-completions-threshold 0
;;       icomplete-compute-delay 0
;;       icomplete-show-matches-on-no-input t
;;       icomplete-hide-common-prefix nil
;;       icomplete-prospects-height 9
;;       icomplete-separator " . "
;;       icomplete-with-completion-tables t
;;       icomplete-in-buffer t
;;       icomplete-max-delay-chars 0
;;       icomplete-scroll t
;;       resize-mini-windows 'grow-only
;;       icomplete-matches-format nil)
;; (bind-key "TAB" #'icomplete-force-complete icomplete-minibuffer-map)
;; (bind-key "RET" #'icomplete-force-complete-and-exit icomplete-minibuffer-map)

;; --- Minimal key bindings ---------------------------------------------------
;; (defun nano-quit ()
;;   "Quit minibuffer from anywhere (code from Protesilaos Stavrou)"

;;   (interactive)
;;   (cond ((region-active-p) (keyboard-quit))
;;         ((derived-mode-p 'completion-list-mode) (delete-completion-window))
;;         ((> (minibuffer-depth) 0) (abort-recursive-edit))
;;         (t (keyboard-quit))))

;; (defun nano-kill ()
;;   "Delete frame or kill emacs if there is only one frame left"

;;   (interactive)
;;   (condition-case nil
;;       (delete-frame)
;;     (error (save-buffers-kill-terminal))))

;; (bind-key "C-x k" #'kill-current-buffer)
;; (bind-key "C-x C-c" #'nano-kill)
;; (bind-key "C-x C-r" #'recentf-open)
;; (bind-key "C-g" #'nano-quit)
;; (bind-key "M-n" #'make-frame)
;; (bind-key "C-z"  nil) ;; No suspend frame
;; (bind-key "C-<wheel-up>" nil) ;; No text resize via mouse scroll
;; (bind-key "C-<wheel-down>" nil) ;; No text resize via mouse scroll

;; --- Sane settings ----------------------------------------------------------
;; (set-default-coding-systems 'utf-8)
;; (setq-default indent-tabs-mode nil
;;               ring-bell-function 'ignore
;;               select-enable-clipboard t)

;; --- OSX Specific -----------------------------------------------------------
;; (when (eq system-type 'darwin)
;;   (select-frame-set-input-focus (selected-frame))
;;   (setq mac-option-modifier nil
;;         ns-function-modifier 'super
;;         mac-right-command-modifier 'hyper
;;         mac-right-option-modifier 'alt
;;         mac-command-modifier 'meta))

;; --- Header & mode lines ----------------------------------------------------
(setq-default mode-line-format "")
(setq-default header-line-format
  '(:eval
    (let ((prefix (cond (buffer-read-only     '("RO" . nano-default-i))
                        ((buffer-modified-p)  '("**" . nano-critical-i))
                        (t                    '("RW" . nano-faded-i))))
          (mode (concat "(" (downcase (cond ((consp mode-name) (car mode-name))
                                            ((stringp mode-name) mode-name)
                                            (t "unknow")))
                        " mode)"))
          (coords (format-mode-line "%c:%l ")))
      (list
       (propertize " " 'face (cdr prefix)  'display '(raise -0.25))
       (propertize (car prefix) 'face (cdr prefix))
       (propertize " " 'face (cdr prefix) 'display '(raise +0.25))
       (propertize (format-mode-line " %b ") 'face 'nano-strong)
       (propertize mode 'face 'header-line)
       (propertize " " 'display `(space :align-to (- right ,(length coords))))
       (propertize coords 'face 'nano-faded)))))

;; --- Minibuffer setup -------------------------------------------------------
;; (defun nano-minibuffer--setup ()
;;   (set-window-margins nil 3 0)
;;   (let ((inhibit-read-only t))
;;     (add-text-properties (point-min) (+ (point-min) 1)
;;       `(display ((margin left-margin)
;;                  ,(format "# %s" (substring (minibuffer-prompt) 0 1))))))
;;   (setq truncate-lines t))
;; (add-hook 'minibuffer-setup-hook #'nano-minibuffer--setup)

;; --- Speed benchmarking -----------------------------------------------------
(let ((init-time (float-time (time-subtract (current-time) init-start-time)))
      (total-time (string-to-number (emacs-init-time "%f"))))
  (message (concat
    (propertize "Startup time: " 'face 'bold)
    (format "%.2fs " init-time)
    (propertize (format "(+ %.2fs system time)"
                        (- total-time init-time)) 'face 'shadow))))

(provide 'nano-minimal)
