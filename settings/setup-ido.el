;;; IDO customizations

(require 'ido)
(ido-mode t)

(setq
 ido-create-new-buffer 'always
 ido-max-prospects 10)

(provide 'setup-ido)
