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
(display-time-mode t)
(setq display-time-day-and-date nil)
(setq history-delete-duplicates t)
(setq inhibit-startup-screen t)
(setq mouse-wheel-mode t)
(setq ns-pop-up-frames nil)
(setq scroll-conservatively 100)
(setq split-height-threshold 0)
(setq-default truncate-lines t)
(setq visible-bell t)
(setq version-control t)

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
(use-package electric-case
  :ensure t
  :pin melpa)
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
  :diminish hs-minor-mode)
(use-package hide-comnt
  :ensure t
  :pin melpa)
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
  :pin melpa
  :config
  (nav-disable-overeager-window-splitting))
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
  :config
  (add-hook 'shell-mode-hook 'pcomplete-shell-setup))
(use-package bash-completion
  :disabled t
  :ensure t
  :pin melpa
  :config
  (bash-completion-setup))
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
(use-package smooth-scroll
  :ensure t
  :pin melpa)
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
  :pin melpa
  :config
  (global-company-mode))

;;; Flyspell
(use-package flyspell
  :diminish flyspell-mode
  :init
  (use-package flyspell-lazy
    :ensure t
    :pin melpa)
  :config
  (add-hook 'text-mode-hook 'turn-on-flyspell))

;;; Helm
(use-package helm
  :ensure t
  :pin melpa
  :diminish helm-mode
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  :init
  (use-package helm-company
    :ensure t
    :pin melpa)
  (use-package helm-config
    :ensure helm
    :pin melpa)
  (use-package helm-flycheck
    :ensure t
    :pin melpa
    :bind
    ("C-c ! h" . helm-flycheck))
  (use-package helm-flyspell
    :ensure t
    :pin melpa)
  (use-package helm-projectile
    :ensure t
    :pin melpa
    :config
    (helm-projectile-on))
  (setq helm-candidate-number-limit nil)
  (setq helm-quick-update t)
  (setq helm-ff-skip-boring-files t)

  (helm-mode))

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
  :disabled t
  :init
  (use-package ido-ubiquitous
    :ensure t
    :pin melpa
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
  :pin melpa
  :init
  (use-package desktop)
  (add-to-list 'desktop-globals-to-save 'ioccur-history))
(use-package noccur
  :ensure t
  :pin melpa)

;;; Projectile
(use-package projectile
  :ensure t
  :pin melpa
  :diminish projectile-mode
  :init
  (projectile-global-mode)

  (setq projectile-switch-project-action 'projectile-dired)
  (setq projectile-use-git-grep t))

;;;
;;; Snippets
;;;
(use-package yasnippet
  :ensure t
  :pin melpa)

;;; Learning Emacs
(use-package guru-mode
  :ensure t
  :pin melpa)
(use-package vimgolf
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
    :pin melpa))
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
(use-package crontab-mode
  :ensure t
  :pin melpa)
(use-package csv-mode
  :ensure t
  :pin gnu)
(use-package dockerfile-mode
  :ensure t
  :pin melpa)
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
  :ensure t
  :pin melpa)
(use-package irfc
  :ensure t
  :pin melpa)
(use-package jgraph-mode
  :ensure t
  :pin gnu)
(use-package json-mode
  :ensure t
  :pin melpa
  :mode
  ("jslintrc\\'" . json-mode))
(use-package nginx-mode
  :ensure t
  :pin melpa)
(use-package osx-plist
  :ensure t
  :pin melpa)
(use-package pov-mode
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
(use-package syslog-mode
  :ensure t
  :pin melpa
  :mode
  (("/var/log.*\\'" . syslog-mode)))
(use-package systemd
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
  :disabled t
  :ensure t
  :pin melpa
  :init
  (use-package omnisharp
    :disabled t
    :ensure t
    :pin melpa))
(use-package d-mode
  :ensure t
  :pin melpa)
(use-package fish-mode
  :ensure t
  :pin melpa)
(use-package haskell-mode
  :ensure t
  :pin melpa
  :init
  (use-package company
    :ensure t
    :pin melpa
    :init
    (use-package company-ghc
      :ensure t
      :pin melpa
      :config
      (add-to-list 'company-backends 'company-ghc t))))
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
  :pin melpa
  :init
  (use-package processing-snippets
    :disabled t
    :ensure t
    :pin melpa))
