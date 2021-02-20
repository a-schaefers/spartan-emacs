;;; termbin.el --- Use termbin.com from emacs        -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Nicolas Richard

;; Author: Nicolas Richard <youngfrog@members.fsf.org>
;; Keywords: convenience, tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 1. Select region
;; 2. M-x yf/termbin-region
;; 3. ??? (magic happens)
;; 4. Yank the url with C-y

;;; Code:


(defgroup yf/termbin nil
  "Group for customizing termbin.el")

(defcustom yf/termbin-host "termbin.com"
  "Address for termbin.com"
  :group 'yf/termbin)
(defcustom yf/termbin-port 9999
  "Port number for termbin.com"
  :group 'yf/termbin)
(defcustom yf/termbin-url-regexp "\\(https://termbin.com/[[:alnum:]]+\\)\n\0"
  "Regular expression for the returned URL"
  :group 'yf/termbin)

(defun yf/termbin-region--buffer-has-valid-url (buf)
  "Check if BUF has a valid termbin.com URL, and return it"
  (save-excursion
    (set-buffer buf)
    (save-match-data
      (goto-char (point-min))
      (and (looking-at yf/termbin-url-regexp)
           (match-string 1)))))

(defun yf/termbin-region--sentinel (proc what callback)
  "Check if the buffer of PROC has a URL and feed it to CALLBACK"
  (let* ((buf (process-buffer proc))
         (valid-url (yf/termbin-region--buffer-has-valid-url buf)))
    (if (not valid-url)
        (error "Process changed that and I  don't know what to do: %s\nBuffer content: %s"
               what
               (with-current-buffer (process-buffer proc)))
      (kill-buffer buf)
      (funcall callback valid-url))))

(defun yf/termbin-region-async (beg end callback)
  "Send the region to termbin.com and feed the resulting url to CALLBACK"
  (let* ((procname "*termbin*")
         (temp-buffer (generate-new-buffer " *temp for termbin*"))
         (proc (make-network-process :name procname
                                     :buffer temp-buffer
                                     :host yf/termbin-host
                                     :service yf/termbin-port
                                     ;; alternatively we could use a filter.
                                     ;; a filter would trigger before the connection is closed
                                     ;; but there is a (minuscule) risk that it triggers before we have the whole url
                                     :sentinel (lambda (proc what)
                                                 (yf/termbin-region--sentinel proc what callback)))))
    (process-send-region proc beg end)
    (process-send-eof proc)))

(defun yf/termbin-region-to-kill-ring (beg end)
  "Save region to termbin.com and push the resulting URL to kill ring"
  (interactive "r")
  (yf/termbin-region-async beg end (lambda (url)
                                     (kill-new url)
                                     (message "Copied URL: %s" url))))

(defalias 'yf/termbin-region #'yf/termbin-region-to-kill-ring)

(provide 'termbin)
;;; termbin.el ends here
