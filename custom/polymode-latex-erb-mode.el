;;; polymode-latex-erb-mode --- Polymode for latex with erb
;;; Author: Unknown
;;; Commentary:
;; taken from https://gist.github.com/teksisto/96f2b4e54a2aa52ba554
;;; Code:

(require 'polymode)



(defcustom pm-host/latex
  (pm-bchunkmode "latex" :mode 'latex-mode)
  "Latex host chunkmode."
  :group 'hostmodes
  :type 'object)

(defcustom  pm-inner/nolatex
  (pm-hbtchunkmode "nolatex"
                   :head-reg "\<\%[-=]?"
                   :tail-reg "\%\>")
  "No latex chunk."
  :group 'innermodes
  :type 'object)

(defcustom pm-inner/erb
  (clone pm-inner/nolatex :mode 'ruby-mode)
  "Notex innermode for ruby."
  :group 'innermodes
  :type 'object)

(defcustom pm-poly/latex+erb
  (pm-polymode-one "awesome"
                   :hostmode 'pm-host/latex
                   :innermode 'pm-inner/erb)
  "Awesome polymode."
  :group 'polymodes
  :type 'object)

(define-polymode poly-latex+erb-mode pm-poly/latex+erb)
(add-to-list 'auto-mode-alist '("\\.tex.erb" . poly-latex+erb-mode))

(provide 'polymode-latex-erb-mode)
;;; polymode-latex-erb-mode.el ends here
