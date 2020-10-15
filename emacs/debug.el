(toggle-debug-on-error t)
(load-file "/home/tfb/emacspeak/current/lisp/emacspeak-setup.el")

(require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; ;; refresh manually to avoid waiting time at every startup
;; (package-refresh-contents)

;; (unless (package-installed-p 'use-package)
;;   (package-install 'use-package))
(require 'use-package)

;; ;; EVIL
(use-package evil
  :ensure t
  :config
  (evil-mode 1))
