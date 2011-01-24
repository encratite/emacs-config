(defun latex-mode-enter ()
  (interactive)
  (insert 10))

(defun latex-mode-hooks ()
  (local-set-key (kbd "RET") 'latex-mode-enter))

(defun setup-latex-mode ()
  (add-hook 'latex-mode-hook 'latex-mode-hooks))