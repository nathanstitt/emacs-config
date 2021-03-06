;; add .emacs.d/custom to load path


(setq site-lisp-dir
      (expand-file-name "custom" user-emacs-directory))

(add-to-list 'load-path site-lisp-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR." t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'saveplace)
(setq-default save-place t)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      visible-bell nil
      ring-bell-function 'ignore
      scss-compile-at-save nil
      ediff-window-setup-function 'ediff-setup-windows-plain
      save-place-file (concat user-emacs-directory "places"))

(defconst backup-dir (concat user-emacs-directory "backups/"))
(unless (file-exists-p backup-dir) (make-directory backup-dir))
(setq backup-directory-alist `((".*" . ,backup-dir)))
(setq auto-save-file-name-transforms `((".*" ,backup-dir t)))
(setq auto-save-list-file-prefix backup-dir)

; ... and clear out old backup files automatically.
(message "Deleting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files backup-dir t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (nth 5 (file-attributes file))))
                  week))
      (message "%s" file)
      (delete-file file))))


(require 'setup-package)
(require 'appearance)

(setq is-mac (equal system-type 'darwin))
;; Setup environment variables from the user's shell.
(when is-mac
  (require-package 'exec-path-from-shell)
  (exec-path-from-shell-initialize)
  (require 'osx))

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (dolist (file (directory-files defuns-dir t "\\w+"))
    (when (file-regular-p file)
      (load file))))


; add homebrew installed packages to loadpath
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(add-hook 'after-init-hook 'global-company-mode)
(setq company-dabbrev-downcase nil)
(require 'list-utils)
(require 'setup-flycheck)
(require 'setup-rebox2)
(require 'setup-ruby)
(require 'smartparens-config)
(require 'jasmine-coffee)
(require 'setup-coffee-mode)
(require 'setup-magit)
(require 'nas-ido-mode)
(require 'nas-setup-alignment)
(require 'setup-js-mode)
(require 'setup-utf-chars)
(require 'nas-whitespace-cleanup)
(require 'nas-go)
(require 'nas-typescript)
(require 'nas-compilation)
(require 'setup-platformio)
(require 'rvm)

(add-to-list 'load-path "~/.emacs.d/custom/es6-snippets")
(require 'es6-snippets)

(rvm-use-default)
(dumb-jump-mode)
; After all functions are defined
(require 'setup-keybindings)

; Highlight find/replace results.
(setq query-replace-highlight t)

; Replace selected text on text entry.
(pending-delete-mode t)

;; make backup to a designated dir, mirroring the full path
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs.d/saves"))    ; don't litter my fs tree
 delete-old-versions t
 create-lockfiles nil ; don't litter with .#filename junk, it's a single user system!
 kept-new-versions 6
 kept-old-versions 2
 version-control t)

(editorconfig-mode 1)

; Replace "yes" or "no" resonses with
; "y" or "n".
(fset 'yes-or-no-p 'y-or-n-p)


; Bump up the GC threshold to 20MB.
(setq gc-cons-threshold 20000000)
(setq ag-reuse-buffers 't)


(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
