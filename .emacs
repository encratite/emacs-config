(defun add-load-path (path)
  (add-to-list 'load-path (concat "~/.emacs.d/" path "/")))

(defun enable-site ()
  (add-load-path "site-lisp"))

(defun enable-line-numbers ()
  (require 'linum)
  (global-linum-mode))

(defun set-colour-theme ()
  (require 'color-theme)
  (color-theme-initialize)
  (color-theme-hober))

(defun fix-whitespace ()
  (require 'whitespace)
  (global-whitespace-mode)
  (setq whitespace-style '(face trailing space-before-tab newline empty space-after-tab tab-mark)))

(defun ruby-enter ()
  (interactive)
  (let
      ((line (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
    (newline-and-indent)
    (cond
        ((string-match "^ *\\(def\\|if\\|while\\|begin\\)\\|^.*do\\( |.*|\\)?$" line)
         (newline-and-indent)
         (insert "end")
         (ruby-indent-command)
         (forward-line -1)
         (ruby-indent-command))
    )))

(defun setup-ruby-mode ()
  (add-load-path "ruby-mode")
  (require 'ruby-mode)
  (autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files")
  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
  (autoload 'run-ruby "inf-ruby""Run an inferior Ruby process")
  (autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
  (add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))
  (add-hook 'ruby-mode-hook 'turn-on-font-lock)
  (setq ruby-indent-tabs-mode nil)
  (add-hook 'ruby-mode-hook '(lambda () (local-set-key (kbd "RET") 'ruby-enter))))

(defun set-font ()
  (if (eq system-type 'windows-nt)
      (set-default-font "-outline-Terminus-medium-r-normal-normal-16-120-96-96-c-*-iso8859-")))

(defun fix-scrolling ()
  (require 'smooth-scrolling)
  (let ((line-count 5)) (setq mouse-wheel-scroll-amount `(,line-count ((shift) . ,line-count))))
  (setq mouse-wheel-progressive-speed nil)
  (setq mouse-wheel-follow-mouse 't)
  (setq scroll-step 3))

(defun fundamental-mode-check ()
  (if (equal major-mode 'fundamental-mode)
      (local-set-key (kbd "<tab>") 'tab-to-tab-stop)
      (setq indent-tabs-mode nil)))

(defun miscellaneous ()
  (setq transient-mark-mode t)
  (setq custom-file "~/.emacs-custom.el")
  (setq inhibit-startup-screen t)
  (setq ring-bell-function (lambda ()))
  (setq backup-inhibited t)
  (setq auto-save-default nil)
  (setq buffer-offer-save nil)
  ;(setq default-tab-width 4)
  (setq-default indent-tabs-mode t)
  (add-hook 'after-change-major-mode-hook 'fundamental-mode-check)
  (setq kill-whole-line t))

(defun bind-keys ()
  (global-set-key (kbd "<f1>") 'copy-whole-buffer)
  (global-set-key (kbd "<f2>") 'delete-other-windows)
  (global-set-key (kbd "<f3>") 'indent-everything)
  (global-set-key (kbd "<f5>") 'save-buffer)
  (global-set-key (kbd "<f9>") 'reload-file)
  (global-set-key (kbd "<f12>") 'reload-configuration)
  (global-set-key (kbd "RET") 'newline-and-indent)
  (global-set-key (kbd "<C-return>") 'newline)
  (global-set-key (kbd "C-k") 'kill-whole-line)
  (global-set-key (kbd "C-l") 'copy-current-line))

(defun reload-file ()
  (interactive)
  (revert-buffer t t))

(defun reload-configuration ()
  (interactive)
  (load "~/.emacs"))

(defun copy-whole-buffer ()
  (interactive)
  (kill-ring-save (point-min) (point-max)))

(defun indent-everything ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun copy-current-line ()
  (interactive)
  (kill-ring-save
   (line-beginning-position)
   (line-end-position)))

(defun save-buffers-kill-emacs (&optional arg)
  "Offer to save each buffer, then kill this Emacs process. With prefix arg, silently save all file-visiting buffers, then kill."
  (interactive "P")
  (save-some-buffers arg t)
  (and
   (or
    (not
     (memq t
           (mapcar
            (function
             (lambda (buf)
               (and (buffer-file-name buf)
                    (buffer-modified-p buf))))
            (buffer-list))))
    t)
   (or (not (fboundp 'process-list))
       ;; process-list is not defined on VMS.
       (let ((processes (process-list))
             active)
         (while processes
           (and (memq (process-status (car processes)) '(run stop open listen))
                (process-query-on-exit-flag (car processes))
                (setq active t))
           (setq processes (cdr processes)))
         (or (not active)
             (list-processes t)
             (yes-or-no-p "Active processes exist; kill them and exit anyway? "))))
   ;; Query the user for other things, perhaps.
   (run-hook-with-args-until-failure 'kill-emacs-query-functions)
   (or (null confirm-kill-emacs)
       (funcall confirm-kill-emacs "Really exit Emacs? "))
   (kill-emacs)))

(enable-site)
(enable-line-numbers)
(set-colour-theme)
(fix-whitespace)
(setup-ruby-mode)
(set-font)
(fix-scrolling)
(miscellaneous)
(bind-keys)