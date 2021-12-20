
;;; init.el -- My Emacs config
;-*-Emacs-Lisp-*-

(setq-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq locale-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" default))
 '(package-selected-packages '(auto-complete powerline-evil gruvbox-theme evil))
 '(tab-stop-list 4)
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(unless (package-installed-p 'auto-complete)
  (package-install 'auto-complete))

(unless (package-installed-p 'powerline)
  (package-install 'powerline 'powerline-evil))
(require 'powerline)
(require 'powerline-evil)
(powerline-default-theme)

(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; disable bell
(setq visible-bell t)

;; display line number
(setq display-line-numbers 'relative)

;; load theme
(load-theme 'gruvbox-dark-hard t)

(ac-config-default)

;; no toolbar or scrollbar
(scroll-bar-mode -1)
(tool-bar-mode -1)

(show-paren-mode 1)
(setq show-paren-delay 0)

(column-number-mode t)

(setq tramp-default-method "ssh")
(setq tramp-syntax 'simplified)

(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indicate-empty-lines t)
(setq-default indent-tabs-mode nil)

(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(setq tab-width 4)
