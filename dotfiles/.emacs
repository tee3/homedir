;;; .emacs --- Emacs user configuration file
;;;
;;; URL: https://tee3.github.com/homedir
;;;
;;; Commentary:
;;;
;;;    This file customizes Emacs for a specific user's needs.
;;;
;;; Code:


;;;
;;; Disable support for decoding 'x-display' in Enriched Text mode
;;; prior to Emacs 25.3 since this is a security hole.
;;;
(when (or (< emacs-major-version 25)
          (and (= emacs-major-version 25) (< emacs-minor-version 3)))
  (eval-after-load "enriched"
    '(defun enriched-decode-display-prop (start end &optional param)
       (list start end))))

;;;
;;; Update the load path to include the user's Lisp files.
;;;
(add-to-list 'load-path (expand-file-name "~/opt/local/share/emacs/site-lisp") t)

;;;
;;; Set up package
;;;
(when (require 'package nil :noerror)

  ;; add packages libraries
  (when (< emacs-major-version 24)
    (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t))
  (when (>= emacs-major-version 24)
    (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t))
  (when (>= emacs-major-version 23)
    (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t))
  (when (>= emacs-major-version 23)
    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

  (package-initialize))

;;;
;;; Bootstrap use-package
;;;
(when (require 'package nil :noerror)
  (when (boundp 'package-pinned-packages)
    (setq package-pinned-packages
          '((use-package . "melpa-stable"))))

  (when (not (package-installed-p 'use-package))

    (package-refresh-contents)

    (package-install 'use-package)))

(unless (require 'use-package nil :noerror)
  (defmacro use-package (name &rest args)
    (unless (member :disabled args)
      (setq message-log-max (+ message-log-max 1))

      (if (require name nil :noerror)
          (message "%s required but not configured" name)
        (message "%s is not available." name)))))

;;;
;;; Configuration
;;;
(defgroup tee3 nil
  "Customization variables in the .emacs file."
  :group 'convenience)

(defcustom tee3-desired-completion-system 'ido
  "This is used to choose a completion system when it must be done at configuration."
  :type 'symbol
  :options '('default 'ido 'ivy))

(defcustom tee3-desired-automatic-completion-system 'none
  "This is used to choose an auto-completion system when it must be done at configuration."
  :type 'symbol
  :options '('none 'ido 'auto-complete 'company))

(defcustom tee3-flycheck-override-modern-flymake t
  "Flymake is used instead of flycheck for Emacs 26 and later unless this variable is true."
  :type 'boolean)

(defcustom tee3-desired-language-server-system 'default
  "Selects the language server system, with 'default being each language has a different one."
  :type 'symbol
  :options '('default 'lsp 'eglot))

;;;
;;; Emacs
;;;
(setq column-number-mode t)
(display-time-mode t)
(setq display-time-day-and-date nil)
(setq inhibit-startup-screen t)
(setq mouse-wheel-mode t)
(setq scroll-conservatively 100)
(setq split-height-threshold 0)
(setq-default truncate-lines t)
(setq visible-bell t)
(setq version-control t)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(when (equal system-type 'darwin)
  (setq ns-pop-up-frames nil)

  (set-keyboard-coding-system nil)

  (when (not (display-graphic-p))
    (setq ns-command-modifier 'none)
    (setq ns-function-modifier 'hyper)
    (setq ns-control-modifier 'control)
    (setq ns-option-modifier 'super))

  (setq ns-right-alternate-modifier 'none)
  (setq ns-right-command-modifier 'none)
  (setq ns-right-control-modifier 'none)
  (setq ns-right-option-modifier 'none))

(when (equal system-type 'windows-nt)
  (setq w32-pass-lwindow-to-system nil)
  (setq w32-lwindow-modifier 'super)
  (setq w32-pass-apps-to-system nil)
  (setq w32-apps-modifier 'hyper))

(use-package auth-sources
  :init
  (cond
  ((equal system-type 'darwin)
   (customize-set-value 'auth-sources '(macos-keychain-generic "~/.authinfo.gpg")))
   (t
    (customize-set-value 'auth-sources '("~/.authinfo.gpg")))))

(use-package epa
  :init
  (setq epa-pinentry-mode 'loopback))

(use-package newcomment
  :init
  (setq comment-empty-lines t))
(use-package cus-edit
  :init
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  (load custom-file 'noerror))
(use-package abbrev
  :diminish abbrev-mode)
(use-package dedicated
  :ensure t
  :pin melpa)
(use-package desktop
  :config
  (desktop-save-mode))
(use-package diminish
  :ensure t
  :pin melpa)
(use-package dired
  :init
  (setq dired-kept-versions 6))
(use-package ediff
  :init
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))
(use-package eldoc
  :config
  (add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'eldoc-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook 'eldoc-mode))
(use-package elec-pair
  :init
  (electric-pair-mode))
(use-package etags
  :init
  (setq tags-loop-revert-buffers t))
(use-package expand-region
  :ensure t
  :pin melpa
  :bind
  ("C-c =" . er/expand-region))
(use-package fm
  :disabled t
  :ensure t
  :pin melpa
  :config
  (add-hook 'occur-mode-hook 'fm-start)
  (add-hook 'compilation-mode-hook 'fm-start))
(use-package font-core
  :config
  (global-font-lock-mode))
(use-package fringe
  :init
  (setq fringe-mode '(4 . nil)))
(use-package hideshow
  :diminish hs-minor-mode
  :init
  (setq hs-hide-comments-when-hiding-all t))
(use-package hide-comnt
  ;; @todo removed from melpa
  :disabled t
  :ensure t
  :pin melpa)
(use-package icomplete
  :init
  (icomplete-mode))
(use-package linum
  :if
  (< emacs-major-version 26)
  :init
  (setq linum-format "%4d ")
  :config
  (add-hook 'text-mode-hook (lambda () (linum-mode 1)))

  (add-hook 'prog-mode-hook (lambda () (linum-mode 1))))
(use-package display-line-numbers
  :if
  (>= emacs-major-version 26)
  :init
  (setq display-line-numbers-grow-only t)
  (setq display-line-numbers-width-start 3)
  :config
  (add-hook 'text-mode-hook (lambda () (display-line-numbers-mode t)))
  (add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode t))))
(use-package gnus
  :init
  (setq gnus-init-file "~/.gnus")
  (setq gnus-home-directory user-emacs-directory)

  (when (equal tee3-desired-completion-system 'ido)
    (setq gnus-completing-read-function 'gnus-ido-completing-read))
  (when (equal tee3-desired-completion-system 'ivy)
    (setq gnus-completing-read-function 'ivy-completing-read))

  (setq gnus-save-newsrc-file nil)
  (setq gnus-read-newsrc-file nil)

  (setq gnus-asynchronous t)

  (setq gnus-use-cache t))
(use-package message
  :init
  (setq message-directory (expand-file-name "Mail" user-emacs-directory))

  ;; (add-hook 'message-mode-hook '(lambda () (flyspell-mode t)))
)
(use-package locate
  :config
  (when (equal system-type 'darwin)
    (setq locate-command "mdfind")))
(use-package minibuf-eldef
  :init
  (minibuffer-electric-default-mode))
(use-package menu-bar
  :config
  (when (not (display-graphic-p))
    (menu-bar-mode -1)))
(use-package paredit
  :ensure t
  :pin melpa
  :diminish paredit-mode
  :init
  (use-package paredit-everywhere
    :ensure t
    :pin melpa)
  :config
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'scheme-mode-hook 'enable-paredit-mode))
(use-package paren
  :config
  (show-paren-mode))
(use-package pcomplete
  :init
  (use-package pcmpl-git
    :ensure t
    :pin melpa)
  (use-package pcmpl-homebrew
    :ensure t
    :pin melpa)
  (use-package pcmpl-pip
    :ensure t
    :pin melpa)
  :config
  (add-hook 'shell-mode-hook 'pcomplete-shell-setup))
(use-package bash-completion
  :disabled t
  :ensure t
  :pin melpa
  :config
  (bash-completion-setup))
(use-package recentf
  :init
  (recentf-mode 1))
(use-package savehist
  :init
  (setq history-length t)
  (setq history-delete-duplicates t)
  :config
  (savehist-mode))
(use-package saveplace
  :config
  (if (>= emacs-major-version 25)
      (save-place-mode)
    (setq-default save-place t)))
(use-package scroll-bar
  :config
  (scroll-bar-mode -1))
(use-package simple
  :init
  (setq size-indication-mode t)
  (setq kill-ring-max 1000)
  (setq kill-do-not-save-duplicates t)
  (setq save-interprogram-paste-before-kill t)
  :config
  (eval-after-load "desktop.el"
    (add-to-list 'desktop-globals-to-save 'kill-ring 1)))
(use-package smooth-scroll
  :ensure t
  :pin melpa)
(use-package speedbar
  :init
  (eval-after-load "sb-image.el"
    (setq speedbar-use-images nil)))
(use-package term
  :init
  (setq term-buffer-maximum-size 0))
(use-package tool-bar
  :config
  (tool-bar-mode -1))
(use-package tooltip
  :init
  (setq tooltip-mode nil))
(use-package undo-tree
  :disabled t
  :ensure t
  :pin melpa
  :init
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-visualizer-diff t))
(use-package winner
  :init
  (winner-mode))
(use-package writeroom-mode
  :ensure t
  :pin melpa)

;;; Evil (vi) emulation
(use-package evil
  :disabled t
  :ensure t
  :pin melpa
  :init
  (setq evil-default-state 'emacs)
  :config
  (evil-mode 1))

;;; Text mode hooks
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'text-mode-hook-identify)
(add-hook 'text-mode-hook (lambda () (setq indent-tabs-mode nil)))

;;; Programming mode hooks
(add-hook 'prog-mode-hook (lambda () (setq indent-tabs-mode nil)))

(use-package hideshow
  :config
  (add-hook 'prog-mode-hook 'hs-minor-mode))

(use-package flyspell
  :config
  (add-hook 'prog-mode-hook 'flyspell-prog-mode))

;;; Flyspell
(use-package flyspell
  :diminish flyspell-mode
  :init
  (use-package flyspell-lazy
    :ensure t
    :pin melpa)
  :config
  (add-hook 'text-mode-hook 'turn-on-flyspell))
(use-package auto-correct
  :ensure t
  :pin gnu
  :diminish auto-correct-mode
  :config
  (auto-correct-mode 1))
(use-package captain
  :ensure t
  :pin gnu
  :diminish captain-mode
  :config
  (global-captain-mode))

;;; M-x
(use-package amx
  :if
  (equal tee3-desired-completion-system 'ido)
  :ensure t
  :pin melpa
  :init
  (setq amx-history-length 1000)

  (amx-mode 1))

;;; Ibuffer
(use-package ibuffer
  :if
  (equal tee3-desired-completion-system 'ido)
  :ensure t
  :pin melpa
  :bind
  ("C-x C-b" . ibuffer)
  :init
  (use-package ibuffer-vc
    :ensure t
    :pin melpa)
  (use-package ibuffer-tramp
    :ensure t
    :pin melpa)
  (use-package ibuffer-git
    :ensure t
    :pin melpa)
  (use-package ibuffer-projectile
    :ensure t
    :pin melpa))

;;; Ido
(use-package ido
  :if
  (equal tee3-desired-completion-system 'ido)
  :preface
  (defun tee3-ido-kill-ring ()
    (interactive)
    (let ((the-text (ido-completing-read "Yank text: " kill-ring)))
      (if (not (equal the-text ""))
          (progn
            (push-mark)
            (insert the-text)
            (exchange-mark-and-point)))))
  :bind
  ("C-c c C-y" . tee3-ido-kill-ring)
  :init
  (use-package ido-completing-read+
    :if
    (>= emacs-major-version 25)
    :ensure t
    :pin melpa
    :init
    ;; @todo should not have to add this explicitly
    (use-package memoize
      :ensure t
      :pin melpa)
    (ido-ubiquitous-mode t))
  (use-package ido-vertical-mode
    :ensure t
    :pin melpa
    :init
    (setq ido-vertical-show-count t)
    (setq ido-vertical-disable-if-short t)
    (setq ido-vertical-pad-list nil)
    :config
    (ido-vertical-mode 1))
  (use-package ido-at-point
    :if
    (equal tee3-desired-automatic-completion-system 'ido)
    :ensure t
    :pin melpa
    :config
    (ido-at-point-mode))

  (ido-mode 1)
  (ido-everywhere)

  (setq ido-ignore-directories '())
  (setq ido-ignore-files '())

  (setq ido-enable-flex-matching t)

  (setq ido-use-filename-at-point 'guess)
  (setq ido-use-url-at-point t)
  (setq ido-confirm-unique-completion t))

;;; Ivy
(use-package ivy
  :if
  (equal tee3-desired-completion-system 'ivy)
  :ensure t
  :pin melpa
  :diminish ivy-mode
  :bind-keymap
  ("C-c c" . ivy-mode-map)
  :init
  (use-package ivy-xref
    :ensure t
    :pin melpa
    :init
    (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

  (ivy-mode 1))

;;; Counsel
(use-package counsel
  :if
  (equal tee3-desired-completion-system 'ivy)
  :ensure t
  :pin melpa
  :diminish counsel-mode
  :bind-keymap
  ("C-c c" . counsel-mode-map)
  :init
  (counsel-mode 1))

(use-package swiper
  :ensure t
  :pin melpa)

;;; Auto-complete
(use-package auto-complete
  :if
  (equal tee3-desired-automatic-completion-system 'auto-complete)
  :ensure t
  :pin melpa
  :init
  (use-package ac-capf
    :ensure t
    :pin melpa
    :config
    (ac-capf-setup))
  :config
  (ac-config-default))

;;; Company
(use-package company
  :if
  (equal tee3-desired-automatic-completion-system 'company)
  :ensure t
  :pin melpa
  :init
  (use-package company-quickhelp
    :ensure t
    :pin melpa)

  (global-company-mode))

;;; Projectile
(use-package projectile
  :ensure t
  :pin melpa
  :diminish projectile-mode
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (cond ((equal tee3-desired-completion-system 'ido) (setq projectile-completion-system 'ido))
        (t (setq projectile-completion-system 'default)))

  (projectile-mode)

  (setq projectile-switch-project-action 'projectile-dired)
  (setq projectile-find-dir-includes-top-level t)
  (setq projectile-use-git-grep t))

;;; Learning Emacs
(use-package guru-mode
  :ensure t
  :pin melpa)
(use-package howdoi
  :ensure t
  :pin melpa)

;;;
;;; Org
;;;
(use-package org
  :ensure t
  :pin melpa)

;;;
;;; Markdown formats
;;;
(use-package adoc-mode
  :ensure t
  :pin melpa
  :mode
  ((".asciidoc\\'" . adoc-mode)
   (".adoc\\'" . adoc-mode)))
(use-package creole-mode
  :ensure t
  :pin melpa)
(use-package jade-mode
  :ensure t
  :pin melpa)
(use-package markdown-mode
  :ensure t
  :pin melpa
  :mode
  (("README\.md\\'" . gfm-mode))
  :init
  (use-package markdown-mode+
    :ensure t
    :pin melpa)
  (setq markdown-asymmetric-header t)
  (cond ((executable-find "cmark-gfm") (setq markdown-command "cmark-gfm --extension table --extension strikethrough --extension autolink --extension tagfilter"))
        ((executable-find "cmark") (setq markdown-command "cmark")))
  (setq markdown-nested-imenu-heading-index t))
(use-package markup-faces
  :ensure t
  :pin melpa)
(use-package pandoc-mode
  :ensure t
  :pin melpa)
(use-package rst)
(use-package sphinx-frontend
  :ensure t
  :pin melpa
  :init
  (use-package rst)
  :config
  ;; @todo remove default bindings since they are non-standard
  (define-key rst-mode-map (kbd "C-c h") nil)
  (define-key rst-mode-map (kbd "C-c l") nil)
  (define-key rst-mode-map (kbd "C-c p") nil)

  ;; @todo define a sphinx map
  (define-prefix-command 'sphinx-map)
  (define-key sphinx-map (kbd "h") 'sphinx-build-html)
  (define-key sphinx-map (kbd "l") 'sphinx-build-latex)
  (define-key sphinx-map (kbd "p") 'sphinx-run-pdflatex)

  ;; @todo add the sphinx map to the rst mode map
  (define-key rst-mode-map (kbd "C-c C-s") 'sphinx-map))

;;; Utilities
(use-package ascii
  ;; @todo removed from melpa
  :disabled t
  :ensure t
  :pin melpa)
(use-package list-unicode-display
  :ensure t
  :pin melpa)
(use-package ietf-docs
  :ensure t
  :pin melpa
  :bind
  ("C-c f i" . ietf-docs-open-at-point)
  :init
  (setq ietf-docs-cache-directory (expand-file-name "~/Documents/Research/Engineering/RFC")))

;;; Android development
(use-package android-mode
  :ensure t
  :pin melpa)

;;;
;;; Configuration files
;;;
(use-package apache-mode
  :ensure t
  :pin melpa)
(use-package csv-mode
  :ensure t
  :pin gnu)
(use-package gitattributes-mode
  :ensure t
  :pin melpa)
(use-package gitconfig-mode
  :ensure t
  :pin melpa
  :mode
  (("\\.gitconfig.*\\'" . gitconfig-mode)

   ;; SubGit-generated Git submodules files
   ("\\.gitsvnextmodules\\'" . gitconfig-mode)
   ;; migration-generated Git submodules files
   ("\\.gitsvnexternals\\'" . gitconfig-mode)))
(use-package gitignore-mode
  :ensure t
  :pin melpa)
(use-package graphviz-dot-mode
  ;; @todo fails to load with Emacs 26
  :if
  (< emacs-major-version 26)
  :ensure t
  :pin melpa)
(use-package irfc
  ;; @todo removed from melpa
  :disabled t
  :ensure t
  :pin melpa)
(use-package jgraph-mode
  :ensure t
  :pin gnu)
(use-package nginx-mode
  :ensure t
  :pin melpa)
(use-package pov-mode
  :disabled t
  :ensure t
  :pin marmalade)
(use-package protobuf-mode
  :ensure t
  :pin melpa)
(use-package ssh-config-mode
  :ensure t
  :pin melpa
  :mode
  ((".ssh/config\\'" . ssh-config-mode)
   ("sshd?_config\\'" . ssh-config-mode)
   ("known_hosts\\'" . ssh-known-hosts-mode)
   ("authorized_keys2?\\'" . ssh-authorized-keys-mode)))
(use-package systemd
  :if
  (or (> emacs-major-version 24)
      (and (= emacs-major-version 24) (>= emacs-minor-version 4)))
  :ensure t
  :pin melpa)
(use-package toml-mode
  :ensure t
  :pin melpa)
(use-package vimrc-mode
  :ensure t
  :pin melpa)
(use-package yaml-mode
  :ensure t
  :pin melpa)

;;;
;;; Programming languages
;;;
(use-package applescript-mode
  :ensure t
  :pin melpa)
(use-package asm-mode
  :mode
  (("\\.[sh][56][45x]\\'" . asm-mode))
  :config
  (add-hook 'asm-mode-hook (lambda () (setq indent-tabs-mode t))))
(use-package coffee-mode
  :ensure t
  :pin melpa)
(use-package cperl-mode
  :ensure t
  :pin melpa)
(use-package csharp-mode
  :if
  (>= emacs-major-version 25)
  :ensure t
  :pin melpa
  :init
  (use-package omnisharp
    :ensure t
    :pin melpa))
(use-package d-mode
  :ensure t
  :pin melpa)
(use-package fish-mode
  :ensure t
  :pin melpa)
(use-package groovy-mode
  :ensure t
  :pin melpa
  :mode
  (("Jenkinsfile\\'" . groovy-mode)))
(use-package haskell-mode
  :ensure t
  :pin melpa)
(use-package llvm-mode
  ;; @todo removed from melpa
  :disabled t
  :ensure t
  :pin melpa)
(use-package lua-mode
  :ensure t
  :pin melpa)
(use-package matlab
  :ensure matlab-mode
  :pin melpa
  :preface
  ;; @todo workaround for deprecated variable
  (when (>= emacs-major-version 26)
    (setq default-fill-column fill-column))
  :init
  (setq matlab-auto-fill nil)
  (setq matlab-fill-code nil)
  (setq matlab-fill-strings-flag nil)
  (setq matlab-fill-count-ellipsis-flag nil)
  (setq matlab-completion-technique 'increment)
  (setq matlab-functions-have-end t)
  (setq matlab-indent-function-body t)
  (setq matlab-return-add-semicolon t)
  (setq matlab-show-mlint-warnings nil))
(use-package octave)
(use-package php-mode
  :disabled t
  :ensure t
  :pin melpa)
(use-package powershell
  :ensure t
  :pin melpa)
(use-package processing-mode
  :ensure t
  :pin melpa
  :init
  (when (equal system-type 'darwin)
    (setq processing-location "/usr/local/bin/processing-java")))
(use-package sql
  :init
  (setq sql-sqlite-program "sqlite3"))
(use-package rust-mode
  :ensure t
  :pin melpa)
(use-package swift-mode
  :if
  (or (>= emacs-major-version 25)
      (and (= emacs-major-version 24) (>= emacs-minor-version 4)))
  :ensure t
  :pin melpa)
(use-package tcl)
(use-package tidy
  ;; @todo removed from melpa
  :disabled t
  :ensure t
  :pin melpa)
(use-package web-mode
  :ensure t
  :pin melpa
  :init
  (defun tee3-web-mode-setup ()
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-code-indent-offset 4)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-indent-style 2)

    (setq web-mode-style-padding 1)
    (setq web-mode-script-padding 1)
    (setq web-mode-block-padding 0))

  (add-hook 'web-mode-hook 'tee3-web-mode-setup))

;;; TeX and LaTeX
(use-package tex-site
  :ensure auctex
  :pin melpa)

;;; OpenCL
(use-package opencl-mode
  :ensure t
  :pin melpa
  :mode (("\\.cl\\'" . opencl-mode)))

;;; OpenGL
(use-package cuda-mode
  :disabled t
  :ensure t
  :pin melpa)
(use-package glsl-mode
  :ensure t
  :pin melpa)

;;; GNU Global
(use-package ggtags
  :ensure t
  :pin melpa
  :bind-keymap
  ("C-c g" . ggtags-mode-prefix-map))

;;; Scheme programming language
(use-package scheme-mode
  :mode
  (("\\.guile\\'" . scheme-mode)))
(use-package geiser
  :ensure t
  :pin melpa
  :init
  (setq geiser-mode-start-repl-p t))

;;; Google
(use-package google-this
  :ensure t
  :pin melpa
  :diminish google-this-mode
  :init
  (google-this-mode))

;;; SSH
(use-package ssh
  :ensure t
  :pin melpa)

;;;
;;; Version Control Systems
;;;
(use-package vc
  :init
  (use-package vc-fossil
    :ensure t
    :pin melpa
    :init
    (use-package vc))

  (setq vc-make-backup-files t)

  ;; do not show branch indicator
  (setq vc-display-status nil))

;;; Git
(use-package gited
  :ensure t
  :pin gnu
  :config
  (define-key dired-mode-map "\C-x\C-g" 'gited-list-branches))
(use-package diff-hl
  :if
  (or (> emacs-major-version 24)
      (and (= emacs-major-version 24) (>= emacs-minor-version 4)))
  :ensure t
  :pin melpa
  :config
  (global-diff-hl-mode)

  (diff-hl-flydiff-mode)
  (unless (window-system) (diff-hl-margin-mode))

  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))
(use-package git-timemachine
  :ensure t
  :pin melpa)

;;; Gitolite
(use-package gitolite-clone
  :ensure t
  :pin melpa
  :init
  (setq gitolite-clone-username "git")
  (setq gitolite-clone-host "localhost"))
(use-package gl-conf-mode
  :ensure t
  :pin melpa
  :mode
  (("gitolite\\.conf\\'" . gl-conf-mode)))

;;; GitHub
(use-package gist
  :ensure t
  :pin melpa)
(use-package github-issues
  :ensure t
  :pin melpa)

;;; Magit
(use-package magit
  :if
  (or (> emacs-major-version 24)
      (and (= emacs-major-version 24) (>= emacs-minor-version 4)))
  :ensure t
  :pin melpa
  :preface
  (defun tee3-magit-choose-completing-read-function ()
    (when (equal tee3-desired-completion-system 'ido) (setq magit-completing-read-function 'magit-ido-completing-read)))
  :init
  (use-package magit-lfs
    :ensure t
    :pin melpa)
  (use-package magit-svn
    :ensure t
    :pin melpa)

  (setq magit-repository-directories (quote (("~/Development" . 2))))

  ;; trash doesn't work properly on macOS
  (when (equal system-type 'darwin)
    (setq magit-delete-by-moving-to-trash nil))

  (setq magit-popup-use-prefix-argument 'default)
  (setq magit-branch-popup-show-variables nil)
  (setq magit-popup-show-common-commands nil)
  :config
  (global-magit-file-mode)

  (add-hook 'magit-status-sections-hook 'magit-insert-modules-overview t)
  (add-hook 'magit-status-sections-hook 'magit-insert-worktrees t)

  (add-hook 'magit-status-headers-hook 'magit-insert-remote-header t)
  (add-hook 'magit-status-headers-hook 'magit-insert-user-header t)
  (add-hook 'magit-status-headers-hook 'magit-insert-repo-header t)

  (add-hook 'magit-mode-hook 'magit-load-config-extensions)

  (add-hook 'magit-mode-hook `tee3-magit-choose-completing-read-function))

;;; Microsoft Team Foundation Server
(use-package tfs
  ;; @todo removed from melpa
  :disabled t
  :ensure t
  :pin melpa)

;;; Mercurial
(use-package monky
  :ensure t
  :pin melpa)
(use-package hgignore-mode
  :ensure t
  :pin melpa)
(use-package conf-mode
  :mode
  ((".hgrc.*\\'" . conf-mode)))

;;; Perforce
(use-package p4
  :ensure t
  :pin melpa)

;;; Subversion
(use-package psvn
  :ensure t
  :pin marmalade)

;;; Make
(use-package make-mode
  :mode
  (("Makefile.*\\'" . makefile-mode))
  :config
  (add-hook 'makefile-mode-hook (lambda () (setq indent-tabs-mode t))))

;;; Boost.Build programming language
(with-eval-after-load "projectile"
  (defun tee3-projectile-boost-build-project-p ()
    "Check if a project contains Jamroot, project-root.jam, or jamroot.jam files."
    (or (projectile-verify-file-wildcard "project-root.jam")
        (projectile-verify-file-wildcard "Jamroot")
        (projectile-verify-file-wildcard "jamroot.jam")))

  (projectile-register-project-type 'boost-build
                                    #'tee3-projectile-boost-build-project-p
                                    :compile "b2"
                                    :test "b2"
                                    :run "b2"
                                    :test-prefix "test_"))


;;; Jam programming language
(use-package jam-mode
  :ensure t
  :pin marmalade
  :mode
  (("[Jj]amroot\\'" . jam-mode)
   ("[Jj]amfile\\'" . jam-mode)
   ("\\.jam\\'" . jam-mode))
  :init
  :config
  (add-hook 'jam-mode-hook (lambda () (setq indent-tabs-mode nil)))

  (if (>= emacs-major-version 26)
      (eval-after-load "display-line-numbers.el"
        (add-hook 'jam-mode-hook (lambda ()
                                  (display-line-numbers-mode t))))
    (eval-after-load "linum.el"
      (add-hook 'jam-mode-hook (lambda ()
                                 (linum-mode 1)))))

  (eval-after-load "flyspell.el"
    (add-hook 'jam-mode-hook 'flyspell-prog-mode)))

;;; CMake
(use-package cmake-mode
  :ensure t
  :pin melpa
  :init
  (use-package cmake-font-lock
    :ensure t
    :pin melpa)
  (use-package cmake-project
    :ensure t
    :pin melpa)
  :config
  (add-hook 'cmake-mode-hook 'cmake-font-lock-activate))

;;;
;;; Gnuplot
;;;
(use-package gnuplot
  :ensure t
  :pin melpa)
(use-package gnuplot-mode
  :ensure t
  :pin melpa
  :mode
  (("\\.gp\\'" . gnuplot-mode)))

;;; Go programming language
(use-package go-mode
  :ensure t
  :pin melpa
  :init
  (use-package go-eldoc
    :if
    (equal tee3-desired-language-server-system 'default)
    :ensure t
    :pin melpa
    :config
    (add-hook 'go-mode-hook 'go-eldoc-setup))
  (use-package go-guru
    :if
    (equal tee3-desired-language-server-system 'default)
    :ensure t
    :pin melpa)
  (use-package go-projectile
    :ensure t
    :pin melpa)
  :config
  ;; allow use of tabs as it is required by go fmt
  (add-hook 'go-mode-hook (lambda () (setq indent-tabs-mode t)))
  (add-hook 'go-mode-hook (lambda () (add-hook 'before-save-hook 'gofmt-before-save))))

;;; Ruby programming language
(use-package ruby-mode
  :init
  (use-package ruby-compilation
    :ensure t
    :pin melpa)
  (use-package ruby-electric
    :ensure t
    :pin melpa
    :config
    (add-hook 'ruby-mode-hook 'ruby-electric-mode))
  (use-package robe
    :if
    (equal tee3-desired-language-server-system 'default)
    :ensure t
    :pin melpa
    :config
    (add-hook 'ruby-mode-hook 'robe-mode))
  (use-package inf-ruby
    :ensure t
    :pin melpa)
  (use-package rspec-mode
    :ensure t
    :pin melpa)
  (use-package rbenv
    :ensure t
    :pin melpa)
  (use-package bundler
    :ensure t
    :pin melpa))

;;; Objective-J programming language
(use-package objj-mode
  :if
  (>= emacs-major-version 25)
  :load-path
  "~/opt/local/src/objj-mode")

;;; Jake
(use-package js
  :mode
  (("[Jj]akefile.*\\'" . js-mode)
   ("\\.jake\\'" . js-mode)))

;;; XML
(use-package nxml
  :mode
  (("\\.xml\\'" . nxml-mode)
   ("\\.xsl\\'" . nxml-mode)
   ("\\.xsd\\'" . nxml-mode)
   ("\\.rng\\'" . nxml-mode)
   ("\\.xhtml\\'" . nxml-mode)))

;;; DITA
(use-package nxml
  :mode
  (("\\.dita\\'" . nxml-mode)
   ("\\.ditamap\\'" . nxml-mode)))

;;; DocBook
(use-package docbook
  :ensure t
  :pin gnu)
(use-package nxml
  :mode
  (("\\.docbook\\'" . nxml-mode)))

;;; C-family programming languages
(use-package cc-mode
  :preface
  (defun tee3-c-mode-common-hook ()
    ;; Add the personal styles defined above.
    (c-add-style "tee3" tee3-c-style t)
    (c-add-style "msvc" msvc-c-style t)

    ;;
    ;; Other customizations.
    ;;
    ;; TBD: Not sure if all of these will be okay or not.
    ;;
    (c-toggle-auto-state 1)
    (c-toggle-hungry-state 1)
    ;; (c-toggle-auto-hungry-state 1)

    ;; (auto-fill-mode t)
    ;; (abbrev-mode t)
    ;; (column-number-mode t)

    ;; (setq tab-width 8)

    ;; (setq c-tab-always-indent t)
    ;; (setq c-insert-tab-function nil)
    )
  :mode
  ("\\.cu\\'" . c++-mode)
  ("\\.cuh\\'" . c++-mode)
  :init
  (use-package cwarn
    :diminish cwarn-mode
    :init
    (global-cwarn-mode t))
  (use-package tee3-c-style
    :load-path
    "~/opt/local/src/tee3-c-style")
  (use-package msvc-c-style
    :load-path
    "~/opt/local/src/msvc-c-style")
  (use-package google-c-style
    :ensure t
    :pin melpa)
  (use-package c-eldoc
    :disabled t
    :ensure t
    :pin melpa
    :init
    ;; add more as desired, superset of what you'd like to use
    (setq c-eldoc-includes "-I.")
    :config
    (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
    (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode))
  (use-package hideif
    :init
    (setq hide-ifdef-read-only t)
    (setq hide-ifdef-initially nil)
    (setq hide-ifdef-lines t)
    :config
    (add-hook 'c-mode-hook 'hide-ifdef-mode)
    (add-hook 'c++-mode-hook 'hide-ifdef-mode))
  (setq c-indent-comments-syntactically-p t)
  (setq c-strict-syntax-p t)
  :config
  (add-hook 'c-mode-hook (lambda () (c-set-style "tee3")))
  (add-hook 'c++-mode-hook (lambda () (c-set-style "tee3")))
  (add-hook 'c-mode-common-hook 'tee3-c-mode-common-hook))
(use-package demangle-mode
  :ensure t
  :pin melpa)
(use-package disaster
  :ensure t
  :pin melpa)
(use-package dummy-h-mode
  ;; @todo removed from melpa
  :disabled t
  :ensure t
  :pin melpa)
(use-package objc-font-lock
  :ensure t
  :pin melpa
  :config
  (objc-font-lock-global-mode))
(use-package malinka
  :disabled t
  :ensure t
  :pin melpa)

;;; Java programming language
(use-package meghanada
  :if
  (equal tee3-desired-language-server-system 'default)
  :ensure t
  :pin melpa
  :config
  ;; (add-hook 'java-mode-hook (lambda () (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
  (add-hook 'java-mode-hook (lambda () (meghanada-mode t))))

;;; JavaScript programming language
(use-package js)
(use-package js-comint
  :ensure t
  :pin melpa)
(use-package tern
  :if
  (equal tee3-desired-language-server-system 'default)
  :ensure t
  :pin melpa
  :init
  ;; @todo this causes an error when run independently
  ;; (eval-after-load "js.el"
  ;;   (add-to-list 'auto-mode-alist '("\\.tern-project\\'" . json-mode)))
  :config
  (add-hook 'js-mode-hook (lambda () (tern-mode t))))
(use-package eslint-fix
  :ensure t
  :pin melpa)
(use-package json-navigator
  :ensure t
  :pin melpa)
(use-package jsonnet-mode
  :ensure t
  :pin melpa)
(use-package jq-mode
  :ensure t
  :pin melpa)

;;; node.js
(use-package nodejs-repl
  :ensure t
  :pin melpa)

;;; Typescript programming language
(use-package typescript-mode
  :ensure t
  :pin melpa)
(use-package ts-comint
  :ensure t
  :pin melpa)

;;; Generic modes
(use-package generic-x)

;;; Python programming language
(use-package python
  :init
  (setq gud-pdb-command-name "python -m pdb"))

(use-package py-autopep8
  :ensure t
  :pin melpa)
(use-package pip-requirements
  :ensure t
  :pin melpa)
(use-package nose
  :ensure t
  :pin melpa)
(use-package virtualenv
  :ensure t
  :pin melpa)

;;; Code Composer Studio and DSP/BIOS mode
(use-package cc-mode
  :mode
  (("\\.h[cd]f\\'" . c-mode)
   ("\\.l[cd]f\\'" . c-mode)))
(use-package js
  :mode
  (("\\.gel\\'" . js-mode)
   ("\\.tcf\\'" . js-mode)
   ("\\.tci\\'" . js-mode)
   ("\\.tcp\\'" . js-mode)
   ("\\.xs\\'" . js-mode)))

;;; Homebrew
(use-package homebrew-mode
  :if
  (or (>= emacs-major-version 25)
      (and (= emacs-major-version 24) (>= emacs-minor-version 4)))
  :ensure t
  :pin melpa
  :init
  (global-homebrew-mode))

;;;
;;; Clang Format
;;;
(use-package clang-format
  :ensure t
  :pin melpa
  :init
  (eval-after-load "yaml-mode.el"
    (add-to-list 'auto-mode-alist '(".clang-format\\'" . yaml-mode)))

  (when (equal system-type 'darwin)
    (setq clang-format-executable "/usr/local/opt/llvm/bin/clang-format")))

;;;
;;; Clang Tidy
;;;
(eval-after-load "yaml-mode.el"
  (add-to-list 'auto-mode-alist '(".clang-tidy\\'" . yaml-mode)))

;;;
;;; Flymake
;;;
(use-package flymake
  :if
  (and (>= emacs-major-version 26)
       (not tee3-flycheck-override-modern-flymake))
  :bind
  ("C-c ! l" . flymake-show-diagnostics-buffer))

;;;
;;; Flycheck
;;;
(use-package flycheck
  :if
  (or (< emacs-major-version 26)
      tee3-flycheck-override-modern-flymake)
  :ensure t
  :pin melpa
  :init
  (use-package flycheck-package
    :ensure t
    :pin melpa
    :config
    (flycheck-package-setup))
  (use-package flycheck-clangcheck
    :ensure t
    :pin melpa
    :init
    (when (equal system-type 'darwin)
      (setq flycheck-c/c++-clangcheck-executable "/usr/local/opt/llvm/bin/clang-check")))
  (use-package flycheck-clang-tidy
    :disabled t
    :ensure t
    :pin melpa
    :init
    (when (equal system-type 'darwin)
      (setq flycheck-c/c++-clang-tidy-executable "/usr/local/opt/llvm/bin/clang-tidy"))
    :config
    (add-hook 'flycheck-mode-hook #'flycheck-clang-tidy-setup))
  (setq flycheck-javascript-standard-executable "semistandard")
  (use-package flycheck-objc-clang
    :ensure t
    :pin melpa
    :config
    (flycheck-objc-clang-setup))
  (use-package flycheck-pyflakes
    :ensure t
    :pin melpa)
  (use-package flycheck-rtags
    :if
    (equal tee3-desired-language-server-system 'default)
    :load-path
    "~/opt/local/share/emacs/site-lisp/rtags")
  (use-package flycheck-rust
    :ensure t
    :pin melpa)
  (use-package flycheck-swift
    :ensure t
    :pin melpa
    :config
    (flycheck-swift-setup))
  :config
  (global-flycheck-mode))

;;;
;;; rtags
;;;
(use-package rtags
  :if
  (equal tee3-desired-language-server-system 'default)
  :load-path
  "~/opt/local/share/emacs/site-lisp/rtags"
  :init
  ;; ensure the right executables are used
  (setq rtags-path "~/opt/local/bin")

  ;; required for auto-completion
  (setq rtags-autostart-diagnostics t)
  (setq rtags-completions-enabled t)

  (setq rtags-close-taglist-on-selection t)

  (setq rtags-display-summary-as-tooltip nil)
  (setq rtags-display-current-error-as-tooltip nil)
  (setq rtags-popup-results-buffer nil)
  (setq rtags-tooltips-enabled nil)

  (setq rtags-tracking t)
  (setq rtags-tracking-timer-interval 0.1)
  (setq rtags-track-container t)
  (setq rtags-use-filename-completion nil)
  :config
  (rtags-enable-standard-keybindings))

;;;
;;; Language Server Protocol
;;;
(use-package lsp-mode
  :if
  (and (or (> emacs-major-version 25)
           (and (= emacs-major-version 25) (>= emacs-minor-version 1)))
       (equal tee3-desired-language-server-system 'lsp))
  :ensure t
  :pin melpa
  :init
  (use-package lsp-ui
    :ensure t
    :pin melpa
    :init
    (setq lsp-ui-doc-enable nil)
    (setq lsp-ui-flycheck-enable t)
    (setq lsp-ui-imenu-enable nil)
    (setq lsp-ui-peek-enable nil)
    (setq lsp-ui-sideline-enable nil)

    (add-hook 'lsp-mode-hook 'lsp-ui-mode))
  (use-package lsp-clangd
    :ensure t
    :pin melpa
    :init
    (when (equal system-type 'darwin)
      (setq lsp-clangd-executable "/usr/local/opt/llvm/bin/clangd"))

    (add-hook 'c-mode--hook #'lsp-clangd-c-enable)
    (add-hook 'c++-mode-hook #'lsp-clangd-c++-enable)
    (add-hook 'objc-mode-hook #'lsp-clangd-objc-enable))
  (use-package lsp-go
    :ensure t
    :pin melpa
    :init
    (add-hook 'go-mode-hook #'lsp-go-enable))
  (use-package lsp-java
    :ensure t
    :pin melpa
    :init
    (add-hook 'java-mode-hook #'lsp-java-enable))
  (use-package lsp-javascript-typescript
    :ensure t
    :pin melpa
    :init
    (add-hook 'js-mode-hook #'lsp-javascript-typescript-enable)
    (add-hook 'typescript-mode-hook #'lsp-javascript-typescript-enable)
    (add-hook 'js3-mode-hook #'lsp-javascript-typescript-enable)
    (add-hook 'rjsx-mode #'lsp-javascript-typescript-enable))
  (use-package lsp-python
    :ensure t
    :pin melpa
    :init
    (add-hook 'python-mode-hook #'lsp-python-enable))
  (setq lsp-print-io nil))
(use-package eglot
  :if
  (and (or (> emacs-major-version 26)
           (and (= emacs-major-version 26) (>= emacs-minor-version 1)))
       (equal tee3-desired-language-server-system 'eglot))
  :ensure t
  :pin gnu
  :config
  (add-hook 'prog-mode-hook 'eglot-ensure)

  (add-to-list 'eglot-server-programs '(go-mode . ("go-langserver")))

  (if (equal system-type 'darwin)
      (progn
        (add-to-list 'eglot-server-programs '((c-mode
                                               c++-mode
                                               objc-mode
                                               objc++-mode) . ("/usr/local/opt/llvm/bin/clangd"))))
    (progn
      (add-to-list 'eglot-server-programs '((c-mode
                                             c++-mode
                                             objc-mode
                                             objc++-mode) . ("clangd"))))))

;;;
;;; Rainbow modes
;;;
(use-package rainbow-delimiters
  :disabled t
  :ensure t
  :pin melpa
  :init
  (global-rainbow-delimiters-mode))
(use-package rainbow-identifiers
  :disabled t
  :ensure t
  :pin melpa
  :init
  (rainbow-identifiers-mode))

;;;
;;; Docker
;;;
(use-package docker
  :if
  (>= emacs-major-version 25)
  :ensure t
  :pin melpa)
(use-package dockerfile-mode
  :if
  (>= emacs-major-version 25)
  :ensure t
  :pin melpa)
(use-package docker-compose-mode
  :if
  (>= emacs-major-version 25)
  :ensure t
  :pin melpa)

;;;
;;; Kubernetes
;;;
(use-package kubernetes
  :if
  (>= emacs-major-version 25)
  :ensure t
  :pin melpa)

;;;
;;; Chef
;;;
(use-package chef-mode
  :ensure t
  :pin melpa)

;;;
;;; Terraform
;;;
(use-package terraform-mode
  :ensure t
  :pin melpa)

;;;
;;; Structure and Interpretation of Computer Programs (SICP)
;;;
(use-package sicp
  :ensure t
  :pin melpa)

;;;
;;; Themes
;;;
(when (or (>= emacs-major-version 25)
          (and (= emacs-major-version 24)
               (>= emacs-minor-version 5)))
  (use-package atom-dark-theme :ensure t :pin melpa :defer t)
  (use-package basic-theme :ensure t :pin melpa :defer t)
  (use-package birds-of-paradise-plus-theme :ensure t :pin melpa :defer t)
  (use-package borland-blue-theme :ensure t :pin melpa :defer t)
  (use-package busybee-theme :ensure t :pin melpa :defer t)
  (use-package chyla-theme :ensure t :pin melpa :defer t)
  (use-package cyberpunk-theme :ensure t :pin melpa :defer t)
  (use-package distinguished-theme :ensure t :pin melpa :defer t)
  (use-package django-theme :ensure t :pin melpa :defer t)
  (use-package eclipse-theme :ensure t :pin melpa :defer t)
  (use-package eink-theme :ensure t :pin melpa :defer t)
  (use-package espresso-theme :ensure t :pin melpa :defer t)
  (use-package farmhouse-theme :ensure t :pin melpa :defer t)
  (use-package flatland-theme :ensure t :pin melpa :defer t)
  (use-package flatui-theme :ensure t :pin melpa :defer t)
  (use-package gandalf-theme :ensure t :pin melpa :defer t)
  (use-package github-modern-theme :ensure t :pin melpa :defer t)
  (use-package gotham-theme :ensure t :pin melpa :defer t)
  (use-package grandshell-theme :ensure t :pin melpa :defer t)
  (use-package grayscale-theme :ensure t :pin melpa :defer t)
  (use-package green-phosphor-theme :ensure t :pin melpa :defer t)
  (use-package greymatters-theme :ensure t :pin melpa :defer t)
  (use-package gruber-darker-theme :ensure t :pin melpa :defer t)
  (use-package hemera-theme :ensure t :pin melpa :defer t)
  (use-package iodine-theme :ensure t :pin melpa :defer t)
  (use-package lavender-theme :ensure t :pin melpa :defer t)
  (use-package leuven-theme :ensure t :pin melpa :defer t)
  (use-package lush-theme :ensure t :pin melpa :defer t)
  (use-package material-theme :ensure t :pin melpa :defer t)
  (use-package minimal-theme :ensure t :pin melpa :defer t)
  (use-package moe-theme :ensure t :pin melpa :defer t)
  (use-package molokai-theme :ensure t :pin melpa :defer t)
  (use-package monochrome-theme :ensure t :pin melpa :defer t)
  (use-package monokai-theme :ensure t :pin melpa :defer t)
  (use-package monotropic-theme :ensure t :pin melpa :defer t)
  (use-package mustang-theme :ensure t :pin melpa :defer t)
  (use-package nord-theme :ensure t :pin melpa :defer t)
  (use-package nordless-theme :ensure t :pin melpa :defer t)
  (use-package paper-theme :ensure t :pin melpa :defer t)
  (use-package poet-theme :ensure t :pin melpa :defer t)
  (use-package professional-theme :ensure t :pin melpa :defer t)
  (use-package rebecca-theme :ensure t :pin melpa :defer t)
  (use-package rimero-theme :ensure t :pin melpa :defer t)
  (use-package solarized-theme :ensure t :pin melpa :defer t)
  (use-package spacemacs-theme :ensure t :pin melpa :defer t)
  (use-package subatomic-theme :ensure t :pin melpa :defer t)
  (use-package subatomic256-theme :ensure t :pin melpa :defer t)
  (use-package tangotango-theme :ensure t :pin melpa :defer t)
  (use-package tao-theme :ensure t :pin melpa :defer t)
  (use-package termbright-theme :ensure t :pin melpa :defer t)
  (use-package ubuntu-theme :ensure t :pin melpa :defer t)
  (use-package zen-and-art-theme :ensure t :pin melpa :defer t)
  (use-package zenburn-theme :ensure t :pin melpa :defer t)
  (use-package zerodark-theme :ensure t :pin melpa :defer t)

  (cond (t nil) ;; do not choose any themes by default
        ((display-graphic-p)
         (when (member 'solarized-dark (custom-available-themes))
           (load-theme 'solarized-dark t t)

           (enable-theme 'solarized-dark)))
        ((display-color-p)
         (when (member 'cyberpunk (custom-available-themes))
           (load-theme 'cyberpunk t t)

           (enable-theme 'cyberpunk)))))

;;;
;;; Start the emacs server (emacsserver/emacsclient)
;;;
(use-package server
  :preface
  (defun tee3-signal-restart-server ()
    (interactive)
    (message "Caught event %S" last-input-event)
    (server-mode))
  :config
  (define-key special-event-map [sigusr1] 'tee3-signal-restart-server)

  (unless (server-running-p)
    (server-start)))

;;;
;;; Load user- and machine-specific settings
;;;
(if (file-exists-p (expand-file-name "~/.emacs.machine.el"))
    (load-file (expand-file-name "~/.emacs.machine.el")))
(if (file-exists-p (expand-file-name "~/.emacs.user.el"))
    (load-file (expand-file-name "~/.emacs.user.el")))

(provide '.emacs)
;;; .emacs ends here
