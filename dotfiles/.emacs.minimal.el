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
 '(browse-url-browser-function 'eww-browse-url)
 '(column-number-mode t)
 '(custom-enabled-themes '(manoj-dark))
 '(custom-safe-themes
   '("d6da24347c813d1635a217d396cf1e3be26484fd4d05be153f3bd2b293d2a0b5" "0568a5426239e65aab5e7c48fa1abde81130a87ddf7f942613bf5e13bf79686b" default))
 '(display-time-mode t)
 '(dynamic-completion-mode t)
 '(electric-pair-mode t)
 '(icomplete-mode t)
 '(indent-tabs-mode nil)
 '(minibuffer-eldef-shorten-default t)
 '(minibuffer-electric-default-mode t)
 '(minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
 '(package-selected-packages '(eldoc eglot flymake modus-themes project xref))
 '(prog-mode-hook '(flyspell-prog-mode flymake-mode))
 '(save-place-mode t)
 '(savehist-mode t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(text-mode-hook '(turn-on-flyspell text-mode-hook-identify))
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(vc-make-backup-files t)
 '(version-control t)
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
