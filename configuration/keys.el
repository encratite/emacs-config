(defmacro define-global-keybindings (&rest specs)
  `(progn
     ,@(loop for (keys command) in specs
             collect `(global-set-key (kbd ,keys) ',command))))


(defun bind-keys ()
  (define-global-keybindings
    ("<f1>" copy-whole-buffer)
    ("<f2>" delete-other-windows)
    ("<f3>" fix-formatting)
    ("<f5>" save-buffer)
    ("<f9>" reload-file)
    ("<f12>" reload-configuration)
    ("RET" newline-and-indent)
    ("<C-return>" newline)
    ("C-k" kill-whole-line)
    ("C-l" copy-current-line)
    ("C-q" yank)))