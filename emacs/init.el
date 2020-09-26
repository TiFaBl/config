(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; refresh manually to avoid waiting time at every startup
;;(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;(defcustom espeak-default-speech-rate 250)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" default)))
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-yasnippet elpy-module-django elpy-module-sane-defaults)))
 '(espeak-default-speech-rate 320)
 '(org-hierarchical-todo-statistics nil t)
 '(package-selected-packages
   (quote
    (helpful ido-completing-read+ ivy all-the-icons doom-modeline projectile evil-org flycheck which-key magit solarized-theme elpy evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; UI
  (unless (eq window-system 'ns)
    (menu-bar-mode -1))
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
  (when (fboundp 'horizontal-scroll-bar-mode)
    (horizontal-scroll-bar-mode -1))
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
(define-key global-map "\C-ca" 'org-agenda)

(setq org-todo-keywords
      '(
        (sequence "IDEA(i)" "TODO(t)" "|" "STRT(s)" "WAIT(w)" "|" "DONE(d)")
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

;; and some evil-org to go along with it
;; for config inspiration, go to https://github.com/Somelauw/evil-org-mode/blob/master/doc/example_config.el
(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  )

(add-hook 'org-mode-hook
 (lambda ()
   (evil-org-mode)
   ;; Custom mappings
   (evil-define-key 'motion org-agenda-mode-map
     ;; motion
     "j" 'evil-next-line
     "k" 'evil-previous-line
     )))

;; MAGIT
 (use-package magit
   :ensure t
   :bind
   ("C-x g" . magit-status)
  )
;; (global-set-key (kbd "C-x g") 'magit-status)

 ;; Projectile
(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map)
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
	 ("C-h v" . #'helpful-variable)
	 ("C-h k" . #'helpful-key)
	 ))
  

;; Python
(use-package elpy
  :ensure t
  :init
  (setq elpy-rpc-virtualenv-path 'default)
  (elpy-enable))

;; EVIL
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

;;Editor / Globals
; turn line numbers on
;; (when (version<= "26.0.50" emacs-version )
;;   (global-display-line-numbers-mode))
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
;; Make F6 cycle through windows (in accordance to Windows and Office) while having emacspeak tell the names
(global-set-key (kbd "<f6>") 'other-window)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Completion
(use-package ido
  :ensure t
  :config
  (setq ido-everywhere t
	ido-enable-flex-matching t)
  (ido-mode 1))
(use-package ido-completing-read+
  :ensure t
  :config
  (ido-ubiquitous-mode 1))
;;(use-package ivy
;;   :diminish
;;   :bind (("C-s" . swiper)
;;          :map ivy-minibuffer-map
;;          ("TAB" . ivy-alt-done)	
;;          ("C-l" . ivy-alt-done)
;;          ("C-j" . ivy-next-line)
;;          ("C-k" . ivy-previous-line)
;;          :map ivy-switch-buffer-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-l" . ivy-done)
;;          ("C-d" . ivy-switch-buffer-kill)
;;          :map ivy-reverse-i-search-map
;;         ("C-k" . ivy-previous-line)
;;          ("C-d" . ivy-reverse-i-search-kill))
;;   :config
;;   (ivy-mode 1))

(provide 'init)
;;;
