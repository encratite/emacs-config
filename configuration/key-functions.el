(defun reload-file ()
  (interactive)
  (revert-buffer t t))

(defun reload-configuration ()
  (interactive)
  (load "~/.emacs")
  (load custom-file))

(defun copy-whole-buffer ()
  (interactive)
  (kill-ring-save (point-min) (point-max)))

(defun fix-formatting ()
  (interactive)
  (indent-region (point-min) (point-max))
  (delete-trailing-whitespace))

(defun copy-current-line ()
  (interactive)
  (kill-ring-save
   (line-beginning-position)
   (line-end-position)))

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(defun custom-backspace ()
  (interactive)
  (let
      ((line (buffer-substring-no-properties (line-beginning-position) (point))))
    (setq whitespace-count 0)
    (setq string-index (- (length line) 1))
    (setq perform-iteration t)
    (while (and perform-iteration (>= string-index 0))
      (cond
       ((member (aref line string-index) '(?\  ?\t))
          (setq whitespace-count (+ whitespace-count 1))
          (setq string-index (- string-index 1)))
       (t (setq perform-iteration nil))))
    (setq remove-count (max whitespace-count 1))
    (backward-delete-char-untabify remove-count)))