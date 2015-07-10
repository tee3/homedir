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
  ;; (when (>= emacs-major-version 23)
  ;;   (add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
  (when (>= emacs-major-version 23)
    (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")))
  (when (>= emacs-major-version 23)
    (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/")))

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
  :defer t
  :diminish abbrev-mode)
(use-package dedicated
  :ensure t
  :defer t)
(use-package desktop
  :config
  (add-to-list 'desktop-globals-to-save 'kill-ring 1)
  (desktop-save-mode))
(use-package diminish
  :ensure t
  :defer t)
(use-package dired
  :defer t
  :init
  (setq dired-kept-versions 6))
(use-package ediff
  :ensure t
  :defer t
  :init
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))
(use-package eldoc
  :defer t
  :diminish eldoc-mode)
(use-package electric-case
  :ensure t
  :defer t)
(use-package etags
  :defer t
  :init
  (setq tags-loop-revert-buffers t))
(use-package expand-region
  :ensure t
  :defer t
  :bind
  ("C-c =" . er/expand-region))
(use-package fm
  :ensure t
  :defer t)
(use-package frame
  :defer t
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
  :defer t
  :init
  (setq version-control t))
(use-package font-core
  :config
  (global-font-lock-mode))
(use-package fringe-mode
  :defer t
  :init
  (setq fringe-mode '(4 . nil)))
(use-package hideshow
  :defer t
  :diminish hs-minor-mode)
(use-package hide-comnt
  :ensure t
  :defer t)
(use-package icomplete
  :defer t
  :init
  (icomplete-mode))
(use-package linum
  :defer t
  :init
  (setq linum-format "%4d "))
(use-package locate
  :defer t
  :config
  (when (equal system-type 'darwin)
    (setq locate-command "mdfind")))
(use-package menu-bar
  :defer t
  :config
  (when (not (display-graphic-p))
    (menu-bar-mode -1)))
(use-package nav
  :ensure t
  :defer t)
(use-package paredit
  :ensure t
  ;; the hooks below will not be added to if deferred
  ;; :defer t
  :diminish paredit-mode
  :init
  (use-package paredit-everywhere
    :ensure t
    :defer t)
  :config
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'scheme-mode-hook 'enable-paredit-mode))
(use-package paren
  :config
  (show-paren-mode))
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
  (setq size-indication-mode t))
(use-package smart-mode-line
  :ensure t
  :defer t
  :init
  (setq sml/theme nil)

  (sml/setup))
(use-package smooth-scroll
  :ensure t
  :defer t)
(use-package speedbar
  :defer t
  :init
  (use-package sb-image
    :defer t
    :init
    (setq speedbar-use-images nil)))
(use-package tool-bar
  :config
  (tool-bar-mode -1))
(use-package undo-tree
  :ensure t
  :defer t
  :diminish undo-tree-mode)
(use-package writeroom-mode
  :ensure t
  :defer t)

;;; Evil (vi) emulation
(use-package evil
  :ensure t
  :defer t)

;;; Text mode hooks
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'text-mode-hook-identify)
(add-hook 'text-mode-hook (lambda ()
                            (setq indent-tabs-mode nil)))
(use-package linum
  :defer t
  :config
  (add-hook 'text-mode-hook (lambda ()
                              (linum-mode 1))))

;;; Programming mode hooks
(add-hook 'prog-mode-hook (lambda ()
                            (setq indent-tabs-mode nil)))
(use-package linum
  :defer t
  :config
  (add-hook 'prog-mode-hook (lambda ()
                              (linum-mode 1))))
(use-package flyspell
  :defer t
  :config
  (add-hook 'prog-mode-hook 'flyspell-prog-mode))

;;; Company
(use-package company
  :ensure t
  :defer t
  :diminish company-mode
  :config
  (global-company-mode))

;;; Flyspell
(use-package flyspell
  :defer t
  :diminish flyspell-mode
  :init
  (use-package flyspell-lazy
    :ensure t
    :defer t)
  :config
  (add-hook 'text-mode-hook 'turn-on-flyspell))

;;; Helm
(use-package helm
  :ensure t
  :defer t
  :diminish helm-mode
  :init
  (use-package helm-config
    :ensure helm)
  (use-package helm-flycheck
    :ensure t
    :defer t
    :bind
    ("C-c ! h" . helm-flycheck))
  (use-package helm-flyspell
    :ensure t
    :defer t)
  (use-package helm-projectile
    :ensure t
    :defer t
    :config
    (helm-projectile-on))
  (setq helm-candidate-number-limit nil)
  (setq helm-quick-update t)
  (setq helm-ff-skip-boring-files t)

  (helm-mode))

;;; Ibuffer
(use-package ibuffer
  :ensure t
  :defer t
  :init
  (use-package ibuffer-vc
    :ensure t
    :defer t)
  (use-package ibuffer-tramp
    :ensure t
    :defer t)
  (use-package ibuffer-git
    :ensure t
    :defer t)
  (use-package ibuffer-projectile
    :ensure t
    :defer t))

;;; Ido
(use-package ido
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
  :defer t)
(use-package noccur
  :ensure t
  :defer t)

;;; Projectile
(use-package projectile
  :ensure t
  :defer t
  :diminish projectile-mode
  :init
  (projectile-global-mode)

  (setq projectile-switch-project-action 'projectile-dired)

  ;; @tood workaround for an issue with tramp
  (setq projectile-mode-line " Projectile"))

;;;
;;; Snippets
;;;
(use-package yasnippet
  :ensure t
  :defer t
  :init
  (yas-global-mode))

;;; Learning Emacs
(use-package guru-mode
  :ensure t
  :defer t)
(use-package vimgolf
  :ensure t
  :defer t)
(use-package howdoi
  :ensure t
  :defer t)

;;;
;;; Org
;;;
(use-package org
  :ensure t
  :defer t)

;;;
;;; Gnus
;;;
(use-package gnus
  :defer t
  :init
  (setq gnus-select-method '(nntp "news.gmane.org")))

;;;
;;; Markdown formats
;;;
(use-package adoc-mode
  :ensure t
  :defer t)
(use-package creole-mode
  :ensure t
  :defer t)
(use-package jade-mode
  :ensure t
  :defer t)
(use-package markdown-mode
  :ensure t
  :defer t
  :mode
  (("\\.markdown\\'" . markdown-mode)
   ("\\.md\\'" . markdown-mode)
   ("README\.md\\'" . gfm-mode))
  :init
  (use-package markdown-mode+
    :ensure t
    :defer t))
(use-package markup-faces
  :ensure t
  :defer t)
(use-package pandoc-mode
  :ensure t
  :defer t)
(use-package rst
  ;; @todo Add options "--verbose --strict --date --time"
  :defer t)
(use-package sphinx-frontend
  :ensure t
  :defer t)

;;; Utilities
(use-package ascii
  :ensure t
  :defer t)

;;; Android development
(use-package android-mode
  :ensure t
  :defer t)

;;;
;;; Configuration files
;;;
(use-package apache-mode
  :ensure t
  :defer t)
(use-package crontab-mode
  :ensure t
  :defer t)
(use-package csv-mode
  :ensure t
  :defer t)
(use-package dockerfile-mode
  :ensure t
  :defer t)
(use-package gitattributes-mode
  :ensure t
  :defer t)
(use-package gitconfig-mode
  :ensure t
  :defer t
  :mode
  (("\\.gitconfig.*\\'" . gitconfig-mode)

   ;; SubGit-generated Git submodules files
   ("\\.gitsvnextmodules\\'" . gitconfig-mode)
   ;; migration-generated Git submodules files
   ("\\.gitsvnexternals\\'" . gitconfig-mode)))
(use-package gitignore-mode
  :ensure t
  :defer t)
(use-package graphviz-dot-mode
  :ensure t
  :defer t)
(use-package irfc
  :ensure t
  :defer t)
(use-package jgraph-mode
  :ensure t
  :defer t)
(use-package json-mode
  :ensure t
  :defer t)
(use-package nginx-mode
  :ensure t
  :defer t)
(use-package osx-plist
  :ensure t
  :defer t)
(use-package pov-mode
  :ensure t
  :defer t)
(use-package protobuf-mode
  :ensure t
  :defer t)
(use-package ssh-config-mode
  :ensure t
  :defer t
  :mode
  ((".ssh/config\\'" . ssh-config-mode)
   ("sshd?_config\\'" . ssh-config-mode)
   ("known_hosts\\'" . ssh-known-hosts-mode)
   ("authorized_keys2?\\'" . ssh-authorized-keys-mode)))
(use-package syslog-mode
  :ensure t
  :defer t
  :mode
  (("/var/log.*\\'" . syslog-mode)))
(use-package systemd
  :ensure t
  :defer t)
(use-package toml-mode
  :ensure t
  :defer t)
(use-package vimrc-mode
  :ensure t
  :defer t)
(use-package yaml-mode
  :ensure t
  :defer t)

;;;
;;; Programming languages
;;;
(use-package applescript-mode
  :ensure t
  :defer t)
(use-package asm-mode
  :defer t
  :mode
  (("\\.[sh][56][45x]\\'" . asm-mode)))
(use-package coffee-mode
  :ensure t
  :defer t)
(use-package cperl-mode
  :ensure t
  :defer t)
(use-package csharp-mode
  :disabled t
  :ensure t
  :defer t
  :init
  (use-package omnisharp
    :disabled t
    :ensure t
    :defer t))
(use-package d-mode
  :ensure t
  :defer t)
(use-package fish-mode
  :ensure t
  :defer t)
(use-package haskell-mode
  :ensure t
  :defer t
  :init
  (use-package company
    :ensure t
    :defer t
    :init
    (use-package company-ghc
      :ensure t
      ;; this will not be added to company-backends if deferred
      ;; :defer t
      :config
      (add-to-list 'company-backends 'company-ghc t))))
(use-package lua-mode
  :ensure t
  :defer t)
(use-package matlab-mode
  :ensure t
  :defer t)
(use-package octave
  :defer t)
(use-package php-mode
  :ensure t
  :defer t)
(use-package powershell
  :ensure t
  :defer t)
(use-package processing-mode
  :ensure t
  :defer t
  :init
  (use-package processing-snippets
    :ensure t
    :defer t))
(use-package sql
  :defer t
  :init
  (setq sql-sqlite-program "sqlite3"))
(use-package swift-mode
  :ensure t
  ;; this will not be added to flycheck-checkers if deferred
  ;; :defer t
  :init
  (use-package flycheck
    :ensure t
    ;; swift will not be added to flycheck-checkers if deferred
    ;; :defer t
    )
  :config
  (add-to-list 'flycheck-checkers 'swift))
(use-package tcl
  :defer t
  :init
  (setq tcl-application "tclsh"))
(use-package tidy
  :ensure t
  :defer t)
(use-package web-mode
  :ensure t
  :defer t)

;;; TeX and LaTeX
(use-package tex-site
  :ensure auctex
  :defer t
  :init
  (use-package company
    :ensure t
    :defer t
    :init
    (use-package company-auctex
      :ensure t
      ;; this will not be added to company-backends if deferred
      ;; :defer t
      :config
      (add-to-list 'company-backends 'company-auctex t))))

;;; OpenGL
(use-package cuda-mode
  :ensure t
  :defer t)
(use-package glsl-mode
  :ensure t
  :defer t)

;;; Tags
(use-package gtags
  :ensure t
  :defer t)

;;; Scheme programming language
(use-package geiser
  :ensure t
  :defer t)

;;; Google
(use-package google-this
  :ensure t
  :defer t
  :diminish google-this-mode
  :init
  (google-this-mode))

;;; SSH
(use-package ssh
  :ensure t
  :defer t)

;;;
;;; Version Control Systems
;;;
(use-package vc
  :defer t
  :init
  (setq vc-make-backup-files t))

;;; Fossil
(use-package vc-fossil
  :ensure t
  :defer t
  :init
  (use-package vc
    :defer t))

;;; Git
(use-package git-gutter
  :ensure t
  :defer t)
(use-package git-gutter-fringe
  :ensure t
  :defer t)

;;; GitHub
(use-package gist
  :ensure t
  :defer t)

;;; Magit
(use-package magit
  :ensure t
  :defer t
  :config
  (add-hook 'magit-mode-hook 'magit-load-config-extensions))

;;; Microsoft Team Foundation Server
(use-package tfs
  :ensure t
  :defer t)
(use-package vc-tfs
  :ensure t
  :defer t
  :init
  (use-package vc
    :defer t))

;;; Mercurial
(use-package monky
  :ensure t
  :defer t)
(use-package hgignore-mode
  :ensure t
  :defer t)
(use-package conf-mode
  :defer t
  :mode
  ((".hgrc.*\\'" . conf-mode)))

;;; Perforce
(use-package p4
  :ensure t
  :defer t)

;;; Subversion
(use-package psvn
  :ensure t
  :defer t)

;;; Make
(use-package make-mode
  :defer t
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
  (use-package linum
    :defer t)
  (use-package flyspell
    :defer t)
  :config
  (add-hook 'jam-mode-hook (lambda ()
                             (setq indent-tabs-mode nil)))
  (add-hook 'jam-mode-hook (lambda ()
                             (linum-mode 1)))
  (add-hook 'jam-mode-hook 'flyspell-prog-mode))

;;; CMake
(use-package cmake-mode
  :ensure t
  :defer t
  :mode
  (("CMakeLists\\.txt\\'" . cmake-mode)
   ("\\.cmake\\'" . cmake-mode)))
(use-package cmake-font-lock
  :ensure t
  :defer t)
(use-package cmake-project
  :ensure t
  :defer t)
(use-package cpputils-cmake
  :ensure t
  :defer t)

;;;
;;; Gnuplot
;;;
(use-package gnuplot
  :ensure t
  :defer t)
(use-package gnuplot-mode
  :ensure t
  :defer t
  :mode
  (("\\.gp\\'" . gnuplot-mode)))

;;; Go programming language
(use-package go-mode
  :ensure t
  :defer t
  :init
  (use-package company
    :ensure t
    :defer t
    :init
    (use-package company-go
      :ensure t
      ;; this will not be added to company-backends if deferred
      ;; :defer t
      :config
      (add-to-list 'company-backends 'company-go t)))
  (use-package go-direx
    :ensure t
    :defer t)
  (use-package go-eldoc
    :ensure t
    ;; this will not be added to company-backends if deferred
    ;; :defer t
    :config
    (add-hook 'go-mode-hook 'go-eldoc-setup))
  (use-package go-errcheck
    :ensure t
    :defer t)
  (use-package go-play
    :ensure t
    :defer t)
  (use-package go-projectile
    :ensure t
    :defer t)
  (use-package go-stacktracer
    :ensure t
    :defer t)
  (use-package golint
    :ensure t
    :defer t)
  (use-package gore-mode
    :ensure t
    :defer t)
  (use-package gotest
    :ensure t
    :defer t)
  (use-package govet
    :ensure t
    :defer t)
  :config
  (add-hook 'go-mode-hook (lambda ()
                            ;; allow use of tabs as it is required by go fmt
			    (setq indent-tabs-mode t)

                            ;; format before save
                            (add-hook 'before-save-hook 'gofmt-before-save))))

;;; Ruby programming language
(use-package ruby-mode
  :defer t
  :mode
  (("[Rr]akefile\\'" . ruby-mode)
   ("\\.rake\\'" . ruby-mode))
  :init
  (use-package ruby-compilation
    :ensure t
    :defer t)
  (use-package ruby-electric
    :ensure t
    :defer t
    :config
    (add-hook 'ruby-mode-hook 'ruby-electric-mode)))
(use-package robe
  :ensure t
  :defer t
  :diminish robe-mode
  :config
  (add-hook 'ruby-mode-hook 'robe-mode)
  (add-to-list 'company-backends 'company-robe t))
(use-package inf-ruby
  :ensure t
  :defer t
  :init
  (use-package company
    :ensure t
    :defer t
    :init
    (use-package company-inf-ruby
      :ensure t
      ;; this will not be added to company-backends if deferred
      ;; :defer t
      :config
      (add-to-list 'company-backends 'company-inf-ruby t))
    (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)))
(use-package rspec-mode
  :ensure t
  :defer t)
(use-package rbenv
  :ensure t
  :defer t)
(use-package bundler
  :ensure t
  :defer t)

;;; Objective-J programming language
(use-package objj-mode
  :load-path "~/opt/local/share/emacs/site-lisp"
  :mode
  (("\\.j\\'" . objj-mode))
  :init
  (use-package compile
    :defer t
    :config
    (add-to-list 'compilation-error-regexp-alist-alist
                 '(objj-acorn "^\\(WARNING\\|ERROR\\) line \\([0-9]+\\) in file:\\([^:]+\\):\\(.*\\)$" 3 2))
    (add-to-list 'compilation-error-regexp-alist 'objj-acorn))
  (use-package js
    :defer t
    :mode
    (("\\.sj\\'" . js-mode))))

;;; Jake
(use-package js
  :defer t
  :mode
  (("[Jj]akefile.*\\'" . js-mode)
   ("\\.jake\\'" . js-mode)))

;;; XML
(use-package nxml
  :defer t
  :mode
  (("\\.xml\\'" . nxml-mode)
   ("\\.xsl\\'" . nxml-mode)
   ("\\.xsd\\'" . nxml-mode)
   ("\\.rng\\'" . nxml-mode)
   ("\\.xhtml\\'" . nxml-mode)))

;;; DITA
(use-package nxml
  :defer t
  :mode
  (("\\.dita\\'" . nxml-mode)
   ("\\.ditamap\\'" . nxml-mode)))

;;; DocBook
(use-package docbook
  :ensure t
  :defer t)
(use-package nxml
  :defer t
  :mode
  (("\\.docbook\\'" . nxml-mode)))

;;; C-family programming languages
(use-package cc-mode
  :defer t
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
    :defer t
    :diminish cwarn-mode
    :init
    (global-cwarn-mode t))
  (use-package google-c-style
    :ensure t
    :defer t)
  (use-package c-eldoc
    :ensure t
    :defer t
    :init
    ;; add more as desired, superset of what you'd like to use
    (setq c-eldoc-includes "-I.")
    :config
    (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
    (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode))
  (use-package hideif
    :defer t
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
  :defer t
  :init
  (use-package company-c-headers
    :ensure t
    ;; this will not be added to company-backends if deferred
    ;; :defer t
    :config
    (add-to-list 'company-backends 'company-c-headers t)))
(use-package flycheck
  :ensure t
  :defer t
  :init
  (use-package flycheck-clangcheck
    :ensure t
    ;; this will not be added to flycheck-checkers if deferred
    ;; :defer t
    )
  (use-package flycheck-google-cpplint
    :ensure t
    ;; this will not be added to flycheck-checkers if deferred
    ;; :defer t
    ))
(use-package demangle-mode
  :ensure t
  :defer t)
(use-package disaster
  :ensure t
  :defer t)
(use-package dummy-h-mode
  :ensure t
  :defer t)
(use-package irony
  :disabled t
  :ensure t
  :defer t
  :init
  (use-package company
    :ensure t
    :defer t
    :init
    (use-package company-irony
      :ensure t
      :defer t))
  (use-package eldoc
    :defer t
    :init
    (use-package irony-eldoc
      :ensure t
      :defer t))
  (use-package flycheck
    :ensure t
    :defer t
    :init
    (use-package flycheck-irony
      :ensure t
      ;; this will not be added to flycheck-checkers if deferred
      ;; :defer t
      )))
(use-package objc-font-lock
  :ensure t
  :defer t)
(use-package malinka
  :ensure t
  :defer t))

;;; JavaScript programming language
(use-package js
  :defer t)
(use-package js-comint
  :ensure t
  :defer t
  :init
  (setq inferior-js-program-command "v8 --shell"))
(use-package tern
  :ensure t
  :defer t
  :init
  (use-package company
    :ensure t
    :defer t
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
  :ensure t
  :defer t)

;;; Generic modes
(use-package generic-x
  :defer t)

;;; Python programming language
(use-package python
  :defer t
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
  :ensure t
  :defer t)
(use-package flycheck
  :ensure t
  :defer t
  :init
  (use-package flycheck-pyflakes
    :ensure t
    ;; this will not be added to flycheck-checkers if deferred
    ;; :defer t
    ))
(use-package pip-requirements
  :ensure t
  :defer t)
(use-package nose
  :ensure t
  :defer t)
(use-package virtualenv
  :ensure t
  :defer t)

;;; Code Composer Studio and DSP/BIOS mode
(use-package cc-mode
  :defer t
  :mode
  (("\\.h[cd]f\\'" . c-mode)
   ("\\.l[cd]f\\'" . c-mode)))
(use-package js
  :defer t
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
  :defer t
  :diminish flycheck-mode
  :init
  (use-package flycheck-package
    :ensure t
    ;; this will not be added to flycheck-checkers if deferred
    ;; :defer t
    )
  :config
  (global-flycheck-mode))

;;;
;;; YouCompleteMe
;;;
(use-package ycmd
  :disabled t
  :ensure t
  :defer t
  :init
  (use-package company
    :ensure t
    :defer t
    :init
    (use-package company-ycmd
      :ensure t
      :config
      (add-to-list 'company-backends 'company-ycmd t)))
  (use-package flycheck
    :ensure t
    :defer t
    :init
    (use-package flycheck-ycmd
      :ensure t
      ;; this will not be added to flycheck-checkers if deferred
      ;; :defer t
      )))

;;;
;;; rtags
;;;
(use-package rtags
  :load-path
  "~/opt/local/src/rtags/src"
  :init
  (use-package company
    :ensure t
    :defer t
    :init
    (use-package company-rtags
      :load-path
      "~/opt/local/src/rtags/src"
      :config
      (add-to-list 'company-backends 'company-rtags t)))
  :config
  (rtags-enable-standard-keybindings c-mode-base-map "\C-xt"))

;;;
;;; Rainbow modes
;;;
(use-package rainbow-delimiters
  :disabled t
  :ensure t
  :defer t
  :init
  (global-rainbow-delimiters-mode))
(use-package rainbow-identifiers
  :disabled t
  :ensure t
  :defer t
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
  (use-package assemblage-theme :ensure t :defer t)
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
  (use-package deep-thought-theme :ensure t :defer t)
  (use-package distinguished-theme :ensure t :defer t)
  (use-package django-theme :ensure t :defer t)
  (use-package eclipse-theme :ensure t :defer t)
  (use-package espresso-theme :ensure t :defer t)
  (use-package farmhouse-theme :ensure t :defer t)
  (use-package firebelly-theme :ensure t :defer t)
  (use-package flatland-theme :ensure t :defer t)
  (use-package flatui-theme :ensure t :defer t)
  (use-package gandalf-theme :ensure t :defer t)
  (use-package github-theme :ensure t :defer t)
  (use-package gotham-theme :ensure t :defer t)
  (use-package grandshell-theme :ensure t :defer t)
  (use-package greymatters-theme :ensure t :defer t)
  (use-package gruber-darker-theme :ensure t :defer t)
  (use-package gruvbox-theme :ensure t :defer t)
  (use-package hc-zenburn-theme :ensure t :defer t)
  (use-package hemisu-theme :ensure t :defer t)
  (use-package heroku-theme :ensure t :defer t)
  (use-package hipster-theme :ensure t :defer t)
  (use-package inkpot-theme :ensure t :defer t)
  (use-package ir-black-theme :ensure t :defer t)
  (use-package jazz-theme :ensure t :defer t)
  (use-package jujube-theme :ensure t :defer t)
  (use-package late-night-theme :ensure t :defer t)
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
  (use-package nzenburn-theme :ensure t :defer t)
  (use-package obsidian-theme :ensure t :defer t)
  (use-package occidental-theme :ensure t :defer t)
  (use-package oldlace-theme :ensure t :defer t)
  (use-package organic-green-theme :ensure t :defer t)
  (use-package pastels-on-dark-theme :ensure t :defer t)
  (use-package phoenix-dark-mono-theme :ensure t :defer t)
  (use-package phoenix-dark-pink-theme :ensure t :defer t)
  (use-package plan9-theme :ensure t :defer t)
  (use-package planet-theme :ensure t :defer t)
  (use-package professional-theme :ensure t :defer t)
  (use-package purple-haze-theme :ensure t :defer t)
  (use-package qsimpleq-theme :ensure t :defer t)
  (use-package railscasts-theme :ensure t :defer t)
  (use-package sea-before-storm-theme :ensure t :defer t)
  (use-package seti-theme :ensure t :defer t)
  (use-package smyx-theme :ensure t :defer t)
  (use-package soft-charcoal-theme :ensure t :defer t)
  (use-package soft-morning-theme :ensure t :defer t)
  (use-package soft-stone-theme :ensure t :defer t)
  (use-package solarized-theme :ensure t :defer t)
  (use-package soothe-theme :ensure t :defer t)
  (use-package spacegray-theme :ensure t :defer t)
  (use-package steady-theme :ensure t :defer t)
  (use-package stekene-theme :ensure t :defer t)
  (use-package sublime-themes :ensure t :defer t)
  (use-package subatomic-theme :ensure t :defer t)
  (use-package subatomic256-theme :ensure t :defer t)
  (use-package sunny-day-theme :ensure t :defer t)
  (use-package tango-plus-theme :ensure t :defer t)
  (use-package tao-theme :ensure t :defer t)
  (use-package tangotango-theme :ensure t :defer t)
  (use-package tommyh-theme :ensure t :defer t)
  (use-package toxi-theme :ensure t :defer t)
  (use-package tron-theme :ensure t :defer t)
  (use-package tronesque-theme :ensure t :defer t)
  (use-package twilight-theme :ensure t :defer t)
  (use-package twilight-anti-bright-theme :ensure t :defer t)
  (use-package twilight-bright-theme :ensure t :defer t)
  (use-package ubuntu-theme :ensure t :defer t)
  (use-package ujelly-theme :ensure t :defer t)
  (use-package underwater-theme :ensure t :defer t)
  (use-package waher-theme :ensure t :defer t)
  (use-package warm-night-theme :ensure t :defer t)
  (use-package yoshi-theme :ensure t :defer t)
  (use-package zen-and-art-theme :ensure t :defer t)
  (use-package zenburn-theme :ensure t :defer t)
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
  :defer t
  :config
  (unless (server-running-p)
    (server-start)))

(provide '.emacs)
;;; .emacs ends here
