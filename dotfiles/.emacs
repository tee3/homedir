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

(use-package newcomment
  :init
  (setq comment-empty-lines t))
(use-package cus-edit
  :init
  (setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
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
  :ensure t
  :pin melpa)
(use-package icomplete
  :init
  (icomplete-mode))
(use-package linum
  :init
  (setq linum-format "%4d "))
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
  :pin melpa)
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
  :pin melpa)

;;; Text mode hooks
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'text-mode-hook-identify)
(add-hook 'text-mode-hook (lambda ()
                            (setq indent-tabs-mode nil)))
(use-package linum
  :config
  (add-hook 'text-mode-hook (lambda ()
                              (linum-mode 1))))

;;; Programming mode hooks
(add-hook 'prog-mode-hook (lambda ()
                            (setq indent-tabs-mode nil)))

(use-package hideshow
  :config
  (add-hook 'prog-mode-hook 'hs-minor-mode))

(use-package linum
  :config
  (add-hook 'prog-mode-hook (lambda ()
                              (linum-mode 1))))
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
  :ensure t
  :pin melpa
  :init
  (setq amx-history-length 1000)

  (amx-mode 1))

;;; Helm
(use-package helm
  :ensure t
  :pin melpa
  :diminish helm-mode
  :init
  (use-package helm-config
    :ensure helm
    :pin melpa)
  (use-package helm-flyspell
    :ensure t
    :pin melpa
    :bind
    ("C-x c M-$" . helm-flyspell-correct))
  (use-package helm-projectile
    :ensure t
    :pin melpa
    :bind
    ("C-x c C-c p e" . helm-projectile-recentf)
    ("C-x c C-c p f" . helm-projectile-find-file)
    ("C-x c C-c p g" . helm-projectile-find-file-dwim)
    ("C-x c C-c p p" . helm-projectile-switch-project)
    ("C-x c C-c p s g" . helm-projectile-grep)
    :config
    (helm-projectile-toggle -1))
  (setq helm-candidate-number-limit nil)
  (setq helm-quick-update t)
  (setq helm-ff-skip-boring-files t)

  (helm-mode -1))

;;; Ibuffer
(use-package ibuffer
  :ensure t
  :pin melpa
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
  ("C-c C-y" . tee3-ido-kill-ring)
  :init
  (use-package ido-completing-read+
    :if (>= emacs-major-version 25)
    :ensure t
    :pin melpa
    :init
    ; @todo should not have to add this explicitly
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
  :disabled t
  :ensure ivy
  :pin melpa
  :diminish ivy-mode
  :bind
  ("C-c i C-x C-b" . ivy-switch-buffer)
  ("C-c i C-x 4 b" . ivy-switch-buffer-other-window)
  :init
  (ivy-mode -1))

;;; Counsel
(use-package counsel
  :disabled t
  :ensure t
  :pin melpa
  :diminish counsel-mode
  :bind
  ("C-c c M-x" . counsel-M-x)
  ("C-c c C-x C-f" . counsel-find-file)
  ("C-c c M-." . counsel-find-symbol)

  ("C-c c M-s o" . counsel-grep)

  ("C-c c C-x r b" . counsel-bookmark)
  ("C-c c C-x r l" . counsel-bookmark)

  ("C-c c C-h b" . counsel-describe-bindings)
  ("C-c c C-h f" . counsel-describe-function)
  ("C-c c C-h v" . counsel-describe-variable)
  ("C-c c C-h S" . counsel-info-lookup-symbol)

  ("C-c c C-c p s f" . counsel-git)
  ("C-c c C-c p s g" . counsel-git-grep)

  ("C-c c C-x v L" . counsel-git-log)
  :init
  (counsel-mode -1))

;;; Projectile
(use-package projectile
  :ensure t
  :pin melpa
  :diminish projectile-mode
  :init
  (projectile-global-mode)

  (setq projectile-switch-project-action 'projectile-dired)
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
  (setq markdown-command "cmark")
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
  :pin melpa)

;;; Utilities
(use-package ascii
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
  :if (< emacs-major-version 26)
  :ensure t
  :pin melpa)
(use-package irfc
  :ensure t
  :pin melpa)
(use-package jgraph-mode
  :ensure t
  :pin gnu)
(use-package nginx-mode
  :ensure t
  :pin melpa)
(use-package osx-plist
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
  :if (or (> emacs-major-version 24)
          (and (= emacs-major-version 24)
               (>= emacs-minor-version 4)))
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
  (add-hook 'asm-mode-hook (lambda ()
                                  (setq indent-tabs-mode t))))
(use-package coffee-mode
  :ensure t
  :pin melpa)
(use-package cperl-mode
  :ensure t
  :pin melpa)
(use-package csharp-mode
  :if (>= emacs-major-version 25)
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
  :ensure t
  :pin melpa)
(use-package lua-mode
  :ensure t
  :pin melpa)
(use-package matlab
  :ensure matlab-mode
  :pin melpa)
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
  :pin melpa)
