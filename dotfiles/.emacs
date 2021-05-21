;;; .emacs --- Emacs user configuration file  -*- lexical-binding: t; -*-
;;;
;;; URL: https://tee3.github.com/homedir
;;;
;;; Commentary:
;;;
;;;    This file customizes Emacs for a specific user's needs.
;;;
;;; Code:


;;; Disable support for decoding 'x-display' in Enriched Text mode
;;; prior to Emacs 25.3 since this is a security hole.
(when (or (< emacs-major-version 25)
          (and (= emacs-major-version 25) (< emacs-minor-version 3)))
  (eval-after-load "enriched"
    '(defun enriched-decode-display-prop (start end &optional param)
       (list start end))))

;;; Set up package
(when (require 'package nil :noerror)

  ;; add packages libraries
  (when (< emacs-major-version 24)
    (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t))
  (when (>= emacs-major-version 23)
    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

  (setq package-native-compile t)

  (package-initialize))

;;; Bootstrap use-package
(setq-default use-package-always-defer t)

(setq-default use-package-enable-imenu-support t)

(setq-default use-package-compute-statistics nil)

(when (require 'package nil :noerror)
  (when (boundp 'package-pinned-packages)
    (setq package-pinned-packages
          '((use-package . "melpa"))))

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

;;; Configuration
(defgroup tee3 nil
  "Customization variables in the .emacs file."
  :group 'convenience)

(defcustom tee3-display-line-numbers nil
  "This is use to enable or disable line numbers."
  :type 'boolean)

(defcustom tee3-desired-completion-system 'default
  "This is used to choose a completion system when it must be done at configuration."
  :type 'symbol
  :options '('default 'icomplete 'fido))

;;; Emacs
(setq inhibit-startup-screen t)
(setq scroll-conservatively 100)
(setq-default truncate-lines t)
(setq visible-bell t)
(column-number-mode)
(use-package time
  :demand t
  :init
  (setq display-time-day-and-date nil)
  :config
  (display-time-mode))
(setq split-height-threshold 0)
(use-package files
  :init
  (setq version-control t))

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

(use-package auth-source
  :init
  (cond
   ((equal system-type 'darwin)
    (customize-set-value 'auth-sources '(macos-keychain-internet
                                         macos-keychain-generic
                                         "~/.authinfo.gpg")))
   (t
    (customize-set-value 'auth-sources '("~/.authinfo.gpg")))))

(use-package epa
  :init
  (setq epa-pinentry-mode 'loopback))

(use-package autoinsert
  :demand t
  :config
  (auto-insert-mode))
(use-package autorevert)
(use-package newcomment
  :init
  (setq comment-empty-lines t))
(use-package browse-url
  :init
  (setq browse-url-browser-function 'eww-browse-url)
  :bind
  ("C-c b b b" . browse-url))
(use-package cus-edit
  :init
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  (load custom-file 'noerror))
(use-package abbrev)
(use-package compile
  :bind
  ("C-c c c" . compile)
  ("C-c c r" . recompile))
(use-package desktop
  :demand t
  :preface
  (defun tee3-disable-themes ()
    (mapc 'disable-theme custom-enabled-themes))
  :init
  ;; @todo do not restore frames for now
  (setq desktop-restore-frames nil)
  (setq desktop-restore-in-current-display nil)
  (setq desktop-restore-forces-onscreen nil)
  (setq desktop-restore-reuses-frames nil)
  :config
  (add-to-list 'desktop-globals-to-save 'kill-ring)

  (desktop-save-mode)
  :hook
  (kill-emacs . tee3-disable-themes))
(use-package diff-mode
  :init
  (setq diff-default-read-only t)
  (setq diff-font-lock-prettify t)
  (setq diff-font-lock-syntax nil)
  (setq diff-refine nil))
(use-package dired
  :init
  (setq dired-kept-versions 6))
(use-package ediff
  :init
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))
(use-package eldoc
  :ensure t
  :pin gnu
  :demand t
  :config
  (global-eldoc-mode))
(use-package elec-pair
  :demand t
  :init
  (electric-pair-mode))
(use-package etags
  :init
  (setq tags-loop-revert-buffers t))
(use-package eww
  :init
  (setq eww-restore-desktop t)
  :bind
  ("C-c b e b" . eww))
(use-package ffap)
(use-package font-core
  :demand t
  :config
  (global-font-lock-mode))
(use-package frame
  :demand t
  :config
  (add-to-list 'initial-frame-alist '(width . 160))
  (add-to-list 'initial-frame-alist '(height . 48))
  (if (member "Source Code Pro" (font-family-list))
      (add-to-list 'initial-frame-alist '(font . "Source Code Pro")))

  (add-to-list 'default-frame-alist '(width . 160))
  (add-to-list 'default-frame-alist '(height . 48))
  (if (member "Source Code Pro" (font-family-list))
      (add-to-list 'default-frame-alist '(font . "Source Code Pro"))))
(use-package fringe
  :init
  (setq fringe-mode '(4 . nil)))
(use-package hideshow
  :init
  (setq hs-hide-comments-when-hiding-all t))
(use-package icomplete
  :init
  (setq icomplete-show-matches-on-no-input t)
  :config
  (cond
   ((equal tee3-desired-completion-system 'icomplete)
    (icomplete-mode))
   ((equal tee3-desired-completion-system 'fido)
    (fido-mode))))
(use-package linum
  :if
  (and tee3-display-line-numbers
       (< emacs-major-version 26))
  :init
  (setq linum-format "%4d ")
  :hook
  (text-mode . linum-mode)

  (prog-mode . linum-mode))
(use-package display-line-numbers
  :if
  (and tee3-display-line-numbers
       (>= emacs-major-version 26))
  :init
  (setq display-line-numbers-grow-only t)
  (setq display-line-numbers-width-start 3)
  :hook
  (text-mode . display-line-numbers-mode)
  (prog-mode . display-line-numbers-mode))
(use-package gnus
  :init
  (setq gnus-init-file "~/.gnus")
  (setq gnus-home-directory user-emacs-directory)

  (setq gnus-save-newsrc-file nil)
  (setq gnus-read-newsrc-file nil)

  (setq gnus-asynchronous t)

  (setq gnus-use-cache t))
(use-package mb-depth
  :demand t
  :init
  (setq enable-recursive-minibuffers t)
  :config
  (minibuffer-depth-indicate-mode))
(use-package message
  :init
  (setq message-directory (expand-file-name "Mail" user-emacs-directory)))
(use-package locate
  :init
  (when (equal system-type 'darwin)
    (setq locate-command "mdfind")))
(use-package minibuffer
  :init
  (when (>= emacs-major-version 28)
    (setq completions-format 'one-column)
    (setq completions-detailed t)))
(use-package minibuf-eldef
  :demand t
  :init
  (setq minibuffer-eldef-shorten-default t)
  :config
  (minibuffer-electric-default-mode))
(use-package menu-bar
  :demand t
  :config
  (when (not (display-graphic-p))
    (menu-bar-mode -1)))
(use-package paredit
  :ensure t
  :pin melpa
  :hook
  (emacs-lisp-mode . paredit-mode)
  (lisp-mode . paredit-mode)
  (scheme-mode . paredit-mode))
(use-package paren
  :demand t
  :config
  (show-paren-mode))
(use-package pcomplete
  :hook
  (shell-mode . pcomplete-shell-setup))
(use-package project
  :ensure t
  :pin gnu
  :init
  (setq project-compilation-buffer-name-function 'project-prefixed-buffer-name))
(use-package savehist
  :demand t
  :init
  (setq history-length t)
  :config
  (savehist-mode))
(use-package saveplace
  :demand t
  :config
  (if (>= emacs-major-version 25)
      (save-place-mode)
    (setq-default save-place t)))
(use-package scroll-bar
  :demand t
  :config
  (scroll-bar-mode -1))
(use-package simple
  :init
  (setq size-indication-mode t)
  (setq kill-ring-max 1000)
  (setq kill-do-not-save-duplicates t)
  (setq save-interprogram-paste-before-kill t)
  (setq global-mark-ring-max 10000)
  (setq mark-ring-max 10000)
  (setq set-mark-command-repeat-pop t)
  :hook
  (text-mode . auto-fill-mode))
(use-package so-long
  :ensure t
  :pin gnu
  :demand t
  :config
  (global-so-long-mode))
(use-package speedbar
  :init
  (eval-after-load "sb-image.el"
    (setq speedbar-use-images nil)))
(use-package term
  :init
  (setq term-buffer-maximum-size 0))
(use-package tool-bar
  :demand t
  :config
  (tool-bar-mode -1))
(use-package tooltip
  :init
  (setq tooltip-mode nil))
(use-package tramp
  :ensure t
  :pin gnu)
(use-package winner
  :demand t
  :init
  (winner-mode))
(use-package windmove
  :demand t
  :init
  (setq windmove-wrap-around t)
  :config
  (windmove-default-keybindings 'shift))
(use-package xref
  :ensure t
  :pin gnu)

(use-package darkroom
  :ensure t
  :pin gnu)

;;; Text mode hooks
(add-hook 'text-mode-hook (lambda () (setq indent-tabs-mode nil)))

;;; Programming mode hooks
(add-hook 'prog-mode-hook (lambda () (setq indent-tabs-mode nil)))

(use-package hideshow
  :hook
  (prog-mode . hs-minor-mode))

;;; Debbugs
(use-package debbugs
  :ensure t
  :pin gnu)

;;; Flyspell
(use-package flyspell
  :hook
  (text-mode . flyspell-mode)
  (prog-mode . flyspell-prog-mode))

;;; Yasnippet
(use-package yasnippet
  :ensure t
  :pin melpa
  :demand t
  :init
  (setq yas-alias-to-yas/prefix-p nil)
  :config
  (yas-global-mode))

;;; Learning Emacs
(use-package guru-mode
  :ensure t
  :pin melpa)
(use-package howdoi
  :ensure t
  :pin melpa)

;;; Org
(use-package org
  :ensure t
  :pin gnu)

;;; Markdown formats
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
  (setq markdown-asymmetric-header t)
  (cond ((executable-find "cmark-gfm")
         (setq markdown-command "cmark-gfm --extension table --extension strikethrough --extension autolink --extension tagfilter"))
        ((executable-find "cmark")
         (setq markdown-command "cmark")))
  (setq markdown-nested-imenu-heading-index t))
(use-package rst)

;;; Android development
(use-package android-mode
  :ensure t
  :pin melpa)

;;; Configuration files
(use-package apache-mode
  :ensure t
  :pin melpa)
(use-package csv-mode
  :ensure t
  :pin gnu
  :init
  (setq csv-align-style 'auto))
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
(use-package jgraph-mode
  :ensure t
  :pin gnu)
(use-package newsticker
  :demand t
  :init
  (setq newsticker-frontend 'newsticker-plainview)
  (setq newsticker-show-descriptions-of-new-items nil)
  (setq newsticker-hide-old-items-in-newsticker-buffer t)
  :config
  (add-to-list 'newsticker-url-list '("isocpp.org - Recent Highlights" "https://isocpp.org/blog/rss/category/news"))
  (add-to-list 'newsticker-url-list '("isocpp.org - C++ Standardization" "https://isocpp.org/blog/rss/category/standardization"))
  (add-to-list 'newsticker-url-list '("isocpp.org - C++ FAQ" "https://isocpp.org/themes/wiki_themes/isocpp/rss/faq-revisions-rss.php"))
  (add-to-list 'newsticker-url-list '("RFC" "https://www.rfc-editor.org/rfcrss.xml")))
(use-package nginx-mode
  :ensure t
  :pin melpa)
(use-package protobuf-mode
  :ensure t
  :pin melpa)
(use-package flatbuffers-mode
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
(use-package graphql-mode
  :ensure t
  :pin melpa)

;;; Programming languages
(use-package ada-mode
  :ensure ada-mode
  :pin gnu)
(use-package applescript-mode
  :disabled t
  :ensure t
  :pin melpa)
(use-package asm-mode
  :preface
  (defun tee3-asm-mode-setup ()
    (setq indent-tabs-mode t))
  :mode
  (("\\.[sh][56][45x]\\'" . asm-mode))
  :hook
  (asm-mode . tee3-asm-mode-setup))
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
  :pin melpa)
(use-package d-mode
  :ensure t
  :pin melpa)
(use-package fish-mode
  :ensure t
  :pin melpa)
(use-package jenkinsfile-mode
  :ensure t
  :pin melpa)
(use-package haskell-mode
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
(use-package verilog-mode
  :ensure t
  :pin gnu)
(use-package vhdl-mode)
(use-package web-mode
  :ensure t
  :pin melpa
  :preface
  (defun tee3-web-mode-setup ()
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-code-indent-offset 4)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-indent-style 2)

    (setq web-mode-style-padding 1)
    (setq web-mode-script-padding 1)
    (setq web-mode-block-padding 0))
  :hook
  (web-mode . tee3-web-mode-setup))

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
(use-package scheme
  :mode
  (("\\.guile\\'" . scheme-mode)))
(use-package geiser
  :ensure t
  :pin melpa
  :init
  (setq geiser-mode-start-repl-p t))
(use-package geiser-guile
  :ensure t
  :pin melpa
  :after geiser)
(use-package geiser-mit
  :ensure t
  :pin melpa
  :after geiser)

;;; Search engines
(use-package engine-mode
  :ensure t
  :pin melpa
  :demand t
  :preface
  (setq engine/keybinding-prefix "C-c s")
  :init
  (defengine amazon
    "https://www.amazon.com/s?k=%s"
    :keybinding "a")
  (defengine cppreference
    "https://google.com/search?gfns&q=%s+site:cppreference.com"
    :keybinding "c")
  (defengine duckduckgo
    "https://duckduckgo.com/?q=%s"
    :keybinding "d")
  (defengine github
    "https://github.com/search?ref=simplesearch&q=%s"
    :keybinding "h")
  (defengine google
    "https://google.com/search?q=%s"
    :keybinding "g")
  (defengine maps
    "https://google.com/maps?q=%s"
    :keybinding "m")
  (defengine wikipedia
    "https://google.com/search?q=%s+site:wikipedia.org"
    :keybinding "w")
  (defengine stack-overflow
    "https://stackoverflow.com/search?q=%s"
    :keybinding "s")
  :config
  (engine-mode))

;;; Version Control Systems
(use-package vc
  :init
  (setq vc-make-backup-files t)

  (setq vc-git-print-log-follow t))
(use-package vc-fossil
  :ensure t
  :pin melpa
  :after vc)

;;; Imenu
(use-package imenu)
(use-package imenu-list
  :ensure t
  :pin melpa
  :after imenu
  :init
  (setq imenu-list-focus-after-activation t)
  (setq imenu-list-auto-resize t))

;;; Git
(use-package gited
  :ensure t
  :pin gnu
  :demand t
  :init
  (setq gited-verbose t)
  :config
  (define-key dired-mode-map "\C-x\C-g" 'gited-list-branches))
(use-package git-timemachine
  :ensure t
  :pin melpa)

;;; Gitolite
(use-package gl-conf-mode
  :ensure t
  :pin melpa
  :mode
  (("gitolite\\.conf\\'" . gl-conf-mode)))

;;; Magit
(use-package magit
  :if
  (or (> emacs-major-version 24)
      (and (= emacs-major-version 24) (>= emacs-minor-version 4)))
  :ensure t
  :pin melpa
  :bind
  ("C-c v g s" . magit-status)
  :init
  (setq magit-repository-directories (quote (("~/Development" . 2)))))
(use-package magit-lfs
  :ensure t
  :pin melpa
  :after magit)
(use-package magit-svn
  :ensure t
  :pin melpa
  :after magit)
(use-package forge
  :ensure t
  :pin melpa
  :after magit)

;;; Mercurial
(use-package monky
  :ensure t
  :pin melpa
  :bind
  ("C-c v m s" . monky-status))
(use-package hgignore-mode
  :ensure t
  :pin melpa)
(use-package conf-mode
  :mode
  ((".hgrc.*\\'" . conf-mode)))

;;; Perforce
(use-package p4
  :ensure t
  :pin melpa
  :init
  (setq p4-global-key-prefix (kbd "C-c v p")))

;;; Subversion
(use-package psvn
  :disabled ; @todo find an alternative package
  :ensure t
  :pin marmalade
  :bind
  ("C-c v s s" . svn-status))

;;; Make
(use-package make-mode
  :preface
  (defun tee3-make-mode-setup ()
    (setq indent-tabs-mode t))
  :mode
  (("Makefile.*\\'" . makefile-mode))
  :hook
  (makefile-mode . tee3-make-mode-setup))

;;; Boost.Build projects
;;; @todo convert to ede or something
(with-eval-after-load "projectile"
  (defun tee3-projectile-boost-build-project-p ()
    "Check if a project contains Jamroot, project-root.jam, or jamroot.jam files."
    (or (projectile-verify-file "project-root.jam")
        (projectile-verify-file "Jamroot")
        (projectile-verify-file "jamroot.jam")))

  (projectile-register-project-type 'boost-build
                                    #'tee3-projectile-boost-build-project-p
                                    :compile "b2 variant=debug,release"
                                    :configure "b2 --reconfigure variant=debug,release"
                                    :run "b2 variant=debug,release"
                                    :src-dir "src"
                                    :test "b2 --verbose-test variant=debug,release"
                                    :test-dir "test"
                                    :test-prefix "test_"))

;;; Jam programming language
(use-package jam-mode
  :disabled ; @todo find an alternative package
  :ensure t
  :pin marmalade
  :demand t
  :preface
  (defun tee3-jam-mode-setup ()
    (setq indent-tabs-mode nil))
  :mode
  (("[Jj]amroot\\'" . jam-mode)
   ("[Jj]amfile\\'" . jam-mode)
   ("\\.jam\\'" . jam-mode))
  :init
  :hook
  (jam-mode . tee3-jam-mode-setup)
  :config
  (when tee3-display-line-numbers
    (if (>= emacs-major-version 26)
        (eval-after-load "display-line-numbers.el"
          (add-hook 'jam-mode-hook 'display-line-numbers-mode))
      (eval-after-load "linum.el"
        (add-hook 'jam-mode-hook 'linum-mode))))

  (eval-after-load "flyspell.el"
    (add-hook 'jam-mode-hook 'flyspell-prog-mode)))

;;; Xcode
;;; @todo convert to ede or something
(with-eval-after-load "projectile"
  (defun tee3-projectile-xcode-workspace-p ()
    "Check if a project contains an .xcworkspace directory."
    (projectile-verify-file-wildcard "*.xcworkspace"))
  (defun tee3-projectile-xcode-workspace-compile-command ()
    "Returns a compile command for the current workspace."
    (string-join (append '("xcodebuild" "-workspace") (file-expand-wildcards "*.xcworkspace")) " "))
  (defun tee3-projectile-xcode-workspace-test-command ()
    "Returns a compile command for the current workspace."
    (string-join (append '("xcodebuild" "-workspace") (file-expand-wildcards "*.xcworkspace")) " "))
  (defun tee3-projectile-xcode-workspace-run-command ()
    "Returns a compile command for the current workspace."
    (string-join (append '("xcodebuild" "-workspace") (file-expand-wildcards "*.xcworkspace")) " "))

  (projectile-register-project-type 'xcode-workspace
                                    #'tee3-projectile-xcode-workspace-p
                                    :compile 'tee3-projectile-xcode-workspace-compile-command
                                    :run 'tee3-projectile-xcode-workspace-run-command
                                    :test 'tee3-projectile-xcode-workspace-test-command))

;;; @todo convert to ede or something
(with-eval-after-load "projectile"
  (defun tee3-projectile-xcode-project-p ()
    "Check if a project contains an .xcodeproj directory."
    (projectile-verify-file-wildcard "*.xcodeproj"))
  (defun tee3-projectile-xcode-project-compile-command ()
    "Returns a compile command for the current project."
    (string-join (append '("xcodebuild" "-project") (file-expand-wildcards "*.xcodeproj")) " "))
  (defun tee3-projectile-xcode-project-test-command ()
    "Returns a compile command for the current project."
    (string-join (append '("xcodebuild" "-project") (file-expand-wildcards "*.xcodeproj")) " "))
  (defun tee3-projectile-xcode-project-run-command ()
    "Returns a compile command for the current project."
    (string-join (append '("xcodebuild" "-project") (file-expand-wildcards "*.xcodeproj")) " "))

    (projectile-register-project-type 'xcode-project
                                      #'tee3-projectile-xcode-project-p
                                      :compile 'tee3-projectile-xcode-project-compile-command
                                      :run 'tee3-projectile-xcode-project-run-command
                                      :test 'tee3-projectile-xcode-project-test-command))

;;; CMake
(use-package cmake-mode
  :ensure t
  :pin melpa)

;;; @todo convert to ede or something
(with-eval-after-load "projectile"
  (defun tee3-projectile-cmake-project-p ()
    "Check if a project contains an CMakeLists.txt file."
    (and (projectile-verify-file-wildcard "CMakeLists.txt")
         (not (tee3-projectile-boost-build-project-p))))

  (projectile-register-project-type 'cmake
                                    #'tee3-projectile-cmake-project-p
                                    :compile "cmake --build build -- -k -j 8"
                                    :configure "mkdir -p build && cd build && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .."
                                    :run "cmake --build build -- -k -j 8"
                                    :src-dir "src"
                                    :test "cmake --build build --target test -- -k -j 8"
                                    :test-dir "test"
                                    :test-prefix "test_"))

;;; Gnuplot
(use-package gnuplot-mode
  :ensure t
  :pin melpa
  :mode
  (("\\.gp\\'" . gnuplot-mode)))

;;; Go programming language
(use-package go-mode
  :ensure t
  :pin melpa
  :preface
  (defun tee3-go-mode-setup ()
    ;; allow use of tabs as it is required by go fmt
    (setq indent-tabs-mode t)
    (add-hook 'before-save-hook 'gofmt-before-save))
  :hook
  (go-mode . tee3-go-mode-setup))

;;; Ruby programming language
(use-package ruby-mode)

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
(use-package nxml-mode
  :mode
  (("\\.xml\\'" . nxml-mode)
   ("\\.xsl\\'" . nxml-mode)
   ("\\.xsd\\'" . nxml-mode)
   ("\\.rng\\'" . nxml-mode)
   ("\\.xhtml\\'" . nxml-mode)))

;;; DITA
(use-package nxml-mode
  :mode
  (("\\.dita\\'" . nxml-mode)
   ("\\.ditamap\\'" . nxml-mode)))

;;; DocBook
(use-package docbook
  :ensure t
  :pin gnu)
(use-package nxml-mode
  :mode
  (("\\.docbook\\'" . nxml-mode)))

;;; C-family programming languages
(use-package cc-mode
  :preface
  (defun tee3-c-mode-common-setup ()
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
  (defun tee3-c-set-style-tee3 ()
    (c-set-style "tee3"))
  :mode
  ("\\.cu\\'" . c++-mode)
  ("\\.cuh\\'" . c++-mode)
  :init
  (setq c-indent-comments-syntactically-p t)
  (setq c-strict-syntax-p t)
  :hook
  (c-mode . tee3-c-set-style-tee3)
  (c++-mode . tee3-c-set-style-tee3)
  (c-mode-common . tee3-c-mode-common-setup))
(use-package tee3-c-style
  :demand t ; @todo for now, this package needs work
  :load-path
  "~/opt/local/src/tee3-c-style")
(use-package msvc-c-style
  :demand t ; @todo for now, this package needs work
  :load-path
  "~/opt/local/src/msvc-c-style")
(use-package google-c-style
  :ensure t
  :pin melpa)
(use-package hideif
  :init
  (setq hide-ifdef-read-only t)
  (setq hide-ifdef-initially nil)
  (setq hide-ifdef-lines t)
  :hook
  (c-mode . hide-ifdef-mode)
  (c++-mode . hide-ifdef-mode))
(use-package demangle-mode
  :ensure t
  :pin melpa)

;;; JavaScript programming language
(use-package js)
(use-package js-comint
  :ensure t
  :pin melpa)
(use-package jsonnet-mode
  :ensure t
  :pin melpa)
(use-package jq-mode
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
  :config
  (if (= (call-process (executable-find python-shell-interpreter) nil nil nil "-c" "import sys; sys.exit(0 if sys.version_info.major >= 3 else 1") 1)
      (when (executable-find "python3")
        (setq python-shell-interpreter "python3")))

  (setq gud-pdb-command-name (format "%s -m pdb" python-shell-interpreter)))

(use-package pip-requirements
  :ensure t
  :pin melpa)

(use-package jupyter
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

;;; Linux
(use-package kconfig-mode
  :ensure t
  :pin melpa)
(use-package dts-mode
  :ensure t
  :pin melpa)

;;; Homebrew
(use-package homebrew-mode
  :if
  (or (>= emacs-major-version 25)
      (and (= emacs-major-version 24) (>= emacs-minor-version 4)))
  :ensure t
  :pin melpa
  :init
  (global-homebrew-mode))

;;; Clang Tools
(eval-after-load "yaml-mode.el"
  (add-to-list 'auto-mode-alist '(".clang-format\\'" . yaml-mode)))
(eval-after-load "yaml-mode.el"
  (add-to-list 'auto-mode-alist '(".clang-tidy\\'" . yaml-mode)))

;;; Flymake
(use-package flymake
  :ensure t
  :pin gnu
  :bind
  ("C-c ! l" . flymake-show-diagnostics-buffer)
  :hook
  (prog-mode . flymake-mode))
(use-package flymake-shellcheck
  :ensure t
  :pin melpa
  :after flymake
  :commands flymake-shellcheck-load
  :hook
  (sh-mode . flymake-shellcheck-load))

;;; Language Server Protocol
(defun tee3-clangd-executable ()
  (setq tee3-clangd-executable
        (cond ((executable-find "clangd"))
              ((equal system-type 'darwin)
               (cond ((executable-find "/usr/local/opt/llvm/bin/clangd"))
                     ((executable-find "/Library/Developer/CommandLineTools/usr/bin/clangd"))
                     ((executable-find "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clangd"))))
              ((equal system-type 'gnu/linux)
               (cond ((executable-find "/home/linuxbrew/.linuxbrew/opt/llvm/bin/clangd"))))
              (t
               ("clangd")))))

(setq tee3-clangd-options '("-j=2"
                            "--all-scopes-completion"
                            "--clang-tidy"
                            "--completion-style=detailed"
                            "--function-arg-placeholders"
                            "--header-insertion=iwyu"
                            "--limit-results=0"
                            "--suggest-missing-includes"))

(defun tee3-clangd-command (interactive)
  (append (list (tee3-clangd-executable)) tee3-clangd-options))

(defun tee3-sourcekit-lsp-executable ()
  (setq tee3-sourcekit-lsp-executable
        (cond ((executable-find "sourcekit-lsp"))
              ((equal system-type 'darwin)
               (cond ((executable-find "/usr/local/bin/sourcekit-lsp"))
                     ((executable-find "/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp"))
                     ((executable-find "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"))))
              ((equal system-type 'gnu/linux)
               (cond ((executable-find "/home/linuxbrew/.linuxbrew/bin/sourcekit-lsp"))))
              (t
               ("sourcekit-lsp")))))

(setq tee3-sourcekit-lsp-options '())

(defun tee3-sourcekit-lsp-command (interactive)
  (append (list (tee3-sourcekit-lsp-executable)) tee3-sourcekit-lsp-options))

(use-package eglot
  :ensure t
  :pin melpa
  :bind
  ("C-c l ." . eglot-find-implementation)
  ("C-c l a" . eglot-code-actions)
  ("C-c l b" . eglot-format-buffer)
  ("C-c l c" . eglot-reconnect)
  ("C-c l d" . eglot-find-declaration)
  ("C-c l f" . eglot-format)
  ("C-c l q" . eglot-shutdown)
  ("C-c l Q" . eglot-shutdown-all)
  ("C-c l r" . eglot-rename)
  ("C-c l s" . eglot)
  ("C-c l t" . eglot-find-typeDefinition)
  :hook
  (prog-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '((css-mode
                                         less-css-mode
                                         scss-mode) . ("css-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '((dockerfile-mode) . ("docker-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs '((html-mode) . ("html-languageserver" "--stdio")))
  (add-to-list 'eglot-server-programs '((vue-mode) . ("vls" "--stdio")))
  (add-to-list 'eglot-server-programs '((json-mode jsonc-mode) . ("vscode-json-languageserver" "--stdio")))
  (add-to-list 'eglot-server-programs '((c-mode
                                         c++-mode
                                         objc-mode
                                         objc++-mode) . tee3-clangd-command))
  (add-to-list 'eglot-server-programs '((sql-mode) . ("sql-language-server" "up" "--method" "stdio")))
  (add-to-list 'eglot-server-programs '((swift-mode) . tee3-sourcekit-lsp-command))
  (add-to-list 'eglot-server-programs '((yaml-mode) . ("yaml-language-server" "--stdio"))))

(use-package rmsbolt
  :ensure t
  :pin melpa)

;;; Docker
(use-package docker
  :if
  (>= emacs-major-version 25)
  :ensure t
  :pin melpa
  :bind
  ("C-c d" . docker))
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

;;; Kubernetes
(use-package kubernetes
  :if
  (>= emacs-major-version 25)
  :ensure t
  :pin melpa)

;;; Chef
(use-package chef-mode
  :ensure t
  :pin melpa)

;;; Terraform
(use-package terraform-mode
  :ensure t
  :pin melpa)

;;; Bitbake
(use-package bitbake
  :ensure t
  :pin melpa)

;;; Structure and Interpretation of Computer Programs (SICP)
(use-package sicp
  :ensure t
  :pin melpa)

;;; Themes
(when (or (>= emacs-major-version 25)
          (and (= emacs-major-version 24)
               (>= emacs-minor-version 5)))
  (use-package afternoon-theme :ensure t :pin melpa :defer t)
  (use-package ample-theme :ensure t :pin melpa :defer t)
  (use-package arjen-grey-theme :ensure t :pin melpa :defer t)
  (use-package atom-dark-theme :ensure t :pin melpa :defer t)
  (use-package autumn-light-theme :ensure t :pin melpa :defer t)
  (use-package badger-theme :ensure t :pin melpa :defer t)
  (use-package badwolf-theme :ensure t :pin melpa :defer t)
  (use-package basic-theme :ensure t :pin melpa :defer t)
  (use-package berrys-theme :ensure t :pin melpa :defer t)
  (use-package brutalist-theme :ensure t :pin melpa :defer t)
  (use-package bubbleberry-theme :ensure t :pin melpa :defer t)
  (use-package busybee-theme :ensure t :pin melpa :defer t)
  (use-package chocolate-theme :ensure t :pin melpa :defer t)
  (use-package cherry-blossom-theme :ensure t :pin melpa :defer t)
  (use-package chyla-theme :ensure t :pin melpa :defer t)
  (use-package cyberpunk-theme :ensure t :pin melpa :defer t)
  (use-package cyberpunk-2019-theme :ensure t :pin melpa :defer t)
  (use-package dakrone-theme :ensure t :pin melpa :defer t)
  (use-package darcula-theme :ensure t :pin melpa :defer t)
  (use-package darkburn-theme :ensure t :pin melpa :defer t)
  (use-package darktooth-theme :ensure t :pin melpa :defer t)
  (use-package distinguished-theme :ensure t :pin melpa :defer t)
  (use-package django-theme :ensure t :pin melpa :defer t)
  (use-package dracula-theme :ensure t :pin melpa :defer t)
  (use-package eclipse-theme :ensure t :pin melpa :defer t)
  (use-package eink-theme :ensure t :pin melpa :defer t)
  (use-package espresso-theme :ensure t :pin melpa :defer t)
  (use-package faff-theme :ensure t :pin melpa :defer t)
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
  (use-package gruvbox-theme :ensure t :pin melpa :defer t)
  (use-package hemisu-theme :ensure t :pin melpa :defer t)
  (use-package hemera-theme :ensure t :pin melpa :defer t)
  (use-package humanoid-themes :ensure t :pin melpa :defer t)
  (use-package inkpot-theme :ensure t :pin melpa :defer t)
  (use-package iodine-theme :ensure t :pin melpa :defer t)
  (use-package jazz-theme :ensure t :pin melpa :defer t)
  (use-package kaolin-themes :ensure t :pin melpa :defer t)
  (use-package lab-themes :ensure t :pin melpa :defer t)
  (use-package leuven-theme :ensure t :pin melpa :defer t)
  (use-package light-soap-theme :ensure t :pin melpa :defer t)
  (use-package majapahit-theme :ensure t :pin melpa :defer t)
  (use-package material-theme :ensure t :pin melpa :defer t)
  (use-package minimal-theme :ensure t :pin melpa :defer t)
  (use-package modus-themes
    :ensure t
    :pin gnu
    :defer t
    :init
    (setq modus-themes-diffs 'fg-only))
  (use-package moe-theme :ensure t :pin melpa :defer t)
  (use-package molokai-theme :ensure t :pin melpa :defer t)
  (use-package monochrome-theme :ensure t :pin melpa :defer t)
  (use-package monokai-theme :ensure t :pin melpa :defer t)
  (use-package monotropic-theme :ensure t :pin melpa :defer t)
  (use-package mustang-theme :ensure t :pin melpa :defer t)
  (use-package nimbus-theme :ensure t :pin melpa :defer t)
  (use-package nord-theme :ensure t :pin melpa :defer t)
  (use-package nordless-theme :ensure t :pin melpa :defer t)
  (use-package organic-green-theme :ensure t :pin melpa :defer t)
  (use-package paper-theme :ensure t :pin melpa :defer t)
  (use-package plan9-theme :ensure t :pin melpa :defer t)
  (use-package poet-theme :ensure t :pin melpa :defer t)
  (use-package professional-theme :ensure t :pin melpa :defer t)
  (use-package rebecca-theme :ensure t :pin melpa :defer t)
  (use-package solarized-theme :ensure t :pin melpa :defer t)
  (use-package solo-jazz-theme :ensure t :pin melpa :defer t)
  (use-package spacegray-theme :ensure t :pin melpa :defer t)
  (use-package spacemacs-theme :ensure t :pin melpa :defer t)
  (use-package subatomic-theme :ensure t :pin melpa :defer t)
  (use-package subatomic256-theme :ensure t :pin melpa :defer t)
  (use-package tao-theme :ensure t :pin melpa :defer t)
  (use-package termbright-theme :ensure t :pin melpa :defer t)
  (use-package tramp-theme :ensure t :pin gnu :defer t)
  (use-package ubuntu-theme :ensure t :pin melpa :defer t)
  (use-package underwater-theme :ensure t :pin melpa :defer t)
  (use-package unobtrusive-magit-theme :ensure t :pin melpa :defer t)
  (use-package waher-theme :ensure t :pin melpa :defer t)
  (use-package warm-night-theme :ensure t :pin melpa :defer t)
  (use-package white-sand-theme :ensure t :pin melpa :defer t)
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

;;; Start the emacs server (emacsserver/emacsclient)
(use-package server
  :demand t
  :preface
  (defun tee3-signal-restart-server ()
    (interactive)
    (message "Caught event %S" last-input-event)
    (server-mode))
  :config
  (define-key special-event-map [sigusr1] 'tee3-signal-restart-server)

  (unless (server-running-p)
    (server-start)))

;;; Load user- and machine-specific settings
(if (file-exists-p (expand-file-name "~/.emacs.machine.el"))
    (load-file (expand-file-name "~/.emacs.machine.el")))
(if (file-exists-p (expand-file-name "~/.emacs.user.el"))
    (load-file (expand-file-name "~/.emacs.user.el")))

(provide '.emacs)
;;; .emacs ends here
