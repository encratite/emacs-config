(defun latex-mode-enter ()
  (interactive)
  (insert 10))

(defun latex-mode-hooks ()
  (local-set-key (kbd "RET") 'latex-mode-enter)
  (local-set-key (kbd "C-i") (lambda ()
                               (interactive)
                               (itemise-region "itemize")))
  (local-set-key (kbd "C-o") (lambda ()
                               (interactive)
                               (itemise-region "enumerate"))))

(defun setup-latex-mode ()
  (add-hook 'latex-mode-hook 'latex-mode-hooks))

(defun itemize-line (line)
  (let* ((prefix "\\item ")
         (line-prefix (subseq line 0 (min (length line) (length prefix)))))
    (if (string= prefix line-prefix)
        line
      (concat prefix line))))

(defun itemise-region (string)
  (interactive)
  (if mark-active
      (let* ((selected-text (buffer-substring-no-properties (region-beginning) (region-end)))
             (lines (split-string selected-text "\n"))
             (itemised-lines (mapcar 'itemize-line lines))
             (new-inner-text (mapconcat 'identity itemised-lines "\n"))
             (replacement (format "\\begin{%s}\n%s\n\\end{%s}" string new-inner-text string)))
        (kill-region (region-beginning) (region-end))
        (insert replacement))
    (message "The mark is currently not active.")))