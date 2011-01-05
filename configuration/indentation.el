(defun perform-file-indentation (path)
  (message "Processing %s" path)
  (switch-to-buffer (find-file-noselect path))
  (fix-formatting)
  (save-buffer)
  (kill-buffer (current-buffer)))

(defun project-indentation (directory source-file-regex)
  (interactive)
  (dolist
      (entry (directory-files-and-attributes directory))
    (let
        ((name (car entry)))
      (when (not (member name '("." "..")))
        (let ((path (format "%s/%s" directory name))
              (is-directory (nth 1 entry)))
          (cond
           (is-directory
            (project-indentation path source-file-regex))
           (t
            (when (string-match source-file-regex path)
              (perform-file-indentation path)))))))))
