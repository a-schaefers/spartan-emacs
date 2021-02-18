;;; flymake-shellcheck.el --- A bash/sh Flymake backend powered by ShellCheck  -*- lexical-binding: t; -*-

;; Copyright (c) 2018 Federico Tedin
;; Copyright (c) 2020 Joseph LaFreniere (lafrenierejm) <joseph@lafreniere.xyz>

;; Author: Federico Tedin <federicotedin@gmail.com>
;; Homepage: https://github.com/federicotdn/flymake-shellcheck
;; Package-Version: 0.1
;; Package-Requires: ((emacs "26"))

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

;; Based in part on:
;;   https://www.gnu.org/software/emacs/manual/html_node/flymake/An-annotated-example-backend.html
;;
;; Usage:
;;   (add-hook 'sh-mode-hook 'flymake-shellcheck-load)

;;; Code:

(defgroup flymake-shellcheck nil
  "Shellcheck backend for Flymake."
  :prefix "flymake-shellcheck-"
  :group 'tools)

(defcustom flymake-shellcheck-path
  (executable-find "shellcheck")
  "The path to the `shellcheck' executable."
  :type 'string)

(defcustom flymake-shellcheck-use-file t
  "When non-nil, send the contents of the file on disk to shellcheck.
Otherwise, send the contents of the buffer, whether they have been
saved or not.

Setting this variable to non-nil may yield slightly quicker syntax
checks on very large files."
  :type 'boolean)

(defvar-local flymake-shellcheck--proc nil)

(defun flymake-shellcheck--backend (report-fn &rest _args)
  "Shellcheck backend for Flymake.  Check for problems, then call REPORT-FN with results."
  (unless (and flymake-shellcheck-path
               (file-executable-p flymake-shellcheck-path))
    (error "Could not find shellcheck executable"))

  (when (process-live-p flymake-shellcheck--proc)
    (kill-process flymake-shellcheck--proc)
    (setq flymake-shellcheck--proc nil))

  (let* ((source (current-buffer))
	     (filename (buffer-file-name source)))
    (save-restriction
      (widen)
      (setq
       flymake-shellcheck--proc
       (make-process
        :name "shellcheck-flymake" :noquery t :connection-type 'pipe
        :buffer (generate-new-buffer " *shellcheck-flymake*")
        :command (list flymake-shellcheck-path
                       "-f" "gcc"
                       (if flymake-shellcheck-use-file filename "-"))
        :sentinel
        (lambda (proc _event)
          (when (eq 'exit (process-status proc))
            (unwind-protect
                (if (with-current-buffer source (eq proc flymake-shellcheck--proc))
                    (with-current-buffer (process-buffer proc)
                      (goto-char (point-min))
                      (cl-loop
                       while (search-forward-regexp
                              "^.+?:\\([0-9]+\\):\\([0-9]+\\): \\(.*\\): \\(.*\\)$"
                              nil t)
		               for severity = (match-string 3)
                       for msg = (match-string 4)
                       for (beg . end) = (flymake-diag-region
                                          source
                                          (string-to-number (match-string 1))
					                      (string-to-number (match-string 2)))
                       for type = (cond ((string= severity "note") :note)
					                    ((string= severity "warning") :warning)
					                    (t :error))
                       collect (flymake-make-diagnostic source
                                                        beg
                                                        end
                                                        type
                                                        msg)
                       into diags
                       finally (funcall report-fn diags)))
                  (flymake-log :warning "Canceling obsolete check %s"
                               proc))
              (kill-buffer (process-buffer proc)))))))
      (unless flymake-shellcheck-use-file
        (process-send-region flymake-shellcheck--proc (point-min) (point-max))
        (process-send-eof flymake-shellcheck--proc)))))

;;;###autoload
(defun flymake-shellcheck-load ()
  "Add the Shellcheck backend into Flymake's diagnostic functions list."
  (add-hook 'flymake-diagnostic-functions 'flymake-shellcheck--backend nil t))

(provide 'flymake-shellcheck)
;;; flymake-shellcheck.el ends here