(use-package sql
  :init
  (setq sql-sqlite-program "sqlite3"))
(use-package swift-mode
  :ensure t
  :pin melpa
  :init
  (use-package flycheck
    :ensure t
    :pin melpa)
  :config
  (add-to-list 'flycheck-checkers 'swift))
(use-package tcl)
(use-package tidy
  :ensure t
  :pin melpa)
(use-package web-mode
  :ensure t
  :pin melpa
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
  :pin melpa
  :init
  (use-package company
    :ensure t
    :pin melpa
    :init
    (use-package company-auctex
      :ensure t)))

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
  :pin melpa)

;;; Scheme programming language
(use-package scheme-mode
  :mode
  (("\\.guile\\'" . scheme-mode)))
(use-package geiser
  :ensure t
  :pin melpa)

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
  (setq vc-make-backup-files t)

  ;; do not show branch indicator
  (setq vc-display-status nil))

;;; Fossil
(use-package vc-fossil
  :ensure t
  :pin melpa
  :init
  (use-package vc))

;;; Git
(use-package diff-hl
  :ensure t
  :pin melpa
  :config
  (global-diff-hl-mode)

  (diff-hl-flydiff-mode)
  (unless (window-system) (diff-hl-margin-mode))

  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

;;; GitHub
(use-package gist
  :ensure t
  :pin melpa)
(use-package github-issues
  :ensure t
  :pin melpa)

;;; Magit
(use-package magit
  :ensure t
  :pin melpa
  :init
  (setq magit-popup-use-prefix-argument 'default)
  :config
  (add-hook 'magit-status-headers-hook 'magit-insert-remote-header t)
  (add-hook 'magit-status-headers-hook 'magit-insert-user-header t)
  (add-hook 'magit-status-headers-hook 'magit-insert-repo-header t)

  (add-hook 'magit-mode-hook 'magit-load-config-extensions))

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
  (use-package company
    :ensure t
    :pin melpa
    :init
    (use-package company-go
      :ensure t
      :pin melpa
      :config
      (add-to-list 'company-backends 'company-go t)))
  (use-package go-direx
    :ensure t
    :pin melpa)
  (use-package go-eldoc
    :ensure t
    :pin melpa
    :config
    (add-hook 'go-mode-hook 'go-eldoc-setup))
  (use-package go-errcheck
    :ensure t
    :pin melpa)
  (use-package go-play
    :ensure t
    :pin marmalade)
  (use-package go-projectile
    :ensure t
    :pin melpa)
  (use-package go-stacktracer
    :ensure t
    :pin melpa)
  (use-package golint
    :ensure t
    :pin melpa)
  (use-package gore-mode
    :ensure t
    :pin melpa)
  (use-package gotest
    :ensure t
    :pin melpa)
  (use-package govet
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
    (add-hook 'ruby-mode-hook 'ruby-electric-mode)))
(use-package robe
  :ensure t
  :pin melpa
  :config
  (add-hook 'ruby-mode-hook 'robe-mode)
  (add-to-list 'company-backends 'company-robe t))
(use-package inf-ruby
  :ensure t
  :pin melpa
  :init
  (use-package company
    :ensure t
    :pin melpa
    :init
    (use-package company-inf-ruby
      :ensure t
      :pin melpa
      :config
      (add-to-list 'company-backends 'company-inf-ruby t))
    (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)))
(use-package rspec-mode
  :ensure t
  :pin melpa)
(use-package rbenv
  :ensure t
  :pin melpa)
(use-package bundler
  :ensure t
  :pin melpa)

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
    :pin melpa
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
    (hide-ifdef-mode))
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

              (hs-minor-mode t)
              )))
(use-package company
  :ensure t
  :pin melpa
  :init
  (use-package company-c-headers
    :ensure t
    :pin melpa
    :config
    (add-to-list 'company-backends 'company-c-headers t)))
