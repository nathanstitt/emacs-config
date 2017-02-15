;;;; nas-whitespace-cleanup -- conditional cleanup of whitespace cleanup
;;; Commentary:
;;; Code:


(add-hook 'text-mode-hook   'whitespace-cleanup-mode)
(add-hook 'prog-mode-hook   'whitespace-cleanup-mode)
(add-hook 'coffee-mode-hook 'whitespace-cleanup-mode)
(add-hook 'scss-mode-hook   'whitespace-cleanup-mode)
(add-hook 'less-mode-hook   'whitespace-cleanup-mode)

(provide 'nas-whitespace-cleanup)
;;; nas-whitespace-cleanup.el ends here
