(defun kill-line-at-click (event)
  (interactive "e")
  (mouse-set-point event)
  (kill-whole-line 0))

(local-set-key (kbd "<mouse-1>") 'kill-line-at-click)

(local-set-key (kbd "C-k") '(lambda () (interactive) (kill-whole-line 0)))