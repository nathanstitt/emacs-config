(eval-after-load 'ruby-mode
  '(progn
     (defun nas-ruby-mode-defaults ()
       (inf-ruby-minor-mode +1)
       (ruby-tools-mode +1)
       (smartparens-mode +1)
       ;; CamelCase aware editing operations
       (subword-mode +1))

     (setq nas-ruby-mode-hook 'nas-ruby-mode-defaults)

     (add-hook 'ruby-mode-hook (lambda ()
                                     (run-hooks 'nas-ruby-mode-hook)))))


(provide 'setup-ruby)


(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

(defun set-newline-and-indent ()
  (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent))
(add-hook 'ruby-mode-hook 'set-newline-and-indent)

(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
