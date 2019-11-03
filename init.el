;; init.el
;;--------

;; Set path deps

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(package-initialize)

;; Remove security vulnerability
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

;; Inihib starting spash message
(setq inhibit-startup-message t)

;; Setup paths to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

(add-to-list 'load-path settings-dir)
(add-to-list 'load-path site-lisp-dir)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; Setup appearance early
(require 'appearance)

;; Don't create lockfiles
(setq create-lockfiles nil)

;; Remove whitespaces upon save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Better defaults
(require 'better-defaults)

;; Setup package
(require 'setup-package)

;; Setup packages
(defun init--install-packages ()
  (packages-install
   '(
     yasnippet
     flycheck
     flycheck-pos-tip
     exec-path-from-shell
     magit
     company
     smartparens)))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; exec path from shell
(require 'exec-path-from-shell)

(defun exec-path-zsh ()
  "Reverses exec path when running on macos"
  (progn
    (exec-path-from-shell-initialize)
    (when (eq system-type 'darwin)
      (setq exec-path (reverse exec-path))
      (setq eshell-path-env
            (mapconcat 'identity
                       (reverse (split-string eshell-path-env ":"))
                       ":")))))

(exec-path-zsh)

;; Company mode
(add-hook 'after-init-hook 'global-company-mode)

;; Enable undo tree
(require 'undo-tree)
(global-undo-tree-mode)

;; Setup extensions
(eval-after-load 'dired '(require 'setup-dired))
(require 'setup-yasnippet)
(require 'setup-flycheck)
(require 'setup-hippie)

;; Language specific settings
(eval-after-load 'python-mode '(require 'setup-python-mode))

;; Smart M-x
(require 'smex)
(smex-initialize)

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Setup extensions
(eval-after-load 'ido '(require 'setup-ido))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3593185c35012764e5c90f1956c1b9e0a0448451568ad5825679aca253f70ba2" "1cac527e8632fba9b965a6da3d24cb576e00437139b168f49c88fc1edada5b47" "f083877ef43920e1ca9235e849a1401254a4595dc60382932d28eac604c1b070" "c163e6d1d23fe771d836b8fd2d3e0ab3ac25f4655fcb0960cc33d1984cfc7c10" "05f37232a9f1bb5527271425eae43c27024ea038bef6e43ca88a8b7197c508eb" default)))
 '(package-selected-packages
   (quote
    (pipenv pipenv-mode exec-path-from-shell undo-tree anaconda-company company-mode anaconda-eldoc anaconda-eldoc-mode anaconda-mode hippie flycheck-pos-tip wheatgrass-theme solarized-theme magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
