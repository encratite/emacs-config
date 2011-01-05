(defun setup-pasting-while-searching ()
  (local-set-key (kbd "C-q") 'isearch-yank-kill))

(defun setup-search-mode ()
  (add-hook 'isearch-mode-hook 'setup-pasting-while-searching))