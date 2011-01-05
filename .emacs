(defun get-config-path (directory)
  (format "~/.emacs.d/%s" directory))

(defun load-config-file (file)
  (load (get-config-path
         (format "configuration/%s.el" file))))

(dolist (file '("commands"
                "indentation"
                "key-functions"
                "keys"
                "miscellaneous"
                "modes"
                "tabbar"

                "haskell"
                "ruby"))
  (load-config-file file))

(enable-site)
(enable-line-numbers)
(set-colour-theme)
(fix-whitespace)

;(setup-auto-complete-mode)
(setup-ruby-mode)
(setup-haskell-mode)

(set-font)
(fix-scrolling)
(miscellaneous)
(setup-tabbar)
(bind-keys)
(run-server)