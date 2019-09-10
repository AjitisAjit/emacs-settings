(require 'flycheck)
(require 'flycheck-pos-tip)
(require 'exec-path-from-shell)

;; Remove newline checks, since they would trigger an immediate check
;; when we want the idle-change-delay to be in effect while editing.
(setq flycheck-check-syntax-automatically '(save
                                            idle-change
                                            mode-enabled))

;; In case system is mac os
(if (eq 'system-type 'darwin)
    (exec-path-from-shell-initialize))

;; Add hook for python
(add-hook 'python-mode-hook 'flycheck-mode)

(provide 'setup-flycheck)
