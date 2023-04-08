(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(tree-sitter-indent clang-format json-mode rjsx-mode web-mode emmet-mode yaml-mode yaml company-auctex auctex crontab-mode yasnippet-snippets yasnippet cmake-mode flycheck emojify ws-butler tree-sitter-langs tree-sitter modern-cpp-font-lock diredfl dired-hide-dotfiles dired-open dired-single all-the-icons-dired python-mode prettier-js js2-mode typescript-mode company-box company lsp-ivy lsp-treemacs lsp-ui lsp-mode button-lock magit counsel-projectile projectile general treemacs helpful which-key rainbow-delimiters counsel ivy-rich ivy evil-collection undo-fu-session undo-fu doom-modeline evil no-littering auto-package-update doom-themes use-package))
 '(safe-local-variable-values
   '((eval eval
		   (setq-local default-directory
					   (shell-command-to-string "git rev-parse --show-toplevel | tr -d '
'")))
	 (default-directory eval
	   (shell-command-to-string "git rev-parse --show-toplevel | tr -d '
'"))
	 (default-directory shell-command-to-string "git rev-parse --show-toplevel | tr -d '
'")
	 (default-directory shell-command-to-string "git rev-parse --show-toplevel"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tree-sitter-hl-face:function\.call ((t (:inherit font-lock-function-name-face :underline nil)))))
