;;;; nas-whitespace-cleanup -- conditional cleanup of whitespace cleanup
;;; Commentary:
;;; Code:
(defcustom nas-clean-whitespace-on-save t
  "Cleanup whitespace from file before it's saved."
  :type 'boolean
  :group 'nas)

(defun nas-whitespace-cleanup ()
  "Invoke `whitespace-cleanup' if `nas-clean-whitespace-on-save' is not nil."
  (when nas-clean-whitespace-on-save
    (whitespace-cleanup)))

(defun nas-enable-whitespace ()
  "Enable `whitespace-mode'."
  ;; keep the whitespace decent all the time (in this buffer)
  (add-hook 'before-save-hook 'nas-whitespace-cleanup nil t)
  (whitespace-mode +1))


(add-hook 'text-mode-hook   'nas-enable-whitespace)
(add-hook 'prog-mode-hook   'nas-enable-whitespace)
(add-hook 'coffee-mode-hook 'nas-enable-whitespace)
(add-hook 'scss-mode-hook   'nas-enable-whitespace)
(add-hook 'less-mode-hook   'nas-enable-whitespace)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'nas-whitespace-cleanup)
;;; nas-whitespace-cleanup.el ends here
