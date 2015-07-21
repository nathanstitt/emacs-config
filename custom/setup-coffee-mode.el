(add-to-list 'auto-mode-alist '("\\.cjsx\\'" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.be\\'" . coffee-mode))

(add-hook 'coffee-mode-hook (lambda ()
                              (flycheck-select-checker 'coffee-coffeelint)))

(provide 'setup-coffee-mode)
;;; setup-coffee-mode.el ends here
