(defun save-buffers-kill-emacs (&optional arg)
  "Offer to save each buffer, then kill this Emacs process. With prefix arg, silently save all file-visiting buffers, then kill."
  (interactive "P")
  (save-some-buffers arg t)
  (and
   (or
    (not
     (memq t
           (mapcar
            (function
             (lambda (buf)
               (and (buffer-file-name buf)
                    (buffer-modified-p buf))))
            (buffer-list))))
    t)
   (or (not (fboundp 'process-list))
       ;; process-list is not defined on VMS.
       (let ((processes (process-list))
             active)
         (while processes
           (and (memq (process-status (car processes)) '(run stop open listen))
                (process-query-on-exit-flag (car processes))
                (setq active t))
           (setq processes (cdr processes)))
         (or (not active)
             (list-processes t)
             (yes-or-no-p "Active processes exist; kill them and exit anyway? "))))
   ;; Query the user for other things, perhaps.
   (run-hook-with-args-until-failure 'kill-emacs-query-functions)
   (or (null confirm-kill-emacs)
       (funcall confirm-kill-emacs "Really exit Emacs? "))
   (kill-emacs)))