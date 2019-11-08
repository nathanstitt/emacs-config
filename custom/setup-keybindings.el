(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Align your code in a pretty way.
(global-set-key (kbd "C-x :") 'align-to-colon)
(global-set-key (kbd "C-x \\") 'align-regexp)

;; unbind exit
(global-set-key (kbd "C-x C-c") nil)

;; Smart M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Use C-x C-m to do M-x per Steve Yegge's advice
(global-set-key (kbd "C-x C-m") 'smex)

(global-set-key (kbd "M-n") 'next-error)
(global-set-key (kbd "M-p") 'previous-error)

;; Perform general cleanup.
(global-set-key (kbd "C-c n") 'cleanup-buffer)
(global-set-key (kbd "C-c C-n") 'cleanup-buffer)
(global-set-key (kbd "C-c C-<return>") 'delete-blank-lines)

(global-set-key (kbd "C-l") 'switch-to-previous-buffer)
;; (global-set-key (kbd "C-i") 'universal-argument)


(global-set-key (kbd "M-h") 'kill-region-or-backward-word)

(global-set-key (kbd "M-s-r") 'query-replace)

(global-set-key (kbd "M-o") 'ace-window)

;; Zap to char
(global-set-key (kbd "M-z") 'zap-up-to-char)
(global-set-key (kbd "s-z") (lambda (char) (interactive "cZap up to char backwards: ") (zap-up-to-char -1 char)))

(global-set-key (kbd "M-Z") (lambda (char) (interactive "cZap to char: ") (zap-to-char 1 char)))
(global-set-key (kbd "s-Z") (lambda (char) (interactive "cZap to char backwards: ") (zap-to-char -1 char)))

;; Completion at point
(global-set-key (kbd "C-<tab>") 'completion-at-point)

;; Magit
(global-set-key (kbd "C-x m") 'magit-status)
(autoload 'magit-status "magit")

;; ag
(global-set-key (kbd "C-x C-a") 'ag-project)

;; projectile
(global-set-key (kbd "C-x C-c") 'projectile-find-file)

;; Clever newlines
(global-set-key (kbd "C-o") 'open-line-and-indent)
(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)
(global-set-key (kbd "<M-return>") 'new-line-dwim)


;; Line movement
(global-set-key (kbd "<M-s-p>") 'move-text-down)
(global-set-key (kbd "<C-S-up>") 'move-text-up)

;; Buffer file functions
(global-set-key (kbd "C-x t") 'touch-buffer-file)
(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)
(global-set-key (kbd "C-x C-k") 'delete-current-buffer-file)

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)


;; Completion that uses many different methods to find options.
(global-set-key (kbd "M-/") 'hippie-expand-no-case-fold)
(global-set-key (kbd "C-:") 'hippie-expand-lines)
(global-set-key (kbd "C-,") 'completion-at-point)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key [C-S-right] 'shift-right)
(global-set-key [C-S-left] 'shift-left)


(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map (kbd "C-/") 'jasmine-coffee/toggle-spec-enabled)
     (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))

(global-set-key (kbd "C-c C-f") 'fold-this-all)
(global-set-key (kbd "C-c C-F") 'fold-this)
(global-set-key (kbd "C-c M-f") 'fold-this-unfold-all)

(global-set-key (kbd "C-;") 'save-buffer)

;; key chords
;; (require 'key-chord)
;; (key-chord-define-global "ss" 'save-buffer)
;; (key-chord-define-global " i" 'previous-multiframe-window)
;; (key-chord-define-global " o" 'next-multiframe-window)
;; (key-chord-define-global " l" 'ibuffer)
;; (key-chord-define-global " s" 'save-buffer)
;; (key-chord-define-global " m" 'magit)
;; (key-chord-define-global " r" 'recompile)

;; (setq key-chord-two-keys-delay .01
;;       key-chord-one-key-delay .02)

;; (key-chord-mode +1)

(provide 'setup-keybindings)
;;; setup-keybindings ends here
