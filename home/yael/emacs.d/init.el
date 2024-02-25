;; [Initialization]


;; Garbage collection setting
(setq gc-cons-percentage 0.6)

;; Compiler warning
(setq native-comp-async-report-warnings-errors 'silent) ;; native-comp warning
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))

;; Disable lock files
(setq create-lockfiles nil)

;; Save backup files in one place, under the emacs directory
(make-directory (expand-file-name "tmp/backups/" user-emacs-directory) t)
(make-directory (expand-file-name "tmp/autosave/" user-emacs-directory) t)
(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))
(setq auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/autosave/" user-emacs-directory))))
(setq backup-by-copying t)

;; Keep custom variables in a separate file
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)




;; [Emacs Package Management]


;; Set up "package" and add package archives
(require 'package)
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(package-initialize)

;; Bootstrap "use-package" package 
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq package-enable-at-startup nil)
(setq use-package-always-ensure t)
(setq use-package-verbose nil)

;; Keep package files in a separate directory
(use-package no-littering
  :ensure t)

;; Quelpa
(use-package quelpa)
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)

;; Straight package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Auto update packages
(use-package auto-package-update
  :ensure t
  :custom 
  (auto-package-update-interval 7) 
  (auto-package-update-prompt-before-update nil) 
  (auto-package-update-hide-results t)
  :config 
  (auto-package-update-maybe))




;; [Emacs Garbage Collection]


(use-package gcmh
  :ensure t
  :diminish gcmh-mode
  :config
  (setq gcmh-idle-delay 5
	      gcmh-high-cons-threshold (* 64 1024 1024)) ; 64 mb
  (gcmh-mode 1)
  (add-hook 'emacs-startup-hook
            (lambda ()
              (setq gc-cons-percentage 0.1))) ;;; Default value for 'gc-cons-percentage
  (add-hook 'emacs-startup-hook
            (lambda ()
              (message "Emacs ready in %s with %d garbade collections."
                       (format "%.2f seconds"
		                           (float-time
		                            (time-subtract after-init-time before-init-time)))
                       gcs-done))))




;; [Encoding & Input]


;; Encoding
(use-package emacs
  :init
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix))
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2))

;; [Emacs Appearance]


;; Frame inhibit implied resize
(setq frame-inhibit-implied-resize t)

;; Don't show splash screen
(setq inhibit-startup-message t)

;; Prevent using UI dialogs for prompts
(setq use-dialog-box nil)

;; Minimal UI
(tool-bar-mode -1)
;(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq visible-bell 0)
(setq make-pointer-invisible t)

;; Show matching parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Show selected region
(transient-mark-mode t)

;; Better scrolling
(setq scroll-step 1)
(setq scroll-margin 1)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq auto-window-vscroll nil)
(setq fast-but-imprecise-scrolling nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq pixel-scroll-precision-mode t)

;; Horizontal Scroll
(setq hscroll-step 1)
(setq hscroll-margin 1)

;; Follow focus
(setq focus-follows-mouse t)
(setq mouse-autoselect-window-window t)

;; Show line number in source code
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq linum-format "%4d ")

;; Highlight cursor line
(add-hook 'prog-mode-hook 'hl-line-mode)
(add-hook 'org-mode-hook 'hl-line-mode)
;; Disable cursor line in vterm(terminal) mode, because it's weird
(add-hook 'vterm-mode-hook (lambda () (hl-line-mode -1)))

;; Match and highlight parenthesis,
(electric-pair-mode 1)
(setq electric-pair-pairs
      '((?\" . ?\")
        (?\{ . ?\})))

