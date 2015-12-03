;;; .emacs --- Emacs user configuration file
;;;
;;; Commentary:
;;;
;;;    This file customizes Emacs for a specific user's needs.
;;;
;;; Code:

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
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
  (when (>= emacs-major-version 23)
    (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/")))
  (when (>= emacs-major-version 23)
    (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")))
  (when (>= emacs-major-version 23)
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/")))

  (package-initialize)

  ;; Update the package list from the network
  (package-refresh-contents))

;;;
;;; Bootstrap use-package
;;;
(when (require 'package nil :noerror)
  (when (not (package-installed-p 'use-package))
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
(setq display-time-mode t)
(setq history-delete-duplicates t)
(setq inhibit-startup-screen t)
(setq mouse-wheel-mode t)
(setq ns-pop-up-frames nil)
(setq scroll-conservatively 100)
(setq split-height-threshold 0)
(setq-default truncate-lines t)
(setq visible-bell t)

(use-package cus-edit
  :init
  (setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
  (load custom-file 'noerror))
(use-package abbrev
  :diminish abbrev-mode)
(use-package dedicated
  :ensure t)
(use-package desktop
  :config
  (desktop-save-mode))
(use-package diminish
  :ensure t)
(use-package dired
  :init
  (setq dired-kept-versions 6))
(use-package ediff
  :init
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))
(use-package eldoc
  :diminish eldoc-mode
  :config
  (add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'eldoc-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook 'eldoc-mode))
(use-package electric-case
  :ensure t)
(use-package etags
  :init
  (setq tags-loop-revert-buffers t))
(use-package expand-region
  :ensure t
  :bind
  ("C-c =" . er/expand-region))
(use-package fm
  :disabled t
  :ensure t
  :config
  (add-hook 'occur-mode-hook 'fm-start)
  (add-hook 'compilation-mode-hook 'fm-start))
(use-package frame
  :config
  (when (display-graphic-p)
    (when (member "Source Code Pro" (font-family-list))
      (set-frame-font "Source Code Pro")))
  (when (display-graphic-p)
    (when (member "Source Code Pro" (font-family-list))
      (add-to-list 'default-frame-alist '(font . "Source Code Pro")))
    (add-to-list 'default-frame-alist '(width . 160))
    (add-to-list 'default-frame-alist '(height . 50))))
(use-package files
  :init
  (setq version-control t))
(use-package font-core
  :config
  (global-font-lock-mode))
(use-package fringe
  :init
  (setq fringe-mode '(4 . nil)))
(use-package hideshow
  :diminish hs-minor-mode)
(use-package hide-comnt
  :ensure t)
(use-package icomplete
  :disabled t
  :init
  (icomplete-mode))
(use-package linum
  :init
  (setq linum-format "%4d "))
(use-package locate
  :config
  (when (equal system-type 'darwin)
    (setq locate-command "mdfind")))
(use-package menu-bar
  :config
  (when (not (display-graphic-p))
    (menu-bar-mode -1)))
(use-package nav
  :ensure t
  :config
  (nav-disable-overeager-window-splitting))
(use-package paredit
  :ensure t
  :diminish paredit-mode
  :init
  (use-package paredit-everywhere
    :ensure t)
  :config
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'scheme-mode-hook 'enable-paredit-mode))
(use-package paren
  :config
  (show-paren-mode))
(use-package pcomplete
  :config
  (add-hook 'shell-mode-hook 'pcomplete-shell-setup))
(use-package savehist
  :config
  (savehist-mode))
(use-package saveplace
  :init
  (setq-default save-place t))
(use-package scroll-bar
  :config
  (scroll-bar-mode -1))
(use-package simple
  :init
  (use-package desktop)
  (setq size-indication-mode t)
  :config
  (add-to-list 'desktop-globals-to-save 'kill-ring 1))
(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/theme nil)

  (sml/setup))
(use-package smooth-scroll
  :ensure t)
(use-package speedbar
  :init
  (use-package sb-image
    :init
    (setq speedbar-use-images nil)))
(use-package tool-bar
  :config
  (tool-bar-mode -1))
(use-package undo-tree
  :disabled t
  :ensure t
  :diminish undo-tree-mode)
(use-package winner
  :init
  (winner-mode))
(use-package writeroom-mode
  :ensure t)

;;; Evil (vi) emulation
(use-package evil
  :disabled t
  :ensure t)

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
(use-package linum
  :config
  (add-hook 'prog-mode-hook (lambda ()
                              (linum-mode 1))))
(use-package flyspell
  :config
  (add-hook 'prog-mode-hook 'flyspell-prog-mode))

;;; Company
(use-package company
  :ensure t
  :diminish company-mode
  :config
  (global-company-mode))

;;; Flyspell
(use-package flyspell
  :diminish flyspell-mode
  :init
  (use-package flyspell-lazy
    :ensure t)
  :config
  (add-hook 'text-mode-hook 'turn-on-flyspell))

;;; Helm
(use-package helm
  :ensure t
  :diminish helm-mode
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  :init
  (use-package helm-company
    :ensure t)
  (use-package helm-config
    :ensure helm)
  (use-package helm-flycheck
    :ensure t
    :bind
    ("C-c ! h" . helm-flycheck))
  (use-package helm-flyspell
    :ensure t)
  (use-package helm-projectile
    :ensure t
    :config
    (helm-projectile-on))
  (setq helm-candidate-number-limit nil)
  (setq helm-quick-update t)
  (setq helm-ff-skip-boring-files t)

  (helm-mode))

;;; Ibuffer
(use-package ibuffer
  :ensure t
  :init
  (use-package ibuffer-vc
    :ensure t)
  (use-package ibuffer-tramp
    :ensure t)
  (use-package ibuffer-git
    :ensure t)
  (use-package ibuffer-projectile
    :ensure t))

;;; Ido
(use-package ido
  :disabled t
  :init
  (use-package ido-ubiquitous
    :ensure t
    :init
    (ido-ubiquitous-mode t))
  (ido-mode 1)
  (ido-everywhere)

  (setq ido-use-filename-at-point 'guess)
  (setq ido-use-url-at-point t)
  (setq ido-confirm-unique-completion t))

;;; Occur
(use-package ioccur
  :ensure t
  :init
  (use-package desktop)
  (add-to-list 'desktop-globals-to-save 'ioccur-history))
(use-package noccur
  :ensure t)

;;; Projectile
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :init
  (projectile-global-mode)

  (setq projectile-switch-project-action 'projectile-dired)
  (setq projectile-use-git-grep t)

  ;; @todo workaround for an issue with tramp
  (setq projectile-mode-line " Projectile"))

;;;
;;; Snippets
;;;
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode))

;;; Learning Emacs
(use-package guru-mode
  :ensure t)
(use-package vimgolf
  :ensure t)
(use-package howdoi
  :ensure t)

;;;
;;; Org
;;;
(use-package org
  :ensure t)

;;;
;;; Gnus
;;;
(use-package gnus
  :init
  (setq gnus-select-method '(nntp "news.gmane.org")))

;;;
;;; Markdown formats
;;;
(use-package adoc-mode
  :ensure t
  :mode
  ((".asciidoc\\'" . adoc-mode)
   (".adoc\\'" . adoc-mode)))
(use-package creole-mode
  :ensure t)
(use-package jade-mode
  :ensure t)
(use-package markdown-mode
  :ensure t
  :mode
  (("README\.md\\'" . gfm-mode))
  :init
  (use-package markdown-mode+
    :ensure t))
(use-package markup-faces
  :ensure t)
(use-package pandoc-mode
  :ensure t)
(use-package rst)
(use-package sphinx-frontend
  :ensure t)

;;; Utilities
(use-package ascii
  :ensure t)

;;; Android development
(use-package android-mode
  :ensure t)

;;;
;;; Configuration files
;;;
(use-package apache-mode
  :ensure t)
(use-package crontab-mode
  :ensure t)
(use-package csv-mode
  :ensure t)
(use-package dockerfile-mode
  :ensure t)
(use-package gitattributes-mode
  :ensure t)
(use-package gitconfig-mode
  :ensure t
  :mode
  (("\\.gitconfig.*\\'" . gitconfig-mode)

   ;; SubGit-generated Git submodules files
   ("\\.gitsvnextmodules\\'" . gitconfig-mode)
   ;; migration-generated Git submodules files
   ("\\.gitsvnexternals\\'" . gitconfig-mode)))
(use-package gitignore-mode
  :ensure t)
(use-package graphviz-dot-mode
  :ensure t)
(use-package irfc
  :ensure t)
(use-package jgraph-mode
  :ensure t)
(use-package json-mode
  :ensure t
  :mode
  ("jslintrc\\'" . json-mode))
(use-package nginx-mode
  :ensure t)
(use-package osx-plist
  :ensure t)
(use-package pov-mode
  :ensure t)
(use-package protobuf-mode
  :ensure t)
(use-package ssh-config-mode
  :ensure t
  :mode
  ((".ssh/config\\'" . ssh-config-mode)
   ("sshd?_config\\'" . ssh-config-mode)
   ("known_hosts\\'" . ssh-known-hosts-mode)
   ("authorized_keys2?\\'" . ssh-authorized-keys-mode)))
(use-package syslog-mode
  :ensure t
  :mode
  (("/var/log.*\\'" . syslog-mode)))
(use-package systemd
  :ensure t)
(use-package toml-mode
  :ensure t)
(use-package vimrc-mode
  :ensure t)
(use-package yaml-mode
  :ensure t)

;;;
;;; Programming languages
;;;
(use-package applescript-mode
  :ensure t)
(use-package asm-mode
  :mode
  (("\\.[sh][56][45x]\\'" . asm-mode)))
(use-package coffee-mode
  :ensure t)
(use-package cperl-mode
  :ensure t)
(use-package csharp-mode
  :disabled t
  :ensure t
  :init
  (use-package omnisharp
    :disabled t
    :ensure t))
(use-package d-mode
  :ensure t)
(use-package fish-mode
  :ensure t)
(use-package haskell-mode
  :ensure t
  :init
  (use-package company
    :ensure t
    :init
    (use-package company-ghc
      :ensure t
      :config
      (add-to-list 'company-backends 'company-ghc t))))
(use-package llvm-mode
  :ensure t)
(use-package lua-mode
  :ensure t)
(use-package matlab
  :ensure matlab-mode)
(use-package octave)
(use-package php-mode
  :disabled t
  :ensure t)
(use-package powershell
  :ensure t)
(use-package processing-mode
  :ensure t
  :init
  (use-package processing-snippets
    :ensure t)
  (use-package flycheck-processing
    :ensure t
    :init
    (flycheck-processing-setup)))
(use-package sql
  :init
  (setq sql-sqlite-program "sqlite3"))
(use-package swift-mode
  :ensure t
  :init
  (use-package flycheck
    :ensure t)
  :config
  (add-to-list 'flycheck-checkers 'swift))
(use-package tcl)
(use-package tidy
  :ensure t)
(use-package web-mode
  :ensure t
  :init
  (defun tbrown-web-mode-setup ()
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-code-indent-offset 4)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-indent-style 2)

    (setq web-mode-style-padding 1)
    (setq web-mode-script-padding 1)
    (setq web-mode-block-padding 0))

  (add-hook 'web-mode-hook 'tbrown-web-mode-setup))

;;; TeX and LaTeX
(use-package tex-site
  :ensure auctex
  :init
  (use-package company
    :ensure t
    :init
    (use-package company-auctex
      :ensure t)))

;;; OpenGL
(use-package cuda-mode
  :disabled t
  :ensure t)
(use-package glsl-mode
  :ensure t)

;;; GNU Global
(use-package ggtags
  :ensure t)

;;; Scheme programming language
(use-package geiser
  :ensure t)

;;; Google
(use-package google-this
  :ensure t
  :diminish google-this-mode
  :init
  (google-this-mode))

;;; SSH
(use-package ssh
  :ensure t)

;;;
;;; Version Control Systems
;;;
(use-package vc
  :init
  (setq vc-make-backup-files t))

;;; Fossil
(use-package vc-fossil
  :ensure t
  :init
  (use-package vc))

;;; Git
(use-package git-gutter
  :ensure t)
(use-package git-gutter-fringe
  :disabled t
  :ensure t)

;;; GitHub
(use-package gist
  :ensure t)
(use-package github-issues
  :ensure t)

;;; Magit
(use-package magit
  :ensure t
  :init
  (setq magit-popup-use-prefix-argument 'default)
  :config
  (add-hook 'magit-status-headers-hook 'magit-insert-remote-header t)
  (add-hook 'magit-status-headers-hook 'magit-insert-user-header t)
  (add-hook 'magit-status-headers-hook 'magit-insert-repo-header t)

  (add-hook 'magit-mode-hook 'magit-load-config-extensions))

;;; Microsoft Team Foundation Server
(use-package tfs
  :ensure t)

;;; Mercurial
(use-package monky
  :ensure t)
(use-package hgignore-mode
  :ensure t)
(use-package conf-mode
  :mode
  ((".hgrc.*\\'" . conf-mode)))

;;; Perforce
(use-package p4
  :ensure t)

;;; Subversion
(use-package psvn
  :ensure t)

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
  :mode
  (("[Jj]amroot\\'" . jam-mode)
   ("[Jj]amfile\\'" . jam-mode)
   ("\\.jam\\'" . jam-mode))
  :init
  (use-package linum)
  (use-package flyspell)
  :config
  (add-hook 'jam-mode-hook (lambda ()
                             (setq indent-tabs-mode nil)))
  (add-hook 'jam-mode-hook (lambda ()
                             (linum-mode 1)))
  (add-hook 'jam-mode-hook 'flyspell-prog-mode))

;;; CMake
(use-package cmake-mode
  :ensure t
  :init
  (use-package cmake-font-lock
    :ensure t)
  (use-package cmake-project
    :ensure t)
  :config
  (add-hook 'cmake-mode-hook 'cmake-font-lock-activate))

;;;
;;; Gnuplot
;;;
(use-package gnuplot
  :ensure t)
(use-package gnuplot-mode
  :ensure t
  :mode
  (("\\.gp\\'" . gnuplot-mode)))

;;; Go programming language
(use-package go-mode
  :ensure t
  :init
  (use-package company
    :ensure t
    :init
    (use-package company-go
      :ensure t
      :config
      (add-to-list 'company-backends 'company-go t)))
  (use-package go-direx
    :ensure t)
  (use-package go-eldoc
    :ensure t
    :config
    (add-hook 'go-mode-hook 'go-eldoc-setup))
  (use-package go-errcheck
    :ensure t)
  (use-package go-play
    :ensure t)
  (use-package go-projectile
    :ensure t)
  (use-package go-stacktracer
    :ensure t)
  (use-package golint
    :ensure t)
  (use-package gore-mode
    :ensure t)
  (use-package gotest
    :ensure t)
  (use-package govet
    :ensure t)
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
    :ensure t)
  (use-package ruby-electric
    :ensure t
    :config
    (add-hook 'ruby-mode-hook 'ruby-electric-mode)))
(use-package robe
  :ensure t
  :diminish robe-mode
  :config
  (add-hook 'ruby-mode-hook 'robe-mode)
  (add-to-list 'company-backends 'company-robe t))
(use-package inf-ruby
  :ensure t
  :init
  (use-package company
    :ensure t
    :init
    (use-package company-inf-ruby
      :ensure t
      :config
      (add-to-list 'company-backends 'company-inf-ruby t))
    (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)))
(use-package rspec-mode
  :ensure t)
(use-package rbenv
  :ensure t)
(use-package bundler
  :ensure t)

;;; Objective-J programming language
(use-package objc-mode
  :preface
  (defconst cappuccino-objj-style
    '((c-basic-offset . 4)
      (tab-width . 8)
      (indent-tabs-mode . nil)
      (c-offsets-alist
       (substatement-open . 0))))
  :mode
  (("\\.j\\'" . objj-mode))
  :init
  (define-derived-mode objj-mode objc-mode
    "Objective-J"
    "Major mode for editing Objective-J files.")
  (use-package flycheck
    :ensure t
    :config
    (flycheck-define-checker objj-capp-lint
      "A flycheck checker for Objective-J based on capp_lint."
      :command
      ("capp_lint" source)
      :error-patterns
      ((warning line-start line ": " (message) "." line-end))
      :modes
      (objj-mode))
    (add-to-list 'flycheck-checkers 'objj-capp-lint)
    (add-hook 'objj-mode-hook (lambda ()
                                (flycheck-select-checker 'objj-capp-lint))))
  (use-package compile
    :config
    (add-to-list 'compilation-error-regexp-alist-alist
                 '(objj-acorn "^\\(WARNING\\|ERROR\\) line \\([0-9]+\\) in file:\\([^:]+\\):\\(.*\\)$" 3 2))
    (add-to-list 'compilation-error-regexp-alist 'objj-acorn)))
; @todo this should be up in use-package, but are not being called
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-add-style "cappuccino" cappuccino-objj-style t)))
(add-hook 'objj-mode-hook
          (lambda ()
            (c-set-style "cappuccino")))

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
  :ensure t)
(use-package nxml
  :mode
  (("\\.docbook\\'" . nxml-mode)))

;;; C-family programming languages
(use-package cc-mode
  :preface
  (defconst tbrown-c-style
    '((c-basic-offset . 3)
      (tab-width . 8)
      (indent-tabs-mode . nil)

      ;; (c-comment-only-line-offset . 4)
      ;; (c-block-comment-prefix . X)
      ;; (c-comment-prefix . X)

      ;; (c-cleanup-list . (scope-operator
      ;;                    empty-defun-braces
      ;;                    defun-close-semi))
      (c-hanging-braces-alist . ((brace-list-open)
                                 (substatement-open before after)
                                 (block-close . c-snug-do-while)))
      ;; (c-hanging-colons-alist . ((member-init-intro before)
      ;;                            (inher-intro)
      ;;                            (case-label after)
      ;;                            (label after)
      ;;                            (access-label after)))
      ;; (c-hanging-semi&comma-alist . ())
      (c-backslash-column . 76)
      (c-backslash-max-column . 152)
      ;; (c-special-indent-hook . nil)
      ;; (c-label-minimum-indentation . nil)
      (c-offsets-alist . ((arglist-close . c-lineup-arglist)
                          (substatement-open . 0)
                          (inline-open . 0)
                          (case-label . +)))
      )
    "tbrown C Programming Style")

  (defconst msvc-c-style
    '((c-basic-offset . 4)
      (tab-width . 4)
      (indent-tabs-mode . t)

      ;; (c-comment-only-line-offset . 4)
      ;; (c-block-comment-prefix . X)
      ;; (c-comment-prefix . X)

      ;; (c-cleanup-list . (scope-operator
      ;;                    empty-defun-braces
      ;;                    defun-close-semi))
      ;; (c-hanging-braces-alist . ((brace-list-open)
      ;;                            (substatement-open before after)
      ;;                            (block-close . c-snug-do-while)))
      ;; (c-hanging-colons-alist . ((member-init-intro before)
      ;;                            (inher-intro)
      ;;                            (case-label after)
      ;;                            (label after)
      ;;                            (access-label after)))
      ;; (c-hanging-semi&comma-alist . ())
      (c-backslash-column . 76)
      (c-backslash-max-column . 152)
      ;; (c-special-indent-hook . nil)
      ;; (c-label-minimum-indentation . nil)
      (c-offsets-alist . ((arglist-close . c-lineup-arglist)
                          (substatement-open . 0)
                          (inline-open . 0)
                          (case-label . +)))
      )
    "MSVC C Programming Style")
  :init
  (use-package cwarn
    :diminish cwarn-mode
    :init
    (global-cwarn-mode t))
  (use-package google-c-style
    :ensure t)
  (use-package c-eldoc
    :ensure t
    :init
    ;; add more as desired, superset of what you'd like to use
    (setq c-eldoc-includes "-I.")
    :config
    (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
    (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode))
  (use-package hideif
    :diminish hide-ifdef-mode
    :init
    (hide-ifdef-mode))
  (setq c-indent-comments-syntactically-p t)
  (setq c-strict-syntax-p t)
  :config
  (add-hook 'c-mode-hook
            (lambda ()
              (c-set-style "tbrown")))
  (add-hook 'c++-mode-hook
            (lambda ()
              (c-set-style "tbrown")))
  (add-hook 'c-mode-common-hook
            (lambda ()
              ;; Add the personal styles defined above.
              (c-add-style "tbrown" tbrown-c-style t)
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

              (hs-minor-mode t)
              ))
(use-package company
  :ensure t
  :init
  (use-package company-c-headers
    :ensure t
    :config
    (add-to-list 'company-backends 'company-c-headers t)))
(use-package flycheck
  :ensure t
  :init
  (use-package flycheck-clangcheck
    :ensure t)
  (use-package flycheck-google-cpplint
    :ensure t))
(use-package demangle-mode
  :ensure t)
(use-package disaster
  :ensure t)
(use-package dummy-h-mode
  :ensure t)
(use-package irony
  :disabled t
  :ensure t
  :init
  (use-package company
    :ensure t
    :init
    (use-package company-irony
      :ensure t))
  (use-package eldoc
    :init
    (use-package irony-eldoc
      :ensure t))
  (use-package flycheck
    :ensure t
    :init
    (use-package flycheck-irony
      :ensure t)))
(use-package objc-font-lock
  :ensure t
  :config
  (objc-font-lock-global-mode))
(use-package malinka
  :disabled t
  :ensure t))

;;; JavaScript programming language
(use-package flycheck
  :ensure t
  :config
  (flycheck-def-option-var flycheck-jslint-language-edition nil javascript-jslint
    "The language edition to use in Jslint.

The value of this variable is either a string denoting a language
edition, or nil, to use the default edition.  When non-nil,
pass the language edition via the `--edition' option."
    :type '(choice (const :tag "Default edition" nil)
                   (string :tag "Language edition"))
    :safe #'stringp)
  (make-variable-buffer-local 'flycheck-jslint-language-edition)

  (flycheck-def-option-var flycheck-jslint-global-variables nil javascript-jslint
    "Additional global variables for Jslint.

The value of this variable is a list of strings, where each
string is an additional global variable to pass to Jslint, via the `--predef'
option."
    :type '(repeat (string :tag "Global variables"))
    :safe #'flycheck-string-list-p)

  (flycheck-def-option-var flycheck-jslint-options nil javascript-jslint
    "Additional options for Jslint.

The value of this variable is a list of strings, where each
string is an additional options, including the leading --, to
pass to Jslint."
    :type '(repeat (string :tag "Options"))
    :safe #'flycheck-string-list-p)

  (flycheck-define-checker javascript-jslint
    "A Javascript syntax and style checker using jslint.

See URL `http://www.jslint.com'."
    :command
    ("jslint"
     "--terse"
     (option "--edition" flycheck-jslint-language-edition concat)
     (option-list "--predef=" flycheck-jslint-global-variables concat)
     (eval flycheck-jslint-options)
     source)
    :error-patterns
    ((error (file-name) ":" line ":" column ": " (message)))
    :modes
    (js-mode js2-mode js3-mode))
  (add-to-list 'flycheck-checkers 'javascript-jslint))

(use-package js)
(use-package js-comint
  :ensure t)
(use-package flycheck
  :ensure t
  :init
  (setq flycheck-javascript-standard-executable "semistandard"))
(use-package tern
  :ensure t
  :init
  (use-package js
    :mode
    (("\\.tern-project\\'" . json-mode)))
  (use-package company
    :ensure t
    :init
    (use-package company-tern
      :ensure t
      :config
      (add-to-list 'company-backends 'company-tern t)))
  :config
  (add-hook 'js-mode-hook (lambda ()
                            (tern-mode t))))

;;; node.js
(use-package nodejs-repl
  :ensure t)

;;; Generic modes
(use-package generic-x)

;;; Python programming language
(use-package python
  :init
  (setq gud-pdb-command-name "python -m pdb"))
(use-package elpy
  :ensure t
  :init
  (elpy-enable)

  ;; disable flymake if flycheck is available
  (when (require 'flycheck nil :noerror)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))))
(use-package py-autopep8
  :ensure t)
(use-package flycheck
  :ensure t
  :init
  (use-package flycheck-pyflakes
    :ensure t))
(use-package pip-requirements
  :ensure t)
(use-package nose
  :ensure t)
(use-package virtualenv
  :ensure t)

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

;;;
;;; Flycheck
;;;
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :init
  (use-package flycheck-package
    :ensure t)
  :config
  (global-flycheck-mode))

;;;
;;; YouCompleteMe
;;;
(use-package ycmd
  :disabled t
  :ensure t
  :init
  (use-package company
    :ensure t
    :init
    (use-package company-ycmd
      :ensure t
      :config
      (add-to-list 'company-backends 'company-ycmd t)))
  (use-package flycheck
    :ensure t
    :init
    (use-package flycheck-ycmd
      :ensure t)))

;;;
;;; rtags
;;;
(use-package rtags
  :ensure t
  :init
  (use-package company
    :ensure t
    :init
    (use-package company-rtags
      :ensure rtags
      :config
      (add-to-list 'company-backends 'company-rtags t)))
  (use-package popup
    :ensure t)
  :config
  (rtags-enable-standard-keybindings c-mode-base-map "\C-xt"))

;;;
;;; Rainbow modes
;;;
(use-package rainbow-delimiters
  :disabled t
  :ensure t
  :init
  (global-rainbow-delimiters-mode))
(use-package rainbow-identifiers
  :disabled t
  :ensure t
  :init
  (rainbow-identifiers-mode))

;;;
;;; Themes
;;;
(when (>= emacs-major-version 24)
  (use-package afternoon-theme :ensure t :defer t)
  (use-package ahungry-theme :ensure t :defer t)
  (use-package alect-themes :ensure t :defer t)
  (use-package ample-theme :ensure t :defer t)
  (use-package ample-zen-theme :ensure t :defer t)
  (use-package anti-zenburn-theme :ensure t :defer t)
  (use-package autumn-light-theme :ensure t :defer t)
  (use-package atom-dark-theme :ensure t :defer t)
  (use-package badger-theme :ensure t :defer t)
  (use-package base16-theme :ensure t :defer t)
  (use-package basic-theme :ensure t :defer t)
  (use-package birds-of-paradise-plus-theme :ensure t :defer t)
  (use-package bubbleberry-theme :ensure t :defer t)
  (use-package busybee-theme :ensure t :defer t)
  (use-package calmer-forest-theme :ensure t :defer t)
  (use-package cherry-blossom-theme :ensure t :defer t)
  (use-package clues-theme :ensure t :defer t)
  (use-package cyberpunk-theme :ensure t :defer t)
  (use-package dakrone-theme :ensure t :defer t)
  (use-package darcula-theme :ensure t :defer t)
  (use-package darkburn-theme :ensure t :defer t)
  (use-package darkmine-theme :ensure t :defer t)
  (use-package darktooth-theme :ensure t :defer t)
  (use-package distinguished-theme :ensure t :defer t)
  (use-package django-theme :ensure t :defer t)
  (use-package eclipse-theme :ensure t :defer t)
  (use-package espresso-theme :ensure t :defer t)
  (use-package faff-theme :ensure t :defer t)
  (use-package farmhouse-theme :ensure t :defer t)
  (use-package firebelly-theme :ensure t :defer t)
  (use-package flatland-theme :ensure t :defer t)
  (use-package flatui-theme :ensure t :defer t)
  (use-package gandalf-theme :ensure t :defer t)
  (use-package gotham-theme :ensure t :defer t)
  (use-package grandshell-theme :ensure t :defer t)
  (use-package greymatters-theme :ensure t :defer t)
  (use-package green-phosphor-theme :ensure t :defer t)
  (use-package gruber-darker-theme :ensure t :defer t)
  (use-package gruvbox-theme :ensure t :defer t)
  (use-package hc-zenburn-theme :ensure t :defer t)
  (use-package hemisu-theme :ensure t :defer t)
  (use-package heroku-theme :ensure t :defer t)
  (use-package hipster-theme :ensure t :defer t)
  (use-package inkpot-theme :ensure t :defer t)
  (use-package ir-black-theme :ensure t :defer t)
  (use-package jazz-theme :ensure t :defer t)
  (use-package leuven-theme :ensure t :defer t)
  (use-package light-soap-theme :ensure t :defer t)
  (use-package lush-theme :ensure t :defer t)
  (use-package material-theme :ensure t :defer t)
  (use-package mbo70s-theme :ensure t :defer t)
  (use-package minimal-theme :ensure t :defer t)
  (use-package moe-theme :ensure t :defer t)
  (use-package molokai-theme :ensure t :defer t)
  (use-package monochrome-theme :ensure t :defer t)
  (use-package monokai-theme :ensure t :defer t)
  (use-package mustang-theme :ensure t :defer t)
  (use-package naquadah-theme :ensure t :defer t)
  (use-package niflheim-theme :ensure t :defer t)
  (use-package noctilux-theme :ensure t :defer t)
  (use-package obsidian-theme :ensure t :defer t)
  (use-package occidental-theme :ensure t :defer t)
  (use-package oldlace-theme :ensure t :defer t)
  (use-package organic-green-theme :ensure t :defer t)
  (use-package pastelmac-theme :ensure t :defer t)
  (use-package pastels-on-dark-theme :ensure t :defer t)
  (use-package phoenix-dark-mono-theme :ensure t :defer t)
  (use-package phoenix-dark-pink-theme :ensure t :defer t)
  (use-package plan9-theme :ensure t :defer t)
  (use-package planet-theme :ensure t :defer t)
  (use-package professional-theme :ensure t :defer t)
  (use-package purple-haze-theme :ensure t :defer t)
  (use-package quasi-monochrome-theme :ensure t :defer t)
  (use-package railscasts-theme :ensure t :defer t)
  (use-package seti-theme :ensure t :defer t)
  (use-package smyx-theme :ensure t :defer t)
  (use-package soft-charcoal-theme :ensure t :defer t)
  (use-package soft-morning-theme :ensure t :defer t)
  (use-package soft-stone-theme :ensure t :defer t)
  (use-package solarized-theme :ensure t :defer t)
  (use-package soothe-theme :ensure t :defer t)
  (use-package spacegray-theme :ensure t :defer t)
  (use-package spacemacs-theme :ensure t :defer t)
  (use-package stekene-theme :ensure t :defer t)
  (use-package sublime-themes :ensure t :defer t)
  (use-package subatomic-theme :ensure t :defer t)
  (use-package subatomic256-theme :ensure t :defer t)
  (use-package sunny-day-theme :ensure t :defer t)
  (use-package tango-plus-theme :ensure t :defer t)
  (use-package tao-theme :ensure t :defer t)
  (use-package tangotango-theme :ensure t :defer t)
  (use-package termbright-theme :ensure t :defer t)
  (use-package tommyh-theme :ensure t :defer t)
  (use-package toxi-theme :ensure t :defer t)
  (use-package tronesque-theme :ensure t :defer t)
  (use-package twilight-theme :ensure t :defer t)
  (use-package twilight-anti-bright-theme :ensure t :defer t)
  (use-package twilight-bright-theme :ensure t :defer t)
  (use-package ubuntu-theme :ensure t :defer t)
  (use-package ujelly-theme :ensure t :defer t)
  (use-package underwater-theme :ensure t :defer t)
  (use-package waher-theme :ensure t :defer t)
  (use-package warm-night-theme :ensure t :defer t)
  (use-package zen-and-art-theme :ensure t :defer t)
  (use-package zenburn-theme :ensure t :defer t)
  (use-package zerodark-theme :ensure t :defer t)
  (use-package zonokai-theme :ensure t :defer t)

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

(provide '.emacs)
;;; .emacs ends here
