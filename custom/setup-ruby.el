(eval-after-load 'enh-ruby-mode
  '(progn
     (defun nas-ruby-mode-defaults ()
       (inf-ruby-minor-mode +1)
       (ruby-tools-mode +1)
       (smartparens-mode +1)
       ;; CamelCase aware editing operations
       (subword-mode +1))

     (setq nas-ruby-mode-hook 'nas-ruby-mode-defaults)

     (add-hook 'enh-ruby-mode-hook (lambda ()
                                     (run-hooks 'nas-ruby-mode-hook)))))


(provide 'setup-ruby)

(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(setq enh-ruby-bounce-deep-indent t)
(setq enh-ruby-hanging-brace-indent-level 2)
(defun set-newline-and-indent ()
  (define-key enh-ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent))
(add-hook 'enh-ruby-mode-hook 'set-newline-and-indent)

(setq ruby-use-smie nil)

(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
