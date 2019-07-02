 ;; Make the compilation window automatically disappear - from enberg on #emacs
(setq compilation-finish-functions
      (lambda (buf str)
        (if (null (string-match ".*exited abnormally.*" str))
            ;;no errors, make the compilation window go away in a few seconds
            (progn
              (run-at-time
               "2 sec" nil 'delete-windows-on
               (get-buffer-create "*compilation*"))
              (message "No Compilation Errors!")))))


(global-set-key (kbd "C-c C-v") 'recompile)
;; (global-set-key "\C-c\C-c" 'recompile)

(setq compilation-ask-about-save nil)

(provide 'nas-compilation)
