(require 'yasnippet)

;; Use own snippets
(setq yas-snippet-dir
      (expand-file-name "snippets" user-emacs-directory))

;; Enable globally
(yas-global-mode 1)

;; Jump to end of snippet definition
(define-key yas-keymap (kbd "<return>") 'yas-exit-all-snippets)

;; No dropdowns please, yas
(setq yas-prompt-functions '(yas-ido-prompt yas-completing-prompt))

;; No need to be so verbose
(setq yas-verbosity 1)

;; Wrap around region
(setq yas-wrap-around-region t)

(provide 'setup-yasnippet)
