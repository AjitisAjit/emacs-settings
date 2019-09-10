;;; appearance.el
;;;--------------
;;; Vanity settings

;; Highlight current line
(global-hl-line-mode 1)

;; Setup font
(set-face-attribute 'default nil
                    :family "Inconsolata" :height 140 :weight 'normal)

;; Font colors
(setq css-fontify-colors nil)

;; Line numbers
(add-hook 'prog-mode-hook 'global-display-line-numbers-mode)

;; Setup custom themes
(setq custom-theme-directory (concat user-emacs-directory "themes"))

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

;; Add themes to load path
(dolist
    (path (directory-files custom-theme-directory t "\\w+"))
  (when (file-directory-p path)
    (add-to-list 'custom-theme-load-path path)))

;; Load theme based on mode
(defun select-theme ()
  (if (display-graphic-p)
      (load-theme 'solarized-dark t)
    (load-theme 'wheatgrass t)))

(select-theme)

;; Maximize on startup
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

;; Settings for window mode
(when (display-graphic-p)
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

;; Unclutter modeline
(require 'diminish)
(eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
(eval-after-load "eldoc" '(diminish 'eldoc-mode))
(eval-after-load "flycheck" '(diminish 'flycheck-mode))
(eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
(eval-after-load "company" '(diminish 'company-mode))

(provide 'appearance)
