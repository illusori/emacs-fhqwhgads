;;; fhqwhgads.el --- Everybody to the limit.

;; Author     : Sam Graham <libfhqwhgads-emacs BLAHBLAH illusori.co.uk>
;; Maintainer : Sam Graham <libfhqwhgads-emacs BLAHBLAH illusori.co.uk>
;; Created    : 3rd February 2012
;; Modified   : 3rd February 2012
;; Version    : 1.0.0
;; Keywords   : fun homestarrunner strongbad fhqwhgads

;;; Commentary:

;; A colleague made a joke about Emacs keybindings... I suggested this one.

;;; Code:

(defgroup fhqwhgads nil
  "Everybody to the limit."
   :group 'hypermedia)

(defcustom fhqwhgads-delay 0.9
  "Delay in seconds to wait between lyrics."
  :group 'fhqwhgads
  :type 'number)

(defcustom fhqwhgads-url "http://www.homestarrunner.com/fhqwhgads.html"
  "URL for the full song."
  :group 'fhqwhgads
  :type 'string)

(defcustom fhqwhgads-lyrics (list
  "I said come on fhqwhgads,"
  "said come on fhqwhgads."
  "Everybody to the limit,"
  "Everybody to the limit,"
  "Everybody come on fhqwhgads.")
  "Lyrics of fhqwhgads."
  :group 'fhqwhgads
  :type 'list)

(defvar fhqwhgads-song-timer nil
  "A timer to sing the lyrics of fhqwhgads.")

(defvar fhqwhgads-line nil
  "The line of fhqwhgads to sing next.")

(defun fhqwhgads ()
  "Sing fhqwhgads."
  (interactive)
  (fhqwhgads-start-song-timer))

(defun fhqwhgads-sing-line ()
  "Sings next line of fhqwhgads."
  (if (message
    (if (= (% fhqwhgads-line 2) 0)
      (nth fhqwhgads-line fhqwhgads-lyrics)
      (concat (nth (1- fhqwhgads-line) fhqwhgads-lyrics) " "
        (nth fhqwhgads-line fhqwhgads-lyrics))))
    (setq fhqwhgads-line (1+ fhqwhgads-line))
    (fhqwhgads-cancel-song-timer)))

(defun fhqwhgads-cancel-song-timer ()
  "Cancels `fhqwhgads-song-timer'."
  (interactive)
  (when fhqwhgads-song-timer
    (cancel-timer fhqwhgads-song-timer)
    (setq fhqwhgads-song-timer nil)
    (setq fhqwhgads-line nil)))

(defun fhqwhgads-start-song-timer ()
  "Starts `fhqwhgads-song-timer'."
  (when (not fhqwhgads-song-timer)
    (setq fhqwhgads-line 0)
    (setq fhqwhgads-song-timer
      (run-at-time nil fhqwhgads-delay 'fhqwhgads-sing-line))))

(provide 'fhqwhgads)
;;; fhqwhgads.el ends here
