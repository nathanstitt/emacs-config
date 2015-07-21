;; Don't case-fold when expanding with hippe
(defun hippie-expand-no-case-fold ()
  (interactive)
  (let ((case-fold-search nil))
    (hippie-expand nil)))
