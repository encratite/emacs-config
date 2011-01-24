(defun latex-mode-enter ()
  (interactive)
  (insert 10))

(defun latex-mode-hooks ()
  (local-set-key (kbd "RET") 'latex-mode-enter)
  (local-set-key (kbd "C-i") 'itemize-region))

(defun setup-latex-mode ()
  (add-hook 'latex-mode-hook 'latex-mode-hooks))

(defun itemize-region ()
  (interactive)
  (if mark-active
      (let* ((selected-text (buffer-substring-no-properties (region-beginning) (region-end)))
             (lines (split-string selected-text "\n"))
             (itemised-lines (mapcar (lambda (x) (format "\\item %s" x)) lines))
             (new-inner-text (mapconcat 'identity itemised-lines "\n"))
             (replacement (format "\\begin{itemize}\n%s\n\\end{itemize}" new-inner-text)))
        (kill-region (region-beginning) (region-end))
        (insert replacement))
    (message "The mark is currently not active.")))