;;; .gnus --- Gnus configuration
;;;
;;; Commentary:
;;;
;;;    This file customizes Gnus.
;;;
;;; Code:

(require 'gnus)
;; (require 'nnimap)
;; (require 'nnir)
;; (require 'smptmail)

(setq gnus-inhibit-startup-message t)

(setq gnus-select-method '(nntp "news.gmane.io"))

;; (add-to-list 'gnus-secondary-select-methods
;;              '(nnimap "gmail"
;;                       (nnimap-address "imap.gmail.com")
;;                       (nnimap-server-port 993)
;;                       (nnimap-stream ssl)
;;                       (nnir-search-engine imap)
;;                       (nnmail-expiry-target "nnimap+gmail:[Gmail]/Trash")
;;                       (nnmail-expiry-wait 90)))
;;

(setq gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject)

(setq gnus-thread-sort-functions '(gnus-thread-sort-by-most-recent-date
                                   (not gnus-thread-sort-by-number)))
(setq gnus-thread-hide-subtree t)

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; ;; synchronize newsgroups using IMAP
;; (setq gnus-cloud-method "imap.gmail.com")

;; (setq message-send-mail-function 'smtpmail-send-it)
;; (setq smtpmail-default-smtp-server "smtp.gmail.com")
;; (setq smtpmail-smtp-service 587)
;; (setq smtpmail-local-domain "home")

(provide '.gnus)
;;; .gnus ends here
