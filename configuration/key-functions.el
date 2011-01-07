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

(defun is-whitespace (character)
  (member character '(?\  ?\t)))

(defun custom-home ()
  "Jumps to the beginning of the code on the current line, or to the beginning of the entire line if it's already there"
  (interactive)
  (let ((line (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
        (last-whitespace-offset 0)
        (perform-iteration t))
    (while (and perform-iteration (< last-whitespace-offset (length line)))
      (if (is-whitespace (aref line last-whitespace-offset))
          (incf last-whitespace-offset)
        (setq perform-iteration nil)))
    (if (> (point) (+ (line-beginning-position) last-whitespace-offset))
        (back-to-indentation)
      (move-beginning-of-line nil))))

(defun custom-backspace ()
  "Delete backward over all whitespace."
  (interactive)
  (flet ((whitespace-before () (is-whitespace (char-before)))
         (delete () (delete-backward-char 1)))
    (if (whitespace-before)
        (while (whitespace-before)
          (delete))
      (delete))))