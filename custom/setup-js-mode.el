(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

;; (add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it)
  )

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun nas-use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))


(add-to-list 'web-mode-comment-formats '("javascript" . "//" ))
(add-to-list 'web-mode-comment-formats '("jsx" . "//" ))
(add-to-list 'web-mode-comment-formats '("js" . "//"))
(add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))

(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))
      web-mode-code-indent-offset 4
      web-mode-enable-auto-quoting nil
      web-mode-css-indent-offset 4
      web-mode-markup-indent-offset 4)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)
;; and for javascript mode
(flycheck-add-mode 'javascript-eslint 'javascript-mode)
(add-hook 'flycheck-mode-hook 'nas-use-eslint-from-node-modules)

(with-eval-after-load 'web-mode
  (define-key web-mode-map (kbd "C-s-r") 'web-mode-reload))


(provide 'setup-js-mode)
;;; setup-jsx.el ends here
