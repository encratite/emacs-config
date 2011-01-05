(defun reload-file ()
  (interactive)
  (revert-buffer t t))

(defun reload-configuration ()
  (interactive)
  (load "~/.emacs")
  (load custom-file))

(defun copy-whole-buffer ()
  (interactive)
  (kill-ring-save (point-min) (point-max)))

(defun fix-formatting ()
  (interactive)
  (indent-region (point-min) (point-max))
  (delete-trailing-whitespace))

(defun copy-current-line ()
  (interactive)
  (kill-ring-save
   (line-beginning-position)
   (line-end-position)))