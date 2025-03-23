;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Buffer-menu-group-by '(Buffer-menu-group-by-root))
 '(Buffer-menu-human-readable-sizes t)
 '(browse-url-browser-function 'eww-browse-url)
 '(column-number-mode t)
 '(comment-empty-lines t)
 '(completion-auto-select 'second-tab)
 '(completions-detailed t)
 '(completions-format 'one-column)
 '(completions-sort 'historical)
 '(custom-safe-themes
   '("2b0fcc7cc9be4c09ec5c75405260a85e41691abb1ee28d29fcd5521e4fca575b"
     "7fea145741b3ca719ae45e6533ad1f49b2a43bf199d9afaee5b6135fd9e6f9b8"
     default))
 '(desktop-restore-frames nil)
 '(desktop-save-mode t)
 '(dictionary-use-single-buffer t)
 '(diff-default-read-only t)
 '(display-fill-column-indicator-warning t)
 '(display-time-mode t)
 '(dynamic-completion-mode t)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(editorconfig-mode t)
 '(eglot-autoshutdown t)
 '(eglot-extend-to-xref t)
 '(eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider))
 '(electric-layout-mode t)
 '(electric-pair-mode t)
 '(enable-recursive-minibuffers t)
 '(flymake-show-diagnostics-at-end-of-line t)
 '(global-completion-preview-mode t)
 '(global-goto-address-mode t)
 '(global-so-long-mode t)
 '(goto-line-history-local t)
 '(grep-use-headings t)
 '(history-delete-duplicates t)
 '(icomplete-in-buffer t)
 '(icomplete-mode t)
 '(imenu-flatten 'annotation)
 '(indent-tabs-mode nil)
 '(isearch-lazy-count t)
 '(lazy-highlight-buffer t)
 '(log-edit-confirm t)
 '(minibuffer-eldef-shorten-default t)
 '(minibuffer-electric-default-mode t)
 '(minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
 '(minibuffer-visible-completions t)
 '(mode-line-compact t)
 '(package-selected-packages
   '(eldoc eglot ef-themes flymake modus-themes project standard-themes
           xref))
 '(proced-enable-color-flag t)
 '(proced-show-remote-processes t)
 '(prog-mode-hook '(flyspell-prog-mode flymake-mode))
 '(project-compilation-buffer-name-function 'project-prefixed-buffer-name)
 '(project-kill-buffers-display-buffer-list t)
 '(project-mode-line t)
 '(project-switch-commands 'project-prefix-or-any-command)
 '(project-switch-use-entire-map t)
 '(repeat-mode t)
 '(save-place-mode t)
 '(savehist-mode t)
 '(scroll-bar-mode nil)
 '(server-mode t)
 '(show-paren-context-when-offscreen t)
 '(show-paren-mode t)
 '(show-paren-when-point-in-periphery t)
 '(show-paren-when-point-inside-paren t)
 '(size-indication-mode t)
 '(speedbar-prefer-window t)
 '(text-mode-hook '(turn-on-flyspell text-mode-hook-identify))
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(truncate-lines t)
 '(use-short-answers t)
 '(vc-allow-rewriting-published-history 'ask)
 '(vc-git-annotate-switches '("--ignore-all-space"))
 '(vc-git-diff-switches '("--stat" "--stat-width=1024" "--minimal"))
 '(vc-git-log-switches '("--decorate" "--stat" "--stat-width=1024" "--minimal"))
 '(vc-make-backup-files t)
 '(version-control t)
 '(visible-bell t)
 '(which-func-display 'header)
 '(which-function-mode t)
 '(winner-mode t)
 '(xref-show-definitions-function 'xref-show-definitions-completing-read))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
