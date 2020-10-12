;;; package --- Summary
;;; my init file
;;; Commentary:
;;, this will be moved to literate soon
;;; Code:

(load-file "/home/tfb/emacspeak/r52/lisp/emacspeak-setup.el")
;; (load-file "/home/tfb/emacspeak/current/lisp/emacspeak-setup.el")
(dtk-set-rate 275)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
;; (package-initialize)
;; refresh manually to avoid waiting time at every startup
(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" default))
 '(elpy-modules
   '(elpy-module-company elpy-module-eldoc elpy-module-folding elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-yasnippet elpy-module-django elpy-module-sane-defaults))
 '(gc-cons-threshold 20000000)
 '(org-hierarchical-todo-statistics nil)
 '(package-selected-packages
   '(vterm move-text expand-region org-bullets company-quickhelp ess flyspell-correct-ido flyspell-correct ido evil-collection flx-ido smex helpful ido-completing-read+ all-the-icons doom-modeline projectile evil-org flycheck which-key magit solarized-theme elpy evil use-package))
 '(sentence-end-double-space nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;use larger font
(set-face-attribute 'default nil :height 140)

;; Create my own keymapxs
(define-prefix-command 'tools-map)
(global-set-key (kbd "C-t") 'tools-map)

;; UI
(unless (eq window-system 'ns)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))
;; Windmove is built into Emacs. It lets you move point from window to window using Shift and the arrow keys.
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
;; Make window configuration undo'able
(when (fboundp 'winner-mode)
  (winner-mode 1))
;; Theme
(load-theme 'deeper-blue t)
;; Pretty icons
(use-package all-the-icons)
;; Use DOOM modeline to prettify it a bit
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; which-key to display the options for keys/chords
 (use-package which-key
   :ensure t
   :diminish which-key-mode
   :config
   (which-key-mode 1))


;;org
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/"))
(setq org-hierarchical-todo-statistics nil)
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 3))))
(setq org-default-notes-file (concat org-directory "/capture.org"))
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)


(setq org-todo-keywords
      '(
        (sequence "IDEA(i)" "TODO(t)" "|" "STRT(s)" "WAIT(w)" "|" "DONE(!d)")
        (sequence "|" "CANCELED(c@)" "DELEGATED(l@)" "SOMEDAY(f)")
        ))

(setq org-todo-keyword-faces
      '(("IDEA" . (:foreground "GoldenRod" :weight bold))
        ("STRT" . (:foreground "OrangeRed" :weight bold))
        ("WAIT" . (:foreground "coral" :weight bold))
        ("CANCELED" . (:foreground "LimeGreen" :weight bold))
        ("DELEGATED" . (:foreground "LimeGreen" :weight bold))
        ("SOMEDAY" . (:foreground "LimeGreen" :weight bold))
        ))

;; ;; and some evil-org to go along with it
;; ;; for config inspiration, go to https://github.com/Somelauw/evil-org-mode/blob/master/doc/example_config.el
;; (use-package evil-org
;;   :ensure t
;;   :after org
;;   :config
;;   (add-hook 'org-mode-hook 'evil-org-mode)
;;   (add-hook 'evil-org-mode-hook
;;             (lambda ()
;; 	      ;; Custom mappings
;; 	      (evil-define-key 'normal org-mode-map
;; 		(kbd "C-c ä") 'org-mark-subtree)
;; 	      (evil-define-key 'motion org-agenda-mode-map
;; 		;; motion
;; 		"j" 'evil-next-line
;; 		"k" 'evil-previous-line)
;; 	      ;; set key theme
;;               (evil-org-set-key-theme)
;; 	      ;; set virtual indentation
;; 	      (org-indent-mode 1)))
;;   (require 'evil-org-agenda)
;;   (evil-org-agenda-set-keys)
;;   )


(use-package org-bullets
  :custom
  (org-bullets-bullet-list '("◉" "○" "▶" "✿" "◆" "✜" "✸"))
  :hook (org-mode . org-bullets-mode))

(add-hook 'org-mode-hook
	  (lambda ()
	    (org-indent-mode t)
   ))

;; MAGIT
 (use-package magit
   :ensure t
   :bind
   ("C-x g" . magit-status)
  )

 ;; Projectile
(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  ("C-t p" . projectile-command-map)
  :config
  (projectile-mode 1))


;; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Helpful to improve the help buffer
(use-package helpful
  :bind (
	 ("C-h f" . #'helpful-callable)
	 ("C-h F" . #'helpful-function)
	 ("C-h v" . #'helpful-variable)
	 ("C-h C" . #'helpful-command)
	 ("C-h k" . #'helpful-key)
	 ("C-c C-d" . #'helpful-at-point)
	 ))
  

;; Python
(use-package elpy
  :ensure t
  :init
  (setq elpy-rpc-virtualenv-path 'default)
  :config
  (elpy-enable))

;; ESS
(use-package ess
  :ensure t)

;; ;; EVIL
;; (use-package evil
;;   :ensure t
;;   :init
;;   (setq evil-want-integration t)
;;   (setq evil-want-keybinding nil)
;;   :config
;;   (evil-define-key 'normal 'global "ä" 'evil-execute-macro)
;;   (evil-mode 1))

;; (use-package evil-collection
;;   :after evil
;;   :ensure t
;;   :config
;;   (evil-collection-init))
;; TODO: EVIL Collection for example for eww
;; https://github.com/emacs-evil/evil-collection


;;Editor / Globals
; turn line numbers on
;; (when (version<= "26.0.50" emacs-version )
;;   (global-display-line-numbers-mode))

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

;; let me replace marked regions by just typing
(delete-selection-mode t)

;; I want to write right words in text-mode and prog-mode
(add-hook 'text-mode-hook 'flyspell-mode)

;; add modes to the prog-mode-hook
(dolist (mode '(flyspell-prog-mode hs-minor-mode))
  (add-hook 'prog-mode-hook mode))
(add-hook 'prog-mode-hook
	  (lambda()
	    (electric-pair-mode t)))

;; Make text movable with M-<up> or <down>
(use-package move-text
  :ensure t
  :config
  ;; (move-text-default-keybindings) is resulting in an error, therefore i am doing the bindings myself
  (global-set-key (kbd "M-<up>") 'move-text-up)
  (global-set-key (kbd "M-<down>") 'move-text-down)
  )

;; Global Keybindings
;; Make F6 cycle through windows (in accordance to Windows and Office) while having emacspeak tell the names
(global-set-key (kbd "<f6>") 'other-window)
;; Make ESC quit stuff
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; orgmode bindings
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; bindings for german layout
(global-set-key (kbd "M-+") 'backward-paragraph)
(global-set-key (kbd "M-#") 'forward-paragraph)

;; provide tools on my tools kdymap
(define-key tools-map (kbd "e") 'eww)
(define-key tools-map (kbd "g") 'magit)
(define-key tools-map (kbd "m") 'mu4e)
(define-key tools-map (kbd "n") 'gnus)
(define-key tools-map (kbd "s") 'eshell)

;; timing not right, therefore moved to projectile load
;; (with-eval-after-load 'projectile
;;     (define-key projectile-mode-map (kbd "C-t p") 'projectile-command-map))

;; make folding keybindings more usable
(add-hook 'hs-minor-mode-hook
	  (lambda ()
	    (define-key hs-minor-mode-map (kbd "C-<tab>") 'hs-toggle-hiding)
	    (define-key hs-minor-mode-map (kbd "C-c ä") (lookup-key hs-minor-mode-map (kbd "C-c @")))
	    ))

(use-package expand-region
  :ensure t
  :bind ("C-#" . er/expand-region))


;; SMEX for smart M-x - https://github.com/nonsequitur/smex
(use-package smex
  :ensure t
  :bind ("M-x" . smex))
;; Completion
(use-package ido
  :ensure t
  :config
  (setq ido-enable-prefix nil
	ido-enable-flex-matching t
	ido-create-new-buffer 'always
	ido-use-filename-at-point 'guess
	ido-max-prospects 10
	ido-default-file-method 'selected-window
	ido-auto-merge-work-directories-length nil)
  (ido-mode 1))
(use-package ido-completing-read+
  :ensure t
  :config
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1))
;; flx-ido - https://github.com/lewang/flx
(use-package flx-ido
  :ensure t
  :config
  (flx-ido-mode 1)
  ;; disable ido faces to see flx highlights
  (setq ido-use-faces nil))
(use-package company
  :bind ( ("M-<tab>" . company-select-next)
	 :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
	 )
  :config
  ;; (setq company-idle-delay 0.1)
  ;; (company-mode 1)
  (global-company-mode t)
  (emacspeak-company-setup))

(use-package company-quickhelp
  :ensure t
  :bind (:map company-active-map
	      ("C-c d" . company-quickhelp-manual-begin))
  :config
  (company-quickhelp-mode 1))

;; Correction
(use-package flyspell-correct
  :after flyspell
  :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))
;; (use-package flyspell-correct-popup
;;   :after flyspell-correct)

;; Hopefully a temporary fix to avoid the missing emacspeak-handle-action-at-point issue
;; https://github.com/tvraman/emacspeak/issues/47
;; (load-file "/home/tfb/emacspeak/current/lisp/emacspeak-wizards.el")

;;  generic auth solution
(use-package auth-source
  :config
  (setq auth-sources '("~/.authinfo.gpg"))
  (setq user-full-name "Till Blesik")
  (setq user-mail-address "till.blesik@gmx.de")

  (defun prot/auth-get-field (host prop)
    "Find PROP in `auth-sources' for HOST entry."
    (let* ((source (auth-source-search :host host))
           (field (plist-get
                   (flatten-list source)
                   prop)))
      (if source
          field
        (user-error "No entry in auth sources")))))


;; mu4e
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(setq mu4e-change-filenames-when-moving t)
(setq mu4e-maildir "~/.mail")
(setq mu4e-get-mail-command "mbsync -a")
(setq mu4e-update-interval 300)
(setq mu4e-context-policy 'pick-first)
(setq mu4e-headers-fields
      '((:from . 22)
	(:subject . 60)
	(:human-date . 12)
	(:flags . 6)
        (:mailing-list . 10)))



(defun my-make-mu4e-context (name address signature)
    "Return a mu4e context named NAME with :match-func matching
  its ADDRESS in From or CC fields of the parent message. The
  context's `user-mail-address' is set to ADDRESS and its
  `mu4e-compose-signature' to SIGNATURE."
    (lexical-let ((addr-lex address))
      (make-mu4e-context :name name
                         :vars `((user-mail-address . ,address)
                                 (mu4e-compose-signature . ,signature))
                         :match-func
                         (lambda (msg)
                           (when msg
                             (or (mu4e-message-contact-field-matches msg :to addr-lex)
                                 (mu4e-message-contact-field-matches msg :cc addr-lex)))))))

;; (setq mu4e-contexts
;;         `( ,(my-make-mu4e-context "TillGMX" "till.blesik@gmx.de"
;;                                   "Mit freundlichen Grüßen,\n Till")
;;            ,(my-make-mu4e-context "GMail" "till.blesik@gmail.com"
;;                                   "Mit freundlichen Grüßen,\n Till")
;;            ,(my-make-mu4e-context "ESCP" "tblesik@escp.eu"
;;                                   "Best regards,\n Till")
;; 	   ,(my-make-mu4e-context "spirit" "ntm.greattfbspirit@gmx.de"
;;                                   "")))

(setq mu4e-contexts
        `(,(make-mu4e-context
            :name "Till" ; Is there no way to specify a key for switching?
            :enter-func (lambda () (mu4e-message "Entering Till"))
            :match-func
	    (lambda (msg)
	      (when msg
		(or
		 (mu4e-message-contact-field-matches msg :to (prot/auth-get-field "Till" :user))
		 (mu4e-message-contact-field-matches msg :cc (prot/auth-get-field "Till" :user))))) 
            :vars `( (user-mail-address . ,(prot/auth-get-field "Till" :user))
		     (mu4e-refile-folder . "/TillGMX/Archives")
		     (mu4e-sent-folder . "/TillGMX/Sent")
		     (mu4e-drafts-folder . "/TillGMX/Drafts")
		     (mu4e-trash-folder . "/TillGMX/Trash")
		    ))
          ,(make-mu4e-context
            :name "spirit"
	    :enter-func (lambda () (mu4e-message "Entering spirit"))
            :match-func
	    (lambda (msg)
	      (when msg
		(or
		 (mu4e-message-contact-field-matches msg :to (prot/auth-get-field "spirit" :user))
		 (mu4e-message-contact-field-matches msg :cc (prot/auth-get-field "spirit" :user)))))
            :vars `( (user-mail-address . ,(prot/auth-get-field "spirit" :user))
		     (mu4e-refile-folder . "/spiritGMX/Archives")
		     (mu4e-sent-folder . "/spiritGMX/Sent")
		     (mu4e-drafts-folder . "/spiritGMX/Drafts")
		     (mu4e-trash-folder . "/spiritGMX/Trash")
		    ))
	  ,(make-mu4e-context
            :name "GMail"
	    :enter-func (lambda () (mu4e-message "Entering GMail"))
            :match-func
	    (lambda (msg)
	      (when msg
		(or
		 (mu4e-message-contact-field-matches msg :to (prot/auth-get-field "GMail" :user))
		 (mu4e-message-contact-field-matches msg :cc (prot/auth-get-field "GMail" :user)))))
            :vars `( (user-mail-address . ,(prot/auth-get-field "GMail" :user))
		     ;; GMail stores them automatically, therefore delete once send
		     (mu4e-sent-messages-behavior . delete)
		     (mu4e-refile-folder . "/TillGMail/[Gmail]/All Mail")
		     (mu4e-drafts-folder . "/TillGMail/[Gmail]/Drafts")
		     (mu4e-trash-folder . "/TillGMail/[Gmail]/Trash")
					))
	  ,(make-mu4e-context
            :name "ESCP"
	    :enter-func (lambda () (mu4e-message "Entering ESCP"))
            :match-func
	    (lambda (msg)
	      (when msg
		(or
		 (mu4e-message-contact-field-matches msg :to (prot/auth-get-field "ESCP" :user))
		 (mu4e-message-contact-field-matches msg :cc (prot/auth-get-field "ESCP" :user)))))
            :vars `( (user-mail-address . ,(prot/auth-get-field "ESCP" :user))
		     ;; GMail stores them automatically, therefore delete once send
		     (mu4e-sent-messages-behavior . delete)
		     (mu4e-refile-folder . "/TillESCP/[Gmail]/All Mail")
		     (mu4e-drafts-folder . "/TillESCP/[Gmail]/Drafts")
		     (mu4e-trash-folder . "/TillESCP/[Gmail]/Trash")
		     ))))

;; waiting for next ubuntu release to use mu 1.4 syntax
;; (add-to-list 'mu4e-bookmarks '(
;;         (:name "Unread messages" :query "flag:unread AND NOT flag:trashed" :key ?u)
;;         (:name "Today's messages" :query "date:today..now" :key ?t)
;;         (:name "Last 7 days" :query "date:7d..now" :key ?w)
;;        (:name "Till Unread" :query ',(format "to:%s %s"
;;                                 (prot/auth-get-field "Till" :user)
;;                                 "AND flag:unread AND NOT flag:trashed")
;;                :key ?T)
;;         (:name "Till Inbox"
;;                :query ',(format "to:%s"
;;                                 (prot/auth-get-field "Till" :user))
;;                :key ?t)
;;         (:name "GMail Unread"
;;                :query ',(format "to:%s %s"
;;                                 (prot/auth-get-field "GMail" :user)
;;                                 "AND flag:unread AND NOT flag:trashed")
;;                :key ?G)
;;         (:name "GMail Inbox"
;;                :query ',(format "to:%s"
;;                                 (prot/auth-get-field "GMail" :user))
;;                :key ?g)
;;         (:name "ESCP Unread"
;;                :query ',(format "to:%s %s"
;;                                 (prot/auth-get-field "ESCP" :user)
;;                                 "AND flag:unread AND NOT flag:trashed")
;;                :key ?E)
;;         (:name "ESCP Inbox"
;;                :query ',(format "to:%s"
;;                                 (prot/auth-get-field "ESCP" :user))
;;                :key ?e)
;; 	(:name "spirit Unread"
;;                :query ',(format "to:%s %s"
;;                                 (prot/auth-get-field "spirit" :user)
;; 				"AND flag:unread AND NOT flag:trashed")
;;                :key ?S)
;; 	(:name "spirit Inbox"
;;                :query ',(format "to:%s"
;;                                 (prot/auth-get-field "spirit" :user))
;;                :key ?s)
;; 	;; ))



(setq mu4e-bookmarks
      '(
	("flag:unread AND NOT flag:trashed" "Unread messages" ?u)
	("date:today..now" "Today's messages" ?d)
	("date:7d..now" "Last 7 days" ?w)
	("flag:attach" "Messages with attachment" ?a)
	((format "to:%s or cc:%s"
		(prot/auth-get-field "Till" :user)
		(prot/auth-get-field "Till" :user))
	"Till"
	?t)
      ((format "to:%s or cc:%s"
	       (prot/auth-get-field "GMail" :user)
	       (prot/auth-get-field "GMail" :user))
       "GMail"
       ?g)
      ((format "to:%s or cc:%s"
	       (prot/auth-get-field "ESCP" :user)
	       (prot/auth-get-field "ESCP" :user))
       "ESCP"
       ?e)
      ((format "to:%s or cc:%s"
	       (prot/auth-get-field "spirit" :user)
	       (prot/auth-get-field "spirit" :user))
       "spirit"
       ?s)
      ))

(setq message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "/usr/bin/msmtp"
      user-full-name "Till Blesik")

 ;; Choose account label to feed msmtp -a option based on From header  
;; in Message buffer; This function must be added to  
;; message-send-mail-hook for on-the-fly change of From address before  
;; sending message since message-send-mail-hook is processed right  
;; before sending message.  
(defun choose-msmtp-account ()  
  (if (message-mail-p)
      (save-excursion
  	(let*
  	    ((from (save-restriction  
  		     (message-narrow-to-headers)  
  		     (message-fetch-field "from")))  
  	     (account
  	      (cond
  	       ((string-match "till.blesik@gmx.de" from) "Till")
	       ((string-match "ntm.greattfbspirit@gmx.de" from) "spirit")
	       ((string-match "tblesik@escp.eu" from) "ESCP")
  	       ((string-match "till.blesik@gmail.com" from) "GMail"))))
 	  (setq message-sendmail-extra-arguments (list '"-a" account))))))

(setq message-sendmail-envelope-from 'header)
(add-hook 'message-send-mail-hook 'choose-msmtp-account)

(provide 'Inuit)
;;;
