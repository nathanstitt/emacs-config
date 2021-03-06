;;;; nas-whitespace-cleanup -- conditional cleanup of whitespace cleanup  -*- lexical-binding: t; -*-
;;; Commentary: large portions from https://github.com/dholm/dotemacs/blob/master/.emacs.d/lisp/modes/whitespace.el
;;; Code:

(defvar user/whitespace-mode-suppressed nil
  "Tracks whether `whitespace-mode' is currently being suppressed.")
(make-variable-buffer-local 'user/prev-whitespace-mode-suppressed)


(defun user--whitespace-mode-hook ()
  "Whitespace mode hook."
  ;;; (Bindings) ;;;
  ;; (user/bind-key-local :code :whitespace-auto-cleanup
  ;; 'user/toggle-whitespace-auto-cleanup)
  )


(defun user/whitespace-mode-suppress (suppress)
  "If SUPPRESS is non-nil, disable `whitespace-mode' in current mode."
  (when (boundp 'whitespace-mode)
    (if suppress
        (when (and whitespace-mode (not user/whitespace-mode-suppressed))
          (setq user/whitespace-mode-suppressed t)
          (whitespace-mode -1))
      (when user/whitespace-mode-suppressed
        (setq user/whitespace-mode-suppressed nil)
        (whitespace-mode 1)))))


(defun user/whitespace-disable-style (styles)
  "Disable STYLES in current mode."
  (when (boundp 'whitespace-style)
    (let ((options (cl-intersection styles whitespace-style)))
      (when (and (boundp 'global-whitespace-mode) global-whitespace-mode)
        (global-whitespace-toggle-options options))
      (when (and (boundp 'whitespace-mode) whitespace-mode)
        (whitespace-toggle-options options)))))


(defun user/toggle-whitespace-auto-cleanup ()
  "Toggle the state of automatic whitespace cleanup in current buffer."
  (interactive)
  (setq whitespace-action (user/toggle-element whitespace-action 'auto-cleanup))
  (message
   (concat "Whitespace cleanup "
           (if (member 'auto-cleanup whitespace-action) "enabled" "disabled"))))


(add-hook 'whitespace-mode-hook 'user--whitespace-mode-hook)

(require 'validate)

(validate-setq
 ;; Maximum allowed line length.
 whitespace-line-column 120
 ;; Cleanup whitespace errors on save.
 whitespace-action '(auto-cleanup)
 ;; Kinds of whitespace to visualize.
 whitespace-style
 '(;; Visualize using faces.
   face
   ;; Mark any tabs.
   ;;tab-mark
   ;; Empty lines at beginning or end of buffer.
   empty
   ;; Trailing whitespace.
   trailing
   ;; Lines that extend beyond `whitespace-line-column.'
   lines
   ;; Wrong kind of indentation (tab when spaces and vice versa.)
   indentation
   ;; Mixture of space and tab on the same line.
   space-before-tab space-after-tab))

(when (eq default-terminal-coding-system 'utf-8)
  ;; Don't use validate-setq due to :inline not being supported.
  (setq
   ;; Special characters for displaying whitespace.
   whitespace-display-mappings
   '(;; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
     (space-mark ?\s [183] [46])
     ;; 10 LINE FEED, 9166 RETURN SYMBOL 「⏎」, 36 DOLLAR SIGN 「$」
     (newline-mark ?\n [9166 10] [36 10])
     ;; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」, 92 9 CHARACTER TABULATION 「\t」
     (tab-mark ?\t [9655 9] [92 9]))))

(defadvice whitespace-cleanup (around whitespace-cleanup-indent-tab
                                      activate)
  "Fix whitespace-cleanup indent-tabs-mode bug."
  (let ((whitespace-indent-tabs-mode indent-tabs-mode)
        (whitespace-tab-width tab-width))
    ad-do-it))


;;(provide 'modes/whitespace)
;;; whitespace.el ends here

(add-hook 'text-mode-hook   'whitespace-cleanup-mode)
(add-hook 'prog-mode-hook   'whitespace-cleanup-mode)
(add-hook 'coffee-mode-hook 'whitespace-cleanup-mode)
(add-hook 'scss-mode-hook   'whitespace-cleanup-mode)
(add-hook 'less-mode-hook   'whitespace-cleanup-mode)

(provide 'nas-whitespace-cleanup)
;;; nas-whitespace-cleanup.el ends here
