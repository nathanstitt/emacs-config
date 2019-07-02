(provide 'setup-utf-chars)

;; Thanks Tim Bray
;; https://www.tbray.org/ongoing/When/200x/2003/09/27/UniEmacs

(defun one-quote () "" (interactive) (insert ?'))
(defvar sq-state 'nil "In single-quotes?")
(defvar dq-state 'nil "In double quotes?")
(defun utf-insert-special (c) "Insert special characters, like so:
 s => open/close single quotes
 d => open/close double quotes
 ' => apostrophe
 a => <a href=
 i => <img src=
 & => &amp;
 < => &lt;
 - => mdash
 . => center-dot"
       (interactive "c" "'")
       (cond
        ((= c ?s)
         (if sq-state
             (progn
               (ucs-insert #x2019)
               (setq sq-state 'nil))
           (ucs-insert #x2018)
           (setq sq-state 't)))
        ((= c ?d)
         (if dq-state
             (progn
               (ucs-insert #x201d)
               (setq dq-state 'nil))
           (ucs-insert #x201c)
           (setq dq-state 't)))
        ((= c ?') (ucs-insert #x2019))
        ((= c ?a)
         (progn
           (if (> (current-column) 0) (newline-and-indent))
           (insert "<a href=\"\">")
           (backward-char 2)
           ))
        ((= c ?i)
         (progn
           (if (> (current-column) 0) (newline-and-indent))
           (insert "<img src=\"\" alt=\"\" />")
           (backward-char 11)
           ))
        ((= c ?&) (insert "&amp;"))
        ((= c ?<) (insert "&lt;"))
        ((= c ?-) (ucs-insert #x2014))
        ((= c ?.) (ucs-insert #xb7))))


(defvar utf-char-choice
  '("Special characters"
    (""
     ("ccedil"    #xe7)
     ("copyright" #xa9)
     ("degree"    #xb0)
     ("dot"       #xb7)
     ("eacute"    #xe9)
     ("ellipsis"  #x2026)
     ("half"      "&#xbd;")
     ("omacr"     "&#x14d;")
     ("oouml"     #xe4)
     ("uuml"      #xfc)
     ("euro"      #x20ac)
     ("cents"     #xa2)
     ("egrave"    #xe8)
     ("lsquo"     #x2018)
     ("rsquo"     #x2019)
     ("ldquo"     #x201c)
     ("rdquo"     #x201d)
     ("mdash"     #x2014))))

(defun utf-special-chars-menu ()
  "Insert a special character from a menu"
  (interactive)
  (let ((value
         (car (x-popup-menu
               (list '(10 10) (selected-window))
               utf-char-choice))))
    (cond
     ((integerp value) (ucs-insert value))
     ((stringp  value) (insert value))
     ('t )))) ;; so you can hit escape and make the menu go away


(defun find-first-non-ascii-char ()
  "Find the first non-ascii character from point onwards."
  (interactive)
  (let (point)
    (save-excursion
      (setq point
            (catch 'non-ascii
              (while (not (eobp))
                (or (eq (char-charset (following-char))
                        'ascii)
                    (throw 'non-ascii (point)))
                (forward-char 1)))))
    (if point
        (goto-char point)
        (message "No non-ascii characters."))))
