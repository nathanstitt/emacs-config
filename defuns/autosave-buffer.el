;; taken from the prelude project
;;
;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defcustom nas-buffer-auto-save t
  "Non-nil values enables auto save."
  :type 'boolean
  :group 'nas)

(defun nas-buffer-auto-save-command ()
  "Save the current buffer if `nas-buffer-auto-save' is not nil."
  (when (and nas-buffer-auto-save
             buffer-file-name
             (buffer-modified-p (current-buffer))
             (file-writable-p buffer-file-name))
    (save-buffer)))

(defmacro advise-commands (advice-name commands class &rest body)
  "Apply advice named ADVICE-NAME to multiple COMMANDS.
The body of the advice is in BODY."
  `(progn
     ,@(mapcar (lambda (command)
                 `(defadvice ,command (,class ,(intern (concat (symbol-name command) "-" advice-name)) activate)
                    ,@body))
               commands)))

;; advise all window switching functions
(advise-commands "auto-save"
                 (switch-to-buffer other-window windmove-up windmove-down windmove-left windmove-right)
                 before
                 (nas-buffer-auto-save-command))

(add-hook 'mouse-leave-buffer-hook 'nas-buffer-auto-save-command)
