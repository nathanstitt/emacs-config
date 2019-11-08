;; mostly from https://johnsogg.github.io/emacs-golang

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

;; Define function to call when go-mode loads
(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save) ; gofmt before every save
  (setq gofmt-command "goimports")                ; gofmt uses invokes goimports
  (if (not (string-match "go" compile-command))   ; set compile command default
      (set (make-local-variable 'compile-command)
           "go build -v && ginkgo --noColor"))

  ;; guru settings
  (go-guru-hl-identifier-mode)                    ; highlight identifiers

  ;; Key bindings specific to go-mode
  (local-set-key (kbd "M-.") 'godef-jump)         ; Go to definition
  (local-set-key (kbd "M-*") 'pop-tag-mark)       ; Return from whence you came

   (set (make-local-variable 'company-backends) '(company-go))
   (company-mode)

   (require 'go-guru)
   (add-hook 'before-save-hook 'gofmt-before-save)
   (setq tab-width 4)
   (setq indent-tabs-mode 1)

  ;; Misc go stuff
  (user/whitespace-disable-style '(lines lines-tail tab-mark tabs))
  (auto-complete-mode 1))                         ; Enable auto-complete mode


;; Connect go-mode-hook with the function we just defined
(add-hook 'go-mode-hook 'my-go-mode-hook)

(require 'company)                                   ; load company mode
(require 'company-go)                                ; load company mode go backend
;; Ensure the go specific autocomplete is active in go-mode.
;; (with-eval-after-load 'go-mode

;; )

;; If the go-guru.el file is in the load path, this will load it.


(provide 'nas-go)
