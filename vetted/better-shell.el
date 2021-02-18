;;; better-shell.el --- Better shell management
;; Copyright (C) 2016 Russell Black

;; Author: Russell Black (killdash9@github)
;; Keywords: convenience
;; URL: https://github.com/killdash9/better-shell
;; Created: 1st Mar 2016
;; Version: 1.2.1
;; Package-Requires: ((emacs "24.4"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; 
;; This package simplifies shell management and sudo access by providing
;; the following commands.
;; 
;; `better-shell-shell'
;; --------------------
;; 
;; Cycle through existing shell buffers, in order of recent use.  If
;; there are no shells, one is created.
;; 
;; With C-u prefix arg, invoke `better-shell-for-current-dir'.
;; 
;; `better-shell-for-current-dir'
;; ------------------------------
;; 
;; Bring up a shell on the same host and in the same directory as the
;; current buffer, choosing an existing shell if possible.  The shell
;; chosen is guaranteed to be idle (not currently running a command).  It
;; first looks for an idle shell that is already in the buffer's
;; directory.  If none is found, it looks for another idle shell on the
;; same host as the buffer.  If one is found, that shell is selected and
;; automatically placed into the buffer's directory with a `cd` command.
;; Otherwise, a new shell is created on the same host and in the same
;; directory as the buffer.
;; 
;; `better-shell-remote-open'
;; --------------------------
;; 
;; Open a shell on a remote server, allowing you to choose from any host
;; you've previously logged into (uses your ~/.ssh/known_hosts file) or
;; enter a new host.  With C-u prefix arg, get sudo shell.
;; 
;; `better-shell-sudo-here'
;; --------------------------
;; 
;; Reopen the current file, directory, or shell as root.

;;; Code:
(require 'cl-lib)
(require 'tramp)
(require 'shell)

(defun better-shell-idle-p (buf)
  "Return t if the shell in BUF is not running something.
When available, use process hierarchy information via pstree for
local shells.  Otherwise, we ask comint if the point is after a
prompt."
  (with-current-buffer buf
    (let ((comint-says-idle (and
                             (> (point) 1) ;; if point > 1
                             ;; see if previous char has the prompt face
                             (equal '(comint-highlight-prompt)
                                    (get-text-property
                                     (- (point) 1) 'font-lock-face)))))
      (if (file-remote-p default-directory)
          ;; for remote shells we have to rely on comint
          comint-says-idle
        ;; for local shells, we can potentially do better using pgrep
        (condition-case nil
            (case (call-process ;; look at the exit code of pgrep -P <pid>
                   "pgrep" nil nil nil "-P"
                   (number-to-string (process-id (get-buffer-process buf))))
              (0 nil) ;; child procxesses found, not idle
              (1 t)   ;; not running any child processes, it's idle
              (t comint-says-idle)) ;; anything else, fall back on comint.
          (error comint-says-idle)))))) ;; comint fallback if execution failed

(defun better-shell-shells ()
  "Return a list of buffers running shells."
  (cl-remove-if-not
   (lambda (buf)
     (and
      (get-buffer-process buf)
      (with-current-buffer buf
        (string-equal major-mode 'shell-mode))))
   (buffer-list)))

(defun better-shell-idle-shells (remote-host)
  "Return all the buffers with idle shells on REMOTE-HOST.
If REMOTE-HOST is nil, returns a list of idle local shells."
  (let ((current-buffer (current-buffer)))
    (cl-remove-if-not
     (lambda (buf)
       (with-current-buffer buf
         (and
          (string-equal (file-remote-p default-directory) remote-host)
          (better-shell-idle-p buf)
          (not (eq current-buffer buf)))))
     (better-shell-shells))))

(defun better-shell-default-directory (buf)
  "Return the default directory for BUF."
  (with-current-buffer buf
    default-directory))

(defun better-shell-for-current-dir ()
  "Find or create a shell in the buffer's directory.
See `better-shell-for-dir' for details on how shells are found or created."
  (interactive)
  (better-shell-for-dir default-directory))

(defun better-shell-for-dir (dir)
  "Find or create a shell in DIR.
The shell chosen is guaranteed to be idle (not running another
command).  It first looks for an idle shell that is already in
the buffer's directory.  If none is found, it looks for another
idle shell on the same host as the buffer.  If one is found, that
shell will be chosen, and automatically placed into the buffer's
directory with a \"cd\" command.  Otherwise, a new shell is
created in the buffer's directory."
  (interactive "D")
  (let ((idle-shell
         (or
          ;; get currently idle shells, ones with matching directory
          ;; first.
          (car (sort
                (better-shell-idle-shells
                 (file-remote-p default-directory))
                (lambda (s1 s2)
                  (string-equal dir (better-shell-default-directory s1)))))
          ;; make a new shell if there are none
          (shell (generate-new-buffer-name
                  (if (file-remote-p dir)
                      (with-parsed-tramp-file-name dir nil
                        (format "*shell/%s*" host))
                    "*shell*"))))))

    ;; cd in the shell if needed
    (when (not (string-equal dir (better-shell-default-directory idle-shell)))
      (let ((localdir (if (file-remote-p dir)
                          (with-parsed-tramp-file-name dir nil localname)
                        (expand-file-name dir))))
        (with-current-buffer idle-shell
          (comint-delete-input)
          (goto-char (point-max))
          (insert (concat "cd \"" localdir "\""))
          (comint-send-input))))

    ;; now we have an idle shell in the correct directory.  Pop to it.
    (pop-to-buffer idle-shell)))

(defun better-shell-tramp-hosts ()
  "Ask tramp for a list of hosts that we can reach through ssh."
  (cl-reduce 'append
             (mapcar (lambda (x)
                       (cl-remove nil (mapcar 'cadr (apply (car x) (cdr x)))))
                     (tramp-get-completion-function "scp"))))

;;;###autoload
(defun better-shell-remote-open (&optional arg)
  "Prompt for a remote host to connect to, and open a shell
there.  With prefix argument, get a sudo shell."
  (interactive "p")
  (let*
      ((hosts
        (cl-reduce 'append
                (mapcar
                 (lambda (x)
                   (cl-remove nil (mapcar 'cadr (apply (car x) (cdr x)))))
                 (tramp-get-completion-function "ssh"))))
       (remote-host (completing-read "Remote host: " hosts)))
    (if (and arg (= 4 arg))
        ;; this means sudo
        (let ((tramp-default-proxies-alist nil))
          ;; so that you don't get method overrides.  ssh is the only one that works for sudo.
          (with-temp-buffer
            (cd (concat "/ssh:" remote-host "|sudo:" remote-host ":"))
            (shell (format "*shell/sudo:%s*" remote-host))))
      ;; non-sudo
      (with-temp-buffer
        (cd (concat "/" (or tramp-default-method "ssh") ":" remote-host ":"))
        (shell (format "*shell/%s*" remote-host))))))

;;;###autoload
(defun better-shell-sudo-here ()
  "Reopen the current file, directory, or shell as root.
For files and dired buffers, the non-sudo buffer is replaced with
a sudo buffer.  For shells, a sudo shell is opened but the
non-sudo shell is left in tact."
  (interactive)
  (let ((f (expand-file-name (or buffer-file-name default-directory))))
    (when (string-match-p "\\bsudo:" f) (user-error "Already sudo"))
    (let ((sudo-f (if (file-remote-p f)
                      (with-parsed-tramp-file-name f nil
			(let ((user-string
			       (when user (concat user "@"))))
			  (concat "/ssh:" user-string host "|sudo:" host ":" localname)))
                    (concat "/sudo:localhost:" f)))
          (tramp-default-proxies-alist nil)
          ;; so that you don't get method overrides.  ssh is the only one that works for sudo.
          )
      (unless f (user-error "No file or default directory in this
      buffer.  This command can only be used in file buffers,
      dired buffers, or shell buffers"))
      (cond ((or buffer-file-name (eq major-mode 'dired-mode))
             (find-alternate-file sudo-f))
            ((eq major-mode 'shell-mode)
             (with-temp-buffer
               (cd sudo-f)
               (shell (format "*shell/sudo:%s*"
                              (with-parsed-tramp-file-name sudo-f nil host)))))
            (t (message "Can't sudo this buffer"))
            ))))

(defun better-shell-existing-shell ()
  "Switch to the next existing shell in the stack."
  (interactive)
  ;; rotate through existing shells
  (let* ((shells (better-shell-shells))
         (buf (nth (mod (+ (or (cl-position (current-buffer) shells) -1) 1)
                        (length shells))
                   shells)))
    (switch-to-buffer buf t)
    (set-transient-map                ; Read next key
     `(keymap (,(elt (this-command-keys-vector) 0) .
               better-shell-existing-shell))
     t (lambda () (switch-to-buffer (current-buffer))))))

;;;###autoload
(defun better-shell-shell (&optional arg)
  "Pop to an appropriate shell.
Cycle through all the shells, most recently used first.  When
called with a prefix ARG, finds or creates a shell in the current
directory."
  (interactive "p")
  (let ((shells (better-shell-shells)))
    (if (or (null shells) (and arg (= 4 arg)))
        (better-shell-for-current-dir)
      (better-shell-existing-shell))))

;;;###autoload
(defun better-shell-for-projectile-root ()
  "Find or create a shell in the projectile root.
See `better-shell-for-dir' for details on how shells are found or created."
  (interactive)
  (unless (fboundp 'projectile-project-root)
    (error "Projectile does not appear to be installed"))
  (better-shell-for-dir (projectile-project-root)))

(provide 'better-shell)
;;; better-shell.el ends here