(use-package sql
  :init
  (setq sql-sqlite-program "sqlite3"))
(use-package swift-mode
  :if (or (>= emacs-major-version 25)
           (and (= emacs-major-version 24)
                (>= emacs-minor-version 4)))
  :ensure t
  :pin melpa)
(use-package tcl)
(use-package tidy
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
  :init
  (setq ggtags-mode-prefix-key (kbd "C-c g")))

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
(use-package diff-hl
  :if (or (> emacs-major-version 24)
          (and (= emacs-major-version 24)
               (>= emacs-minor-version 4)))
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
  :if (or (> emacs-major-version 24)
          (and (= emacs-major-version 24)
               (>= emacs-minor-version 4)))
  :ensure t
  :pin melpa
  :preface
  (defun tee3-magit-choose-completing-read-function ()
    (if ido-everywhere (setq magit-completing-read-function 'magit-ido-completing-read)))
  :init
  (use-package magit-lfs
    :ensure t
    :pin melpa)
  (use-package magit-svn
    :ensure t
    :pin melpa)

  (setq magit-repository-directories (quote (("~/Development" . 2))))

  ; trash doesn't work properly on macOS
  (when (equal system-type 'darwin)
    (setq magit-delete-by-moving-to-trash nil))

  (setq magit-popup-use-prefix-argument 'default)
  (setq magit-branch-popup-show-variables nil)
  (setq magit-popup-show-common-commands nil)
  :config
  (global-magit-file-mode)

  (add-hook 'magit-status-sections-hook 'magit-insert-submodules t)
  (add-hook 'magit-status-sections-hook 'magit-insert-worktrees t)

  (add-hook 'magit-status-headers-hook 'magit-insert-remote-header t)
  (add-hook 'magit-status-headers-hook 'magit-insert-user-header t)
  (add-hook 'magit-status-headers-hook 'magit-insert-repo-header t)

  (add-hook 'magit-mode-hook 'magit-load-config-extensions)

  (add-hook 'magit-mode-hook `tee3-magit-choose-completing-read-function))

;;; Microsoft Team Foundation Server
(use-package tfs
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
  :pin melpa)

;;; Make
(use-package make-mode
  :mode
  (("Makefile.*\\'" . makefile-mode))
  :config
  (add-hook 'makefile-mode-hook (lambda ()
                                  (setq indent-tabs-mode t))))

;;; Boost.Build programming language
;;; @todo fill in

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
  (add-hook 'jam-mode-hook (lambda ()
                             (setq indent-tabs-mode nil)))

  (eval-after-load "linum.el"
    (add-hook 'jam-mode-hook (lambda ()
                               (linum-mode 1))))

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
    :ensure t
    :pin melpa
    :config
    (add-hook 'go-mode-hook 'go-eldoc-setup))
  (use-package go-guru
    :ensure t
    :pin melpa)
  (use-package go-projectile
    :ensure t
    :pin melpa)
  :config
  (add-hook 'go-mode-hook (lambda ()
                            ;; allow use of tabs as it is required by go fmt
			    (setq indent-tabs-mode t)

                            ;; format before save
                            (add-hook 'before-save-hook 'gofmt-before-save))))

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
  :if (>= emacs-major-version 25)
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
  (add-hook 'c-mode-hook
            (lambda ()
              (c-set-style "tee3")))
  (add-hook 'c++-mode-hook
            (lambda ()
              (c-set-style "tee3")))
  (add-hook 'c-mode-common-hook
            (lambda ()
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
              )))
(use-package demangle-mode
  :ensure t
  :pin melpa)
(use-package disaster
  :ensure t
  :pin melpa)
(use-package dummy-h-mode
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
  :ensure t
  :pin melpa
  :config
  ;; (add-hook 'java-mode-hook (lambda ()
  ;;                             (meghanada-mode t)
  ;;                             (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
  (add-hook 'java-mode-hook (lambda ()
                              (meghanada-mode t))))

;;; JavaScript programming language
(use-package js)
(use-package js-comint
  :ensure t
  :pin melpa)
(use-package tern
  :ensure t
  :pin melpa
  :init
  (eval-after-load "js.el"
    (add-to-list 'auto-mode-alist '("\\.tern-project\\'" . json-mode)))
  :config
  (add-hook 'js-mode-hook (lambda ()
                            (tern-mode t))))
(use-package eslint-fix
  :ensure t
  :pin melpa)

;;; node.js
(use-package nodejs-repl
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
  :if (or (>= emacs-major-version 25)
          (and (= emacs-major-version 24)
               (>= emacs-minor-version 4)))
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
(defcustom tee3-flycheck-override-modern-flymake t
  "Flymake is used instead of flycheck for Emacs 26 and later unless this variable is true.")

(use-package flymake
  :if (and (>= emacs-major-version 26) (not tee3-flycheck-override-modern-flymake))
  :bind
  ("C-c ! l" . flymake-show-diagnostics-buffer))

;;;
;;; Flycheck
;;;
(use-package flycheck
  :if (or (< emacs-major-version 26)
          tee3-flycheck-override-modern-flymake)
  :ensure t
  :pin melpa
  :init
  (use-package helm-flycheck
    :if (require 'helm nil t)
    :ensure t
    :pin melpa
    :bind
    ("C-x c C-c ! h" . helm-flycheck))
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
    :load-path
    "~/opt/local/src/emacs/site-lisp/rtags")
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
  :load-path
  "~/opt/local/share/emacs/site-lisp/rtags"
  :init
  ;; ensure the right executables are used
  (setq rtags-path "~/opt/local/bin")

  ; required for auto-completion
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
  :if (or (> emacs-major-version 25)
          (and (= emacs-major-version 25)
               (>= emacs-minor-version 1)))
  :ensure t
  :pin melpa
  :init
  (use-package lsp-clangd
    :load-path
    "~/opt/local/src/lsp-clangd"
    :init
    (when (equal system-type 'darwin)
      (setq lsp-clangd-executable "/usr/local/opt/llvm/bin/clangd")))
  (use-package lsp-go
    :ensure t
    :pin melpa)
  (use-package lsp-java
    :ensure t
    :pin melpa)
  (use-package lsp-javascript
    :ensure t
    :pin melpa)
  (use-package lsp-python
    :ensure t
    :pin melpa)
  (setq lsp-print-io t))

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
  :if (>= emacs-major-version 25)
  :ensure t
  :pin melpa)
(use-package dockerfile-mode
  :if (>= emacs-major-version 25)
  :ensure t
  :pin melpa)
(use-package docker-compose-mode
  :if (>= emacs-major-version 25)
  :ensure t
  :pin melpa)

;;;
;;; Kubernetes
;;;
(use-package kubernetes
  :if (>= emacs-major-version 25)
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
  (use-package borland-blue-theme :ensure t :pin melpa :defer t)
  (use-package busybee-theme :ensure t :pin melpa :defer t)
  (use-package cyberpunk-theme :ensure t :pin melpa :defer t)
  (use-package distinguished-theme :ensure t :pin melpa :defer t)
  (use-package django-theme :ensure t :pin melpa :defer t)
  (use-package eclipse-theme :ensure t :pin melpa :defer t)
  (use-package eink-theme :ensure t :pin melpa :defer t)
  (use-package farmhouse-theme :ensure t :pin melpa :defer t)
  (use-package flatland-theme :ensure t :pin melpa :defer t)
  (use-package gandalf-theme :ensure t :pin melpa :defer t)
  (use-package github-modern-theme :ensure t :pin melpa :defer t)
  (use-package gotham-theme :ensure t :pin melpa :defer t)
  (use-package grandshell-theme :ensure t :pin melpa :defer t)
  (use-package grayscale-theme :ensure t :pin melpa :defer t)
  (use-package green-phosphor-theme :ensure t :pin melpa :defer t)
  (use-package greymatters-theme :ensure t :pin melpa :defer t)
  (use-package gruber-darker-theme :ensure t :pin melpa :defer t)
  (use-package iodine-theme :ensure t :pin melpa :defer t)
  (use-package lavender-theme :ensure t :pin melpa :defer t)
  (use-package leuven-theme :ensure t :pin melpa :defer t)
  (use-package lush-theme :ensure t :pin melpa :defer t)
  (use-package material-theme :ensure t :pin melpa :defer t)
  (use-package minimal-theme :ensure t :pin melpa :defer t)
  (use-package molokai-theme :ensure t :pin melpa :defer t)
  (use-package monochrome-theme :ensure t :pin melpa :defer t)
  (use-package monokai-theme :ensure t :pin melpa :defer t)
  (use-package mustang-theme :ensure t :pin melpa :defer t)
  (use-package paper-theme :ensure t :pin melpa :defer t)
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
  :config
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