;; but don't pair ' (quote in lisp) or < (could be a plain comparison)
(setq electric-pair-inhibit-predicate 
      (lambda (c)
        (or (char-equal c ?\')
            (char-equal c ?\<))))




;; [Emacs Theme]
  
;; Font              
(add-to-list 'default-frame-alist '(font . "JetBrains Mono 13"))
(set-face-attribute 'default t :font "JetBrains Mono 13" :height 160 :weight 'regular)

;; Nano Theme
(use-package nano-theme
  :ensure t
  :quelpa (nano-theme
           :fetcher github
           :repo "rougier/nano-theme")
  :config
  (setq nano-fonts-use nil)
  (load-theme 'nano-dark t)
  (add-hook 'after-make-frame-functions
	          (lambda (frame)
	            (select-frame frame)
	            (when (display-graphic-p frame)
		            (setq nano-fonts-use nil)
		            (load-theme 'nano-dark t)
		            (nano-mode)
		            (set-face-attribute 'default nil :font "JetBrains Mono 13")
		            (set-frame-font "JetBrains Mono 13" nil t))))
  (nano-mode))

;; Nano Modeline
(use-package nano-modeline
  :ensure t
  :after nano-theme
  :init
  ;; Only show the major mode
  (setq-default mode-line-format
		            `((:propertize " %@%Z  [%b]  L%l (%p)    ")
		              (:propertize (vc-mode vc-mode) face (:weight normal))
		              (:propertize ("  %M  " mode-name)
			                         help-echo "Major mode\n\
                                mouse-1: Display major mode menu\n\
                                mouse-2: Show help for major mode\n\
                                mouse-3: Toggle minor modes"
			                         mouse-face mode-line-highlight
			                         local-map ,mode-line-major-mode-keymap)))
  :config
  (add-hook 'prog-mode-hook            #'nano-modeline-prog-mode)
  (add-hook 'text-mode-hook            #'nano-modeline-text-mode)
  (add-hook 'org-mode-hook             #'nano-modeline-org-mode)
  (add-hook 'pdf-view-mode-hook        #'nano-modeline-pdf-mode)
  (add-hook 'mu4e-headers-mode-hook    #'nano-modeline-mu4e-headers-mode)
  (add-hook 'mu4e-view-mode-hook       #'nano-modeline-mu4e-message-mode)
  (add-hook 'elfeed-show-mode-hook     #'nano-modeline-elfeed-entry-mode)
  (add-hook 'elfeed-search-mode-hook   #'nano-modeline-elfeed-search-mode)
  (add-hook 'term-mode-hook            #'nano-modeline-term-mode)
  (add-hook 'xwidget-webkit-mode-hook  #'nano-modeline-xwidget-mode)
  (add-hook 'messages-buffer-mode-hook #'nano-modeline-message-mode)
  (add-hook 'org-capture-mode-hook     #'nano-modeline-org-capture-mode)
  (add-hook 'org-agenda-mode-hook      #'nano-modeline-org-agenda-mode))

;; Icon pack
(use-package all-the-icons
  :if (display-graphic-p)
  :ensure t)




;; [File Management]


;; Automatically revert buffers for changed files
(global-auto-revert-mode 1)

;; Automatically update file list in Dired(Emacs file explorer)
(setq global-auto-revert-non-file-buffers t)

;; recentf keeps history of recently accessed files
(use-package recentf
  :ensure nil
  :config
  (setq recentf-max-saved-items 128)
  (setq recentf-filename-handlers
	      (append '(abbreviate-file-name) recentf-filename-handlers))
  (recentf-mode))

;; Remember recently edited file
(recentf-mode 1)
(save-place-mode 1)

;; Remember minibuffer command history
(setq history-length 16)
(savehist-mode 1)

;; Magit: use git in emacs
(use-package magit)

;; Undo tree
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  (setq undo-tree-visualizer-diff t)
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-auto-save-history nil))




;; [Emacs Key Binding]


;; Shows key binding suggestions when you type keys
(use-package which-key
  :ensure t
  :config
  (setq which-key-idle-delay 0.3)
  (setq which-key-popup-type 'frame)
  (which-key-mode)
  (which-key-setup-side-window-bottom)
  (set-face-attribute 'which-key-local-map-description-face nil :weight 'bold))




;; [Completion]


;; helm provides incremental completion through minibuffer
(use-package helm
  :ensure t
  :init
  (helm-mode 1)
  :bind
  ("C-x C-f" . 'helm-find-files)
  ("C-x C-b" . 'helm-buffers-list)
  ("M-x" . 'helm-M-x)
  :config
  (helm-autoresize-mode 1)
  (setq helm-ff-skip-boring-files t)
  (customize-set-variable 'helm-boring-file-regexp-list (cons "^\\..+" helm-boring-file-regexp-list)))