(use-package flycheck
  :ensure t
  :pin melpa
  :init
  (use-package flycheck-clangcheck
    :ensure t
    :pin melpa)
  (use-package flycheck-google-cpplint
    :ensure t
    :pin melpa))
(use-package demangle-mode
  :ensure t
  :pin melpa)
(use-package disaster
  :ensure t
  :pin melpa)
(use-package dummy-h-mode
  :ensure t
  :pin melpa)
(use-package irony
  :disabled t
  :ensure t
  :pin melpa
  :init
  (use-package company
    :ensure t
    :pin melpa
    :init
    (use-package company-irony
      :ensure t
      :pin melpa))
  (use-package eldoc
    :init
    (use-package irony-eldoc
      :ensure t
      :pin melpa))
  (use-package flycheck
    :ensure t
    :pin melpa
    :init
    (use-package flycheck-irony
      :ensure t
      :pin melpa)))
(use-package objc-font-lock
  :ensure t
  :pin melpa
  :config
  (objc-font-lock-global-mode))
(use-package malinka
  :disabled t
  :ensure t
  :pin melpa)

;;; JavaScript programming language
(use-package flycheck
  :ensure t
  :pin melpa
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
  :ensure t
  :pin melpa)
(use-package flycheck
  :ensure t
  :pin melpa
  :init
  (setq flycheck-javascript-standard-executable "semistandard"))
(use-package tern
  :ensure t
  :pin melpa
  :init
  (use-package js
    :mode
    (("\\.tern-project\\'" . json-mode)))
  (use-package company
    :ensure t
    :pin melpa
    :init
    (use-package company-tern
      :ensure t
      :pin melpa
      :config
      (add-to-list 'company-backends 'company-tern t)))
  :config
  (add-hook 'js-mode-hook (lambda ()
                            (tern-mode t))))

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
(use-package elpy
  :ensure t
  :pin melpa
  :init
  (elpy-enable)

  ;; disable flymake if flycheck is available
  (when (require 'flycheck nil :noerror)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))))
(use-package py-autopep8
  :ensure t
  :pin melpa)
(use-package flycheck
  :ensure t
  :pin melpa
  :init
  (use-package flycheck-pyflakes
    :ensure t
    :pin melpa))
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

;;;
;;; Flycheck
;;;
(use-package flycheck
  :ensure t
  :pin melpa
  :init
  (use-package flycheck-package
    :ensure t
    :pin melpa)
  :config
  (global-flycheck-mode))

;;;
;;; YouCompleteMe
;;;
(use-package ycmd
  :disabled t
  :ensure t
  :pin melpa
  :init
  (use-package company
    :ensure t
    :pin melpa
    :init
    (use-package company-ycmd
      :ensure t
      :pin melpa
      :config
      (add-to-list 'company-backends 'company-ycmd t)))
  (use-package flycheck
    :ensure t
    :pin melpa
    :init
    (use-package flycheck-ycmd
      :ensure t
      :pin melpa)))

;;;
;;; rtags
;;;
(use-package rtags
  :load-path
  "~/opt/local/share/emacs/site-lisp/rtags"
  :init
  (use-package company
    :ensure t
    :pin melpa
    :init
    (use-package company-rtags
      :load-path
      "~/opt/local/share/emacs/site-lisp/rtags"
      :config
      (add-to-list 'company-backends 'company-rtags t)))
  (use-package popup
    :ensure t
    :pin melpa)
  ;; ensure the right executables are used
  (setq rtags-path "~/opt/local/bin")

  ; required for auto-completion
  (setq rtags-autostart-diagnostics t)
  (setq rtags-completions-enabled t)
  :config
  (rtags-enable-standard-keybindings))

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
;;; Themes
;;;
(when (>= emacs-major-version 24)
  (use-package cyberpunk-theme :ensure t :pin melpa :defer t)
  (use-package grandshell-theme :ensure t :pin melpa :defer t)
  (use-package monokai-theme :ensure t :pin melpa :defer t)
  (use-package paper-theme :ensure t :pin melpa :defer t)
  (use-package solarized-theme :ensure t :pin melpa :defer t)
  (use-package termbright-theme :ensure t :pin melpa :defer t)

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
