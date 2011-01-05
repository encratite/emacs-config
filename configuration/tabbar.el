(defun setup-tabbar ()
  (require 'tabbar)
  (setq tabbar-buffer-groups-function (quote customised-tabbar-buffer-groups))
  (setq tabbar-cycling-scope (quote tabs))
  (custom-set-faces
   '(tabbar-selected-face ((t (:inherit tabbar-default-face :foreground "black" :box (:line-width 2 :color "white" :style pressed-button)))))
   '(tabbar-unselected-face ((t (:inherit tabbar-default-face :foreground "black" :box (:line-width 2 :color "white" :style released-button))))))
  (tabbar-mode t))

 (defun customised-tabbar-buffer-groups (buffer)
   "Return the list of group names BUFFER belongs to.
 Return only one group for each buffer."
   (with-current-buffer (get-buffer buffer)
     (cond
      ((string-equal "*" (substring (buffer-name) 0 1))
       '("emacs"))
      (t
       '("Code"))
      )))