;; add the current branch as an option and select the '--set-upstream' when
;; it's never been pushed before
(defun magit-push-arguments-maybe-upstream (magit-push-popup-fun &rest args)
  "Enable --set-upstream switch if there isn't a current upstream."
  (let ((magit-push-arguments
         (if (magit-get-remote) magit-push-arguments
           (cons "--set-upstream" magit-push-arguments))))
    (apply magit-push-popup-fun args)))
(advice-add 'magit-push-popup :around #'magit-push-arguments-maybe-upstream)

(setq magit-completing-read-function #'magit-ido-completing-read)
