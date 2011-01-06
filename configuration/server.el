(defun run-server ()
  (defvar server-is-running nil)
  (when (null server-is-running)
    (setq server-is-running t)
    (server-start))
  (remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
  (remove-hook 'kill-emacs-query-functions 'server-kill-emacs-query-function))