(defun my-python-hooks ()
  (interactive)
  (setq tab-width 4
        python-indent 4
        python-shell-interpreter "ipython"))

(add-hook 'python-mode-hook 'my-python-hooks)

(provide 'setup-python-mode)
