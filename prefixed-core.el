;;; prefixed-core.el --- Rename core functions for a better structured namespace  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Free Software Foundation, Inc.

;; Author: Stefan Monnier <monnier@iro.umontreal.ca>
;; Keywords:
;; Version: 0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This library provids new names for old functions.
;;
;; Many core Lisp functions do not abide by the "package prefix convention"
;; that Elisp packages are expected to follow, and instead use a naming
;; that makes for names that sound closer to "plain English", typically
;; using the form "VERB-NOUN" to focus on what the function does rather
;; then what it operates on.
;;
;; In this library, we try to group functions based on their "subject"
;; and make them share a common prefix.
;;
;; While this may seem like a futile and impossible endeavor (many functions
;; can arguably be reasonably placed in several different groups), I think it
;; can be sufficiently useful, that it is worth trying to get a bit closer to
;; this impossible goal.

;; Some of the expected benefits are:
;; - Making some functionality more discoverable
;; - Helping to write code using prefix-based completion.
;; - Better match the tradition followed in pretty much all programming
;;   languages (including Elisp, for non-core functions).

;;; Code:

;;;; Strings
(defalias 'string-multibyte-p #'multibyte-string-p)
(defalias 'string-split #'split-string)
(defalias 'string-assoc #'assoc-string)
(defalias 'string-clear #'clear-string)
(defalias 'string-compare #'compare-strings)
(defalias 'string-make #'make-string)
(defalias 'string-subst-char #'subst-char-in-string)
(defalias 'string-unibyte #'unibyte-string)
(defalias 'string-truncate-to-width #'truncate-string-to-width)
;; Other possibilities, which make sense but might be too verbose to be popular:
(defalias 'string-downcase #'downcase)
(defalias 'string-upcase #'upcase)
(defalias 'string-format #'format)      ;FIXME: toolong, unrenamable
(defalias 'string-concat #'concat)      ;FIXME: unrenamable

;;;; File names
(defalias 'file-name-expand #'expand-file-name)
(defalias 'file-name-abbreviate #'abbreviate-file-name)
(defalias 'file-name-of-directory #'directory-file-name)
(defalias 'file-name-substitute-envvars #'substitute-in-file-name)
(defalias 'file-name-convert-standard #'convert-standard-filename)

