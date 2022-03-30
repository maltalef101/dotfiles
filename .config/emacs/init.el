;;; init.el -- My Emacs config
;-*-Emacs-Lisp-*-

(defun memacs/display-startup-time ()
  (message "[STARTUP] Emacs loaded in %s with %d garbage collections."
	   (format "%.2f seconds"
		   (float-time
		    (time-subtract after-init-time before-init-time)))
	   gcs-done))

(add-hook 'emacs-startup-hook #'memacs/display-startup-time)

;; Killing all buffers
(defun memacs/kill-all-buffers ()
	(interactive)
	(mapcar 'kill-buffer (buffer-list))
	(delete-other-windows))

(global-set-key (kbd "C-c K") 'memacs/kill-all-buffers)

(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(menu-bar-mode -1)	   ; Disable the menu bar
(tool-bar-mode -1)	   ; Disable the toolbar
(tooltip-mode -1)	   ; Disable to
(scroll-bar-mode -1)   ; Disable visible scrollbar
(tab-bar-mode 1)

(fset 'yes-or-no-p 'y-or-n-p) ; Sensible prompts

;; Vim-like scrolling
(setq scroll-step 1)
(setq scroll-margin 10)
(setq scroll-conservatively 101)
(setq auto-window-vscroll nil)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)

(setq user-emacs-directory "~/.config/emacs")

;; Backups stay in a confined directory
(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))

;; Auto-saves also stay in a confined directory
(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

(setq projectile-known-projects-file (expand-file-name "tmp/projectile-bookmarks.eld" user-emacs-directory)
      lsp-session-file (expand-file-name "tmp/.lsp-session-v1" user-emacs-directory))

;; Setup the visible bell
(setq visible-bell t)

;; Matching parentheses
(show-paren-mode)
(electric-pair-mode)
(setq show-paren-delay 0)

;; Indentation
(setq-default tab-width 4)
(setq-default evil-shift-width tab-width)
;; (TODO: learn how to manage indentation in emacs)
;; (setq-default indent-tabs-mode nil)
;; (setq-default tab-width 2)
(setq-default c-basic-offset 4)
;; (defvaralias 'ruby-indent-level 'tab-width)
;; (defvaralias 'sgml-basic-offset 'tab-width)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Column number in modebar
(column-number-mode)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Disable line numbers in some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; === PACKAGE RELATED STUFF ===

;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "http://elpa.gnu.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpy" . "https://jorgenschaefer.github.io/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Intialize use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package no-littering)

(use-package unicode-fonts
  :config
  (unicode-fonts-setup))

(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  :config
  (load-theme 'doom-gruvbox t))

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (autp-package-update-prompt-before-update t)
  (auto-package-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(defun memacs/evil-hook ()
	 (dolist (mode '(custom-mode
		  eshell-mode
		  git-rebase-mode
		  erc-mode
		  circe-server-mode
		  circe-chat-mode
		  circe-query-mode
		  sauron-mode
		  term-mode))
	   (add-to-list 'evil-emacs-state-modes mode)))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-fu)
  ;; :hook (evil-mode . memacs/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package undo-fu)

(use-package undo-fu-session
  :config
  (global-undo-fu-session-mode))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package ws-butler
  :hook ((text-mode . ws-butler-mode)
	 (prog-mode . ws-butler-mode)))

(use-package ivy
  :diminish
  :bind(("C-s" . swiper)
	:map ivy-minibuffer-map
	("TAB" . ivy-alt-done)
	("C-l" . ivy-alt-done)
	("C-j" . ivy-next-line)
	("C-k" . ivy-previous-line)
	:map ivy-switch-buffer-map
	("C-k" . ivy-previous-line)
	("C-l" . ivy-done)
	("C-d" . ivy-switch-buffer-kill)
	:map ivy-reverse-i-search-map
	("C-k" . ivy-previous-line)
	("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :diminish counsel-mode
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-switch-buffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package yasnippet
  :config
  (yas-global-mode))
(use-package yasnippet-snippets)

(use-package swiper
  :commands (swiper))

(use-package all-the-icons)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package treemacs
  :commands (treemacs))

(use-package general
  :config
  (general-create-definer memacs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (memacs/leader-keys
    "t" '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "up")
  ("k" text-scale-decrease "down")
  ("f" nil "finished" :exit t))

(memacs/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/dev")
    (setq projectile-project-search-path '("~/dev")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :config
  (setq magit-status-buffer-switch-function 'switch-to-buffer))

;; FIXME: find a better fixme package. This one uses `cl`, and `cl` has been
;; deprecated for a long time now.
;; (use-package button-lock
;;   :diminish button-lock-mode)
;; (use-package fixmee
;;   :diminish fixmee-mode
;;   :hook (prog-mode . fixmee-mode))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump)
	 ("C-x d" . dired-single-magic-buffer))
  :custom ((dired-listing-switches "-agoh --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer
    [remap dired-find-file] 'dired-single-buffer
    [remap dired-up-directory] 'dired-single-up-directory))

(use-package dired-single)

(use-package diredfl
  :hook (dired-mode . diredfl-mode))

(use-package dired-open
  :after dired
  :config
;;  (add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "sxiv")
				("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :after dired
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

(use-package auctex
  :file "\\.tex\\'"
  :hook (latex-mode . company-mode))

(use-package crontab-mode)

;; LSP and language specific stuff
(use-package tree-sitter)
(use-package tree-sitter-langs)

(defun memacs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . memacs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-signature-auto-activate nil)
  (setq lsp-tex-server digestif)
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-sideline-show-symbol nil)
  :custom
  (lsp-ui-doc-position 'at-point)
  )

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy
  :after lsp)

(use-package flycheck
  :defer t
  :hook (lsp-mode . flycheck-mode))

(use-package company
  :hook (prog-mode . company-mode)
  :bind
  (:map company-active-map
        ("<tab>" . company-complete-selection))
  ;; (:map lsp-mode-map
  ;;       ("<tab>" . company-indent-or-complete-common))
  :custom 
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

;; TypeScript and JavaScript
(use-package typescript-mode
  :mode "\\*.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(defun memacs/set-js-indentation ()
  (setq js-indent-level 2)
  (setq evil-shift-width js-indent-level)
  (setq-default tab-width 2))

(use-package js2-mode
  :mode "\\*.js\\'"
	:hook (js2-mode . lsp-deferred)
  :config
  ;; Use js2-mode for Node scripts
  (add-to-list 'magic-mode-alist '("#!/usr/bin/env node" . js2-mode))

  (setq js2-mode-show-strict-warnings nil)

  (add-hook 'js2-mode-hook #'memacs/set-js-indentation)
  (add-hook 'json-mode-hook #'memacs/set-js-indentation))

(use-package rjsx-mode
	:mode "\\*.jsx\\'"
	:hook (rjsx-mode . lsp-deferred)
	:config

(use-package prettier-js
  :mode "\\*.js.*\\'"
  :after js2-mode
	:hook (js2-mode . prettier-js-mode)
  :config
  (setq prettier-js-show-errors nil))

(dolist (mode '(c-mode-hook
		c++-mode-hook
		objc-mode-hook
		cuda-mode-hook))
  (add-hook mode (lambda () (lsp))))

;; C/C++
;; (use-package ccls
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;; 	 (lambda () (require 'ccls) (lsp))))

(use-package cmake-mode
  :mode "\\CMakeLists.txt\\'")

;; Python
(use-package python-mode
  :mode "\\.py\\'"
  :ensure nil
  :hook (python-mode . lsp-deferred)
  :custom
  (python-shell-interpreter "python3"))

;; FIXME: Removing this hook shouldn't be necessary.
;;
;; (remove-hook 'kill-emacs-hook 'pcache-kill-emacs-hook)

;; Testing
(put 'dired-find-alternate-file 'disabled nil)
