;;; fhqwhgads.el --- Everybody to the limit.
;;
;; Copyright (C) 2011-2012  Free Software Foundation, Inc.
;;
;; Author     : Sam Graham <libfhqwhgads-emacs BLAHBLAH illusori.co.uk>
;; Maintainer : Sam Graham <libfhqwhgads-emacs BLAHBLAH illusori.co.uk>
;; Created    : 3rd February 2012
;; Modified   : 3rd February 2012
;; Version    : 1.0.2
;; Keywords   : fun homestarrunner strongbad fhqwhgads
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;; Please note that the lyrics to Fhqwhgads are not covered by the
;; above copyright notice and belong to their respective owner.
;;
;;; Commentary:
;;
;; A colleague made a joke about Emacs keybindings... I suggested this one.
;;
;;; Usage:
;; Stick this file in your emacs path and then add to your startup file:
;;  (require 'fhqwhgads)
;;  (global-set-key "\C-cfhqwhgads" 'fhqwhgads)
;;  (global-set-key "\C-cofhqwhgads" 'fhqwhgads-browse)
;; It's perfectly memorable and obvious, like all Emacs keybindings.

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

(defun fhqwhgads-browse ()
  "Visit Fhqwhgads in your browser. You'd best use a Flash-capable browser."
  (interactive)
  (browse-url fhqwhgads-url))

(provide 'fhqwhgads)
;;; fhqwhgads.el ends here