;;;;; File name handlers
(defalias 'file-name-handler-find #'find-file-name-handler)
(defvaralias 'file-name-handler-inhibit inhibit-file-name-handlers)
(defvaralias 'file-name-handler-inhibit-operation inhibit-file-name-operation)

;;;; Files
(defalias 'file-delete #'delete-file)
(defalias 'file-copy #'copy-file)
(defalias 'file-rename #'rename-file)
(defalias 'file-add-new-name #'add-name-to-file)
(defalias 'file-symlink #'make-symbolic-link)
(defalias 'file-recode-name #'recode-file-name)
(defalias 'file-insert-contents #'insert-file-contents)
(defalias 'file-insert-contents-literally #'insert-file-contents-literally)

;;;; Regular expressions
(defalias 're-match #'looking-at)
(defalias 're-match-posix #'posix-looking-at)
(defalias 're-match-back #'looking-back)
(defalias 're-match-p #'looking-at-p)
(defalias 're-search-string #'string-match) ;Should it be `re-string-search'?
(defalias 're-search-string-posix #'posix-string-match)
(defalias 're-search-string-p #'string-match-p)
(defalias 're-replace-in-string #'replace-regexp-in-string)
(defalias 're-search-forward-posix #'posix-search-forward)
(defalias 're-search-backward-posix #'posix-search-backward)
;;;; Match data
;; FIXME: We could either use the `match-' prefix for those (which
;; minimizes changes), or put it under the `re-' prefix.
;; (defalias 'match-replace #'replace-match)
(defalias 're-match-data #'match-data)
(defalias 're-set-match-data #'set-match-data)
(defalias 're-replace-match #'replace-match)
;; FIXME: save-match-data?
(defalias 're-submatch #'match-string)
(defalias 're-submatch-no-properties #'match-string-no-properties)
(defalias 're-submatch-beg #'match-beginning)
(defalias 're-submatch-end #'match-end)
(defalias 're-submatch-p #'match-beginning
  "Return non-nil if SUBEXP did match.")

;;;; Alists
;; FIXME: I doubt this will get much traction, since all the popular functions
;; affected a significantly lengthened.  "assoc" and "assq" already imply
;; "alist" to most Lispers IMO, so the new names sound redundant.
;; IOW, this probably belongs in prefixed-core-extras.
(defalias 'alist-assoc #'assoc)
(defalias 'alist-rassoc #'rassoc)
(defalias 'alist-assq #'assq)
(defalias 'alist-rassq #'rassq)
(defalias 'alist-assoc-default #'assoc-default)
(defalias 'alist-copy #'copy-alist)
(defalias 'alist-assq-delete-all #'assq-delete-all)
(defalias 'alist-assoc-delete-all #'assoc-delete-all)
(defalias 'alist-rassq-delete-all #'rassq-delete-all)

;;;; Plists
(defalias 'plist-get-lax #'lax-plist-get)
(defalias 'plist-put-lax #'lax-plist-put)

;;;; Buffer
;; FIXME: The notion of buffer is kind of omnipresent in Elisp
;; so it's easy to go overboard here, and there are many
;; functions which are so frequently used that it's virtually
;; impossible to rename them.
;; IOW, I think most of the below belong to prefixed-core-extras.
(defalias 'buffer-current #'current-buffer) ;FIXME: unrenamable
(defalias 'buffer-set #'set-buffer)         ;FIXME: unrenamable, badname
(defalias 'buffer-rename #'rename-buffer)
(defalias 'buffer-get #'get-buffer)     ;FIXME: unrenamable, badname
(defalias 'buffer-get-or-create #'get-buffer-create)
(defalias 'buffer-generate-new-name #'generate-new-buffer-name)
(defalias 'buffer-generate-new #'generate-new-buffer)
(defalias 'buffer-kill #'kill-buffer)
(defalias 'buffer-make-indirect #'make-indirect-buffer)
(defalias 'buffer-clone-indirect #'clone-indirect-buffer)
(defalias 'buffer-base #'buffer-base-buffer)
(defalias 'buffer-gap-position #'gap-position) ;FIXME: unused
(defalias 'buffer-gap-size #'gap-size)
(defalias 'buffer-set-modified-p #'set-buffer-modified-p)
(defalias 'buffer-restore-modified-p #'restore-buffer-modified-p)
(defalias 'buffer-not-modified #'not-modified)
;; FIXME: The ones below are about *file* buffers rather than about buffers
;; in general, I think that's why they don't have "buffer" in their names.
(defalias 'buffer-get-file #'get-file-buffer)
(defalias 'buffer-find-visiting #'find-buffer-visiting)
(defalias 'buffer-set-visited-file-name #'set-visited-file-name)
(defalias 'buffer-verify-visited-file-modtime #'verify-visited-file-modtime)
(defalias 'buffer-clear-visited-file-modtime #'clear-visited-file-modtime)
(defalias 'buffer-visited-file-modtime #'visited-file-modtime)
(defalias 'buffer-set-visited-file-modtime #'set-visited-file-modtime)
(defalias 'buffer-ask-user-about-supersession-threat #'ask-user-about-supersession-threat)
(defalias 'buffer-read-only-mode #'read-only-mode) ;FIXME: notspecific
(defalias 'buffer-barf-if-read-only #'barf-if-buffer-read-only) ;FIXME: notspecific
;; These manage the lists of buffers rather than buffers themsevles.
(defalias 'buffer-other #'other-buffer)
(defalias 'buffer-last #'last-buffer)
(defalias 'buffer-bury #'bury-buffer)
(defalias 'buffer-unbury #'unbury-buffer)


(provide 'prefixed-core)
;;; prefixed-core.el ends here
