;; mu4e
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(require 'smtpmail)

(setq mu4e-maildir "/home/tfb/mail/gmail")

;; save attachment to my desktop (this can also be a function)
(setq mu4e-attachment-dir "~/Desktop")

;; attempt to show images when viewing messages
(setq mu4e-view-show-images t)

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(setq mu4e-maildir-shortcuts
    '( (:maildir "/INBOX"              :key ?i)
       (:maildir "/[Gmail].Sent Mail"  :key ?s)
       (:maildir "/[Gmail].Trash"      :key ?t)
       (:maildir "/[Gmail].All Mail"   :key ?a)))

;; I have my "default" parameters from Gmail
(setq mu4e-sent-folder "/[Gmail].Sent Mail"
	mu4e-sent-messages-behavior 'delete ;; Unsure how this should be configured
	mu4e-drafts-folder "/[Gmail].Drafts"
	mu4e-trash-folder "/[Gmail].Trash"
	user-mail-address "till.blesik@gmail.com"
	smtpmail-default-smtp-server "smtp.gmail.com"
	smtpmail-smtp-server "smtp.gmail.com"
	smtpmail-smtp-service 587)

;; Now I set a list of 
(defvar my-mu4e-account-alist
  '(("gmail"
     (mu4e-sent-folder "/gmail/[Gmail].Sent Mail")
     (mu4e-trash-folder "/gmail/[Gmail].Trash")
     (user-mail-address "till.blesik@gmail.com")
     (smtpmail-smtp-user "till.blesik")
     (smtpmail-local-domain "gmail.com")
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587)
     )
    ;; Include any other accounts here ...
    ))

(defun my-mu4e-set-account ()
  "Set the account for composing a message.
   This function is taken from: 
     https://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html"
  (let* ((account
    (if mu4e-compose-parent-message
	  (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
    (string-match "/\\(.*?\\)/" maildir)
    (match-string 1 maildir))
	(completing-read (format "Compose with account: (%s) "
	       (mapconcat #'(lambda (var) (car var))
	      my-mu4e-account-alist "/"))
	     (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
	     nil t nil nil (caar my-mu4e-account-alist))))
   (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
  (mapc #'(lambda (var)
	(set (car var) (cadr var)))
	  account-vars)
	(error "No email account found"))))
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

