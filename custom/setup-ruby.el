(eval-after-load 'ruby-mode
  '(progn
     (defun nas-ruby-mode-defaults ()

       (ruby-tools-mode +1)
       (smartparens-mode +1)
       ;; camelcase aware editing operations
       (subword-mode +1))

     (setq nas-ruby-mode-hook 'nas-ruby-mode-defaults)

     (add-hook 'ruby-mode-hook (lambda ()
                                     (run-hooks 'nas-ruby-mode-hook)))))


(add-hook 'ruby-mode-hook
          (lambda () (hs-minor-mode)))

(eval-after-load "hideshow"
  '(add-to-list 'hs-special-modes-alist
        `(ruby-mode
                  ,(rx (or "def" "class" "module" "do" "{" "[")) ; block start
                  ,(rx (or "}" "]" "end"))                       ; block end
                  ,(rx (or "#" "=begin"))                        ; comment start
                  ruby-forward-sexp nil)))

(global-set-key (kbd "C-c h") 'hs-hide-block)
(global-set-key (kbd "C-c s") 'hs-show-block)

(provide 'setup-ruby)
(setq ruby-deep-indent-paren nil)
(require 'ruby-tools)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("gemfile$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;; (defun set-newline-and-indent ()
;;   (define-key enh-ruby-mode-map (kbd "ret") 'reindent-then-newline-and-indent))
;; (add-hook 'enh-ruby-mode-hook 'set-newline-and-indent)

(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
