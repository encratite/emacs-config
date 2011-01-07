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
                ;;"search"
                "server"
                "tabbar"

                "haskell"
                "ruby"))
  (load-config-file file))

;;this variable is set to nil once the configuration has been loaded for the first time
;;this is used to avoid relaunching of the emacs server and disabling the linum mode on configuration reloads
(defvar first-time-load t)

(enable-site)
(enable-line-numbers)
(set-colour-theme)
(fix-whitespace)

;;(setup-auto-complete-mode)
(setup-ruby-mode)
(setup-haskell-mode)

(set-font)
(fix-scrolling)
(miscellaneous)
(setup-tabbar)
;;(setup-search-mode)
(bind-keys)
(run-server)

(setq first-time-load nil)