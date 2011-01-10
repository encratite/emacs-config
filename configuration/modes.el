(defun enable-line-numbers ()
  (when first-time-load
    (require 'linum)
    (global-linum-mode)))

(defun set-colour-theme ()
  (require 'color-theme)
  (color-theme-initialize)
  (if (is-windows)
      (color-theme-charcoal-black)
    (color-theme-jb-simple)))

(defun fix-whitespace ()
  (when first-time-load
    (require 'whitespace)
    (global-whitespace-mode)
    (setq whitespace-style '(face trailing space-before-tab newline empty space-after-tab tab-mark))))

(defun setup-auto-complete-mode ()
  (add-load-path "auto-complete")
  (require 'auto-complete-config)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
  (ac-config-default))