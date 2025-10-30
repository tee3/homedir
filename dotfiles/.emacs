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
  (when (< emacs-major-version 28)
    (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t))
  (when (>= emacs-major-version 23)
    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

  (package-initialize))

;;; Bootstrap use-package
(setq-default use-package-always-defer t)

(setq-default use-package-enable-imenu-support t)

(setq-default use-package-compute-statistics nil)

(when (< emacs-major-version 29)
  (when (require 'package nil :noerror)
    (when (boundp 'package-pinned-packages)
      (setq package-pinned-packages
            '((use-package . "gnu"))))

    (when (not (package-installed-p 'use-package))

      (package-refresh-contents)

      (package-install 'use-package))))

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

;;; Emacs
(setq inhibit-startup-screen t)
(setq scroll-conservatively 100)
(setq-default truncate-lines t)
(setq visible-bell t)
(column-number-mode)
(setq use-short-answers t)
(setq read-minibuffer-restore-windows nil)
(setq mode-line-compact 'long)
(use-package time
  :demand t
  :init
  (setq display-time-day-and-date nil)
  :config
  (display-time-mode))
(setq split-height-threshold 0)
(use-package files
  :init
  (setq version-control t)
  :bind
  ("C-c x" . save-buffers-kill-emacs))

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(when (equal system-type 'darwin)
  (setq ns-pop-up-frames nil)

  (set-keyboard-coding-system nil))

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
  (setq epa-pinentry-mode 'loopback)
  (setq epa-keys-select-method 'minibuffer))
(use-package epg
  :init
  (setq epg-pinentry-mode 'loopback))

(use-package autoinsert
  :demand t
  :config
  (auto-insert-mode))
(use-package autorevert)
(use-package buff-menu
  :init
  (setq Buffer-menu-group-by '(Buffer-menu-group-by-root)))
(use-package bug-reference
  :hook
  (text-mode . bug-reference-mode)
  (prog-mode . bug-reference-prog-mode))
(use-package newcomment
  :init
  (setq comment-empty-lines t))
(use-package browse-url
  :init
  (setq browse-url-browser-function 'eww-browse-url)
  :bind
  ("C-c b b b" . browse-url))
(use-package comint
  :init
  (setq comint-prompt-read-only t)
  (setq comint-input-ignoredups t))
(use-package cus-edit
  :init
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  (load custom-file 'noerror))
(use-package abbrev)
(use-package calc
  :init
  (setq calc-make-windows-dedicated t))
(use-package compile
  :bind
  (("C-c c c" . compile)
   ("C-c c r" . recompile)))
(use-package desktop
  :demand t
  :preface
  (defun tee3-deferred-desktop-save-mode ()
    (when (not desktop-save-mode)
      (desktop-save-mode)
      (desktop-read)))
  (defun tee3-disable-themes ()
    (mapc 'disable-theme custom-enabled-themes))
  :init
  ;; @todo do not restore frames for now
  (setq desktop-restore-frames nil)
  (setq desktop-restore-in-current-display nil)
  (setq desktop-restore-forces-onscreen nil)
  (setq desktop-restore-reuses-frames nil)
  (setq desktop-load-locked-desktop 'check-pid)
  :config
  (add-to-list 'desktop-globals-to-save 'kill-ring)

  (if (not (daemonp))
      (desktop-save-mode))
  :hook
  ((server-after-make-frame . tee3-deferred-desktop-save-mode)
   (kill-emacs . tee3-disable-themes)))
(use-package dictionary
  :init
  (setq dictionary-search-interface 'help))
(use-package diff-hl
  :ensure t
  :pin gnu
  :config
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode)
  :hook
  (dired-mode . diff-hl-dired-mode-unless-remote))
(use-package diff-mode
  :init
  (setq diff-default-read-only t)
  (setq diff-font-lock-prettify t))
(use-package dired
  :init
  (setq dired-kept-versions 6)
  (setq dired-clean-up-buffers-too t)
  (setq dired-movement-style 'bounded)
  (setq dired-filename-display-length 'window))
(use-package dired-x
  :after dired)
(use-package ediff
  :init
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))
(unless (< emacs-major-version 30)
  (use-package editorconfig
    :config
    (editorconfig-mode)))
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
(use-package eshell)
(use-package em-term
  :init
  (setq eshell-destroy-buffer-when-process-dies t)
  :bind
  (("C-c s e s" . eshell)
   ("C-c s e c" . eshell-command))
  :config
  (add-to-list 'eshell-visual-commands "ssh" t)
  (add-to-list 'eshell-visual-commands "tig" t)
  (add-to-list 'eshell-visual-commands "watch" t)
  (add-to-list 'eshell-visual-subcommands '("git" "log" "diff" "show") t)
  (add-to-list 'eshell-visual-options '("git" "--help" "--paginate") t))
(use-package etags
  :init
  (setq tags-loop-revert-buffers t))
(use-package eww
  :init
  (setq eww-restore-desktop t)
  (setq eww-auto-rename-buffer 'title)
  (setq eww-history-limit 1000)
  :bind
  ("C-c b e b" . eww))
(use-package ffap)
(use-package font-core
  :demand t
  :config
  (global-font-lock-mode))
(use-package frame
  :disabled
  :demand t
  :config
  (add-to-list 'initial-frame-alist '(width . 160))
  (add-to-list 'initial-frame-alist '(height . 48))
  (if (member "Cascadia Code" (font-family-list))
      (add-to-list 'initial-frame-alist '(font . "Cascadia Code")))
  (if (member "Source Code Pro" (font-family-list))
      (add-to-list 'initial-frame-alist '(font . "Source Code Pro")))

  (add-to-list 'default-frame-alist '(width . 160))
  (add-to-list 'default-frame-alist '(height . 48))
  (if (member "Cascadia Code" (font-family-list))
      (add-to-list 'default-frame-alist '(font . "Cascadia Code")))
  (if (member "Source Code Pro" (font-family-list))
      (add-to-list 'default-frame-alist '(font . "Source Code Pro"))))
(use-package fringe
  :init
  (setq fringe-mode '(4 . nil)))
(use-package grep
  :init
  (setq grep-use-headings t))
(use-package help
  :config
  (temp-buffer-resize-mode))
(use-package hideshow
  :init
  (setq hs-hide-comments-when-hiding-all t))
(use-package icomplete
  :init
  (setq icomplete-in-buffer t)
  (setq icomplete-vertical-render-prefix-indicator t))
(use-package linum
  :if
  (and tee3-display-line-numbers
       (< emacs-major-version 26))
  :init
  (setq linum-format "%4d ")
  :hook
  ((text-mode . linum-mode)
   (prog-mode . linum-mode)))
(use-package display-line-numbers
  :if
  (and tee3-display-line-numbers
       (>= emacs-major-version 26))
  :init
  (setq display-line-numbers-grow-only t)
  (setq display-line-numbers-width-start 3)
  :hook
  ((text-mode . display-line-numbers-mode)
   (prog-mode . display-line-numbers-mode)))
(use-package gdb
  :init
  (setq gdb-restore-window-configuration-after-quit t))
(use-package gnus
  :init
  (setq gnus-init-file "~/.gnus")
  (setq gnus-home-directory user-emacs-directory)

  (setq gnus-save-newsrc-file nil)
  (setq gnus-read-newsrc-file nil)

  (setq gnus-asynchronous t)

  (setq gnus-use-cache t))
(use-package gud
  :init
  (setq gud-chdir-before-run nil)
  (setq gud-highlight-current-line t)
  ;; lldb
  (setq gud-lldb-max-completions 10000))
(use-package man
  :init
  (setq Man-support-remote-systems t))
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
  (setq completions-format 'one-column)
  (setq completions-detailed t)
  (setq completions-sort 'historical)
  (setq minibuffer-visible-completions t)
  (setq completion-category-overrides'((project-file
                                        (styles basic emacs22 partial-completion substring)))))
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
  :pin nongnu
  :hook
  ((emacs-lisp-mode . paredit-mode)
   (lisp-mode . paredit-mode)
   (scheme-mode . paredit-mode)))
(use-package paren
  :demand t
  :init
  (setq show-paren-context-when-offscreen t)
  :config
  (show-paren-mode))
(use-package pcomplete)
(use-package proced
  :init
  (setq proced-show-remote-processes t)
  (setq proced-enable-color-flag t))
(use-package project
  :ensure t
  :pin gnu
  :init
  (setq project-mode-line t)
  (setq project-switch-use-entire-map t)
  (setq project-switch-commands #'project-prefix-or-any-command)
  (setq project-compilation-buffer-name-function 'project-prefixed-buffer-name)
  (setq project-kill-buffers-display-buffer-list t))
(when (>= emacs-major-version 28)
  (use-package repeat
    :demand t
    :config
    (repeat-mode)))
(use-package savehist
  :demand t
  :init
  (setq history-length t)
  (setq history-delete-duplicates t)
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
(when (>= emacs-major-version 30)
  (use-package completion-preview
    :init
    (setq completion-preview-exact-match-only t)
    (setq completion-preview-minimum-symbol-length 2)
    :config
    (global-completion-preview-mode)))
(use-package shell
  :init
  (setq shell-get-old-input-include-continuation-lines t))
(use-package simple
  :init
  (setq size-indication-mode t)
  (setq kill-ring-max 1000)
  (setq kill-do-not-save-duplicates t)
  (setq save-interprogram-paste-before-kill t)
  (setq global-mark-ring-max 10000)
  (setq mark-ring-max 10000)
  (setq set-mark-command-repeat-pop t)
  (setq completion-auto-select 'second-tab)
  (setq completion-auto-help 'visible)
  (setq next-error-message-highlight 'keep)
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
(use-package tramp
  :ensure t
  :pin gnu)
(when (>= emacs-major-version 29)
  (use-package treesit
    :demand t
    :custom
    (treesit-enabled-modes t)))

(when (>= emacs-major-version 30)
  (use-package visual-wrap
    :config
    (global-visual-wrap-prefix-mode)))
(use-package which-func
  :demand t
  :config
  (which-function-mode))
(use-package winner
  :demand t
  :init
  (winner-mode))
(use-package windmove
  :demand t
  :init
  (setq windmove-wrap-around t)
  :config
  (windmove-default-keybindings)
  (windmove-display-default-keybindings)
  (windmove-delete-default-keybindings))
(use-package xref
  :ensure t
  :pin gnu
  :init
  (setq xref-show-definitions-function 'xref-show-definitions-completing-read))

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

;;; GNU ELPA suggestions
(use-package gnu-elpa
  :ensure t
  :pin gnu)

;;; VTerm
(use-package vterm
  :ensure t
  :pin melpa)

;;; Debbugs
(use-package debbugs
  :ensure t
  :pin gnu)

;;; Flyspell
(use-package flyspell
  :hook
  ((text-mode . flyspell-mode)
   (prog-mode . flyspell-prog-mode)))

;;; Yasnippet
(use-package yasnippet
  :ensure t
  :pin gnu
  :demand t
  :init
  (setq yas-alias-to-yas/prefix-p nil)
  :config
  (yas-global-mode))

;;; Org
(use-package org
  :ensure t
  :pin gnu)

;;; AI
(when (>= emacs-major-version 28)
  (use-package ellama
    :ensure t
    :pin gnu
    :demand t
    :init
    (setopt ellama-keymap-prefix "C-c a")))

;;; Markdown formats
(use-package adoc-mode
  :ensure t
  :pin melpa
  :mode
  ((".asciidoc\\'" . adoc-mode)
   (".adoc\\'" . adoc-mode)))
(use-package jade-mode
  :ensure t
  :pin nongnu)
(use-package markdown-mode
  :ensure t
  :pin nongnu
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

(use-package posix-manual
  :ensure t
  :pin melpa)

(use-package vdiff
  :ensure t
  :pin gnu
  :init
  (setq vdiff-auto-refine t))

;;; Configuration files
(use-package apache-mode
  :ensure t
  :pin nongnu)
(use-package csv-mode
  :ensure t
  :pin gnu
  :init
  (setq csv-align-style 'auto))
(use-package git-modes
  :ensure t
  :pin nongnu
  :mode
  (("\\.gitconfig.*\\'" . gitconfig-mode)

   ;; SubGit-generated Git submodules files
   ("\\.gitsvnextmodules\\'" . gitconfig-mode)
   ;; migration-generated Git submodules files
   ("\\.gitsvnexternals\\'" . gitconfig-mode)))
(use-package graphviz-dot-mode
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
  :pin nongnu)
(use-package protobuf-mode
  :ensure t
  :pin melpa)
(use-package flatbuffers-mode
  :ensure t
  :pin melpa)
(use-package ssh-agency
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
(when (or (> emacs-major-version 24)
          (and (= emacs-major-version 24) (>= emacs-minor-version 4)))
  (use-package systemd
    :ensure t
    :pin nongnu))
(when (and (>= emacs-major-version 25) (< emacs-major-version 30))
  (use-package toml-mode
    :ensure t
    :pin melpa))
(use-package vimrc-mode
  :ensure t
  :pin melpa)
(when (< emacs-major-version 30)
  (use-package yaml-mode
    :ensure t
    :pin nongnu))
(use-package graphql-mode
  :ensure t
  :pin nongnu)

;;; Programming languages
(use-package applescript-mode
  :disabled
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
  :pin nongnu)
(use-package cperl-mode
  :ensure t
  :pin melpa)
(use-package d-mode
  :ensure t
  :pin nongnu)
(use-package fish-mode
  :ensure t
  :pin melpa)
(use-package groovy-mode
  :ensure t
  :pin melpa)
(use-package haskell-mode
  :ensure t
  :pin nongnu)
(use-package lua-mode
  :ensure t
  :pin nongnu)
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
(use-package sed-mode
  :ensure t
  :pin gnu)
(use-package sql
  :init
  (setq sql-sqlite-program "sqlite3"))
(when (< emacs-major-version 30)
  (use-package rust-mode
    :ensure t
    :pin nongnu))
(when (or (>= emacs-major-version 25)
          (and (= emacs-major-version 24) (>= emacs-minor-version 4)))
  (use-package swift-mode
    :ensure t
    :pin nongnu))
(use-package tcl)
(use-package verilog-mode
  :ensure t
  :pin gnu)
(use-package vhdl-mode)
(use-package web-mode
  :ensure t
  :pin nongnu
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
  :pin gnu)

;;; OpenCL
(use-package opencl-c-mode
  :ensure t
  :pin melpa
  :mode (("\\.cl\\'" . opencl-c-mode)))

;;; OpenGL
(use-package glsl-mode
  :ensure t
  :pin melpa)

;;; GNU Global
(when (>= emacs-major-version 28)
  (use-package gtags-mode
    :ensure t
    :pin gnu
    :config
    (gtags-mode)))

;;; GNU Poke
(use-package poke-mode
  :ensure t
  :pin gnu)

;;; Scheme programming language
(use-package scheme
  :mode
  (("\\.guile\\'" . scheme-mode)))
(use-package geiser
  :ensure t
  :pin nongnu
  :init
  (setq geiser-mode-start-repl-p t)

  (setq geiser-repl-per-project-p t))
(use-package geiser-guile
  :ensure t
  :pin nongnu
  :after geiser)
(use-package geiser-mit
  :ensure t
  :pin nongnu
  :after geiser)

(use-package crdt
  :ensure t
  :pin gnu)

;;; Version Control Systems
(use-package vc
  :init
  (setq vc-allow-rewriting-published-history 'ask)
  (setq vc-make-backup-files t)

  (setq vc-command-messages t)

  (setq vc-display-status 'no-backend)
  (setq vc-diff-added-files t)

  (setq vc-use-incoming-outgoing-prefixes t)
  :bind
  ("C-c v v c" . vc-clone)
  ("C-c v v d" . vc-dir)
  ("C-c v v e" . vc-ediff)
  ("C-c v v s" . vc-git-stash)
  ("C-c v v w" . vc-prepare-patch)
  ("C-c v v v e" . vc-version-ediff)
  ("C-c v v v =" . vc-version-diff)
  ("C-c v v l s" . vc-log-search))
(use-package vc-git
  :init
  (setq vc-git-diff-switches '("--stat" "--stat-width=1024" "--minimal"))
  (setq vc-git-print-log-follow t)
  (setq vc-git-log-switches '("--decorate" "--stat" "--stat-width=1024" "--minimal"))
  (setq vc-git-annotate-switches '("--ignore-all-space")))
(use-package vc-fossil
  :ensure t
  :pin nongnu
  :after vc)

;;; Imenu
(use-package imenu
  :init
  (setq imenu-flatten 'annotation))

;;; Git
(use-package gited
  :ensure t
  :pin gnu
  :demand t
  :init
  (setq gited-verbose t)
  :config
  (define-key dired-mode-map "\C-x\C-g" 'gited-list-branches))

;;; Gitolite
(use-package gl-conf-mode
  :ensure t
  :pin melpa
  :mode
  (("gitolite\\.conf\\'" . gl-conf-mode)))

;;; Magit
(when (> emacs-major-version 24)
  (use-package magit
    :ensure t
    :pin nongnu
    :bind
    ("C-c v g s" . magit-status)
    :init
    (setq magit-repository-directories (quote (("~/Development" . 2))))))
;;; Forge
(when (> emacs-major-version 24)
  (use-package forge
    ;; @todo disabled until part of NonGNU ELPA
    :disabled
    :ensure t
    :pin nongnu))

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

(use-package why-this
  :ensure t
  :pin nongnu
  :init
  (setq why-this-annotate-enable-heat-map nil)
  :config
  (global-why-this-mode))

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
(with-eval-after-load 'projectile
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

;;; b2 (Boost.Build)
(use-package b2-mode
  :demand t ; @todo for now, this package needs work
  :vc
  (:url "https://github.com/tee3/b2-mode.git"))

;;; Xcode
;;; @todo convert to ede or something
(with-eval-after-load 'projectile
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
(with-eval-after-load 'projectile
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
(when (< emacs-major-version 30)
  (use-package cmake-mode
    :ensure t
    :pin melpa))

;;; @todo convert to ede or something
(with-eval-after-load 'projectile
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
(use-package gnuplot
  :ensure t
  :pin nongnu
  :mode
  (("\\.gp\\'" . gnuplot)))

;;; Go programming language
(when (< emacs-major-version 30)
  (use-package go-mode
    :ensure t
    :pin nongnu
    :preface
    (defun tee3-go-mode-setup ()
      ;; allow use of tabs as it is required by go fmt
      (setq indent-tabs-mode t)
      (add-hook 'before-save-hook 'gofmt-before-save))
    :hook
    (go-mode . tee3-go-mode-setup)))

;;; Ruby programming language
(use-package ruby-mode)

;;; Objective-J programming language
(use-package objj-mode
  :if
  (>= emacs-major-version 25)
  :vc
  (:url "https://github.com/tee3/objj-mode.git"))

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
    (c-add-style "tee3" tee3-c-style t)
    (c-add-style "msvc" msvc-c-style t)

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
  ((c-mode . tee3-c-set-style-tee3)
   (c++-mode . tee3-c-set-style-tee3)
   (c-mode-common . tee3-c-mode-common-setup)))
(use-package tee3-c-style
  :demand t ; @todo for now, this package needs work
  :vc
  (:url "https://github.com/tee3/tee3-c-style.git"))
(use-package msvc-c-style
  :demand t ; @todo for now, this package needs work
  :vc
  (:url "https://github.com/tee3/msvc-c-style.git"))
(use-package google-c-style
  :ensure t
  :pin melpa)
(use-package hideif
  :init
  (setq hide-ifdef-read-only t)
  (setq hide-ifdef-initially nil)
  (setq hide-ifdef-lines t)
  :hook
  ((c-mode . hide-ifdef-mode)
   (c++-mode . hide-ifdef-mode)))
(use-package demangle-mode
  :ensure t
  :pin melpa)

;;; JavaScript programming language
(use-package js)
(use-package js-comint
  :ensure t
  :pin melpa)
(use-package jq-mode
  :ensure t
  :pin melpa)

;;; JSON
(when (< emacs-major-version 29)
  (use-package json-mode
    :ensure t
    :pin gnu))
(use-package jsonnet-mode
  :ensure t
  :pin melpa)

;;; Typescript programming language
(when (< emacs-major-version 30)
  (use-package typescript-mode
    :ensure t
    :pin nongnu)
  (use-package ts-comint
    :ensure t
    :pin melpa))

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

;;; Julia
(use-package julia-mode
  :ensure t
  :pin nongnu)

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
(when (< emacs-major-version 29)
  (use-package dts-mode
    :ensure t
    :pin gnu))
(when (>= emacs-major-version 29)
  (use-package devicetree-ts-mode
    :ensure t
    :pin gnu))

;;; Clang Tools
(eval-after-load 'yaml-ts-mode
  '(add-to-list 'auto-mode-alist '(".clang-format\\'" . yaml-ts-mode)))
(eval-after-load 'yaml-ts-mode
  '(add-to-list 'auto-mode-alist '(".clang-tidy\\'" . yaml-ts-mode)))
(eval-after-load 'yaml-ts-mode
  '(add-to-list 'auto-mode-alist '(".clangd\\'" . yaml-ts-mode)))

;;; Flymake
(use-package flymake
  :ensure t
  :pin gnu
  :init
  (setq flymake-show-diagnostics-at-end-of-line t)
  :bind
  (("C-c e b" . flymake-switch-to-log-buffer)
   ("C-c e l l" . flymake-show-diagnostic)
   ("C-c e l b" . flymake-show-buffer-diagnostics)
   ("C-c e l p" . flymake-show-project-diagnostics)
   ("C-c e n" . flymake-goto-next-error)
   ("C-c e p" . flymake-goto-prev-error)
   ("C-c e s b" . flymake-running-backends)
   ("C-c e s d" . flymake-disabled-backends)
   ("C-c e s r" . flymake-reporting-backends))
  :hook
  (prog-mode . flymake-mode))
(when (< emacs-major-version 29)
  (use-package flymake-shellcheck
    :ensure t
    :pin melpa
    :after flymake
    :commands flymake-shellcheck-load
    :hook
    (sh-mode . flymake-shellcheck-load)))

;;; Language Server Protocol
(use-package eglot
  :ensure t
  :pin gnu
  :bind
  (("C-c l ." . eglot-find-implementation)
   ("C-c l a" . eglot-code-actions)
   ("C-c l b" . eglot-format-buffer)
   ("C-c l c" . eglot-reconnect)
   ("C-c l d" . eglot-find-declaration)
   ("C-c l f" . eglot-format)
   ("C-c l i" . eglot-inlay-hints-mode)
   ("C-c l l" . eglot-list-connections)
   ("C-c l q" . eglot-shutdown)
   ("C-c l Q" . eglot-shutdown-all)
   ("C-c l r" . eglot-rename)
   ("C-c l s" . eglot)
   ("C-c l t" . eglot-find-typeDefinition)
   ("C-c l w" . eglot-show-workspace-configuration))
  :init
  (setq-default eglot-ignored-server-capabilities
                '(:documentOnTypeFormattingProvider))
  (setq-default eglot-workspace-configuration
                '((:pylsp .
                   (:plugins
                    (:flake8 (:enabled t :extendIgnore ["E501"])
                     :mypy (:enabled t :strict t :report_progress t)
                     :pycodestyle (:enabled t :ignore ["E501"])
                     :pydocstyle (:enabled t)
                     :pylint (:enabled t))))))
  :config
  (add-to-list 'eglot-server-programs '((dockerfile-ts-mode dockerfile-mode) . ("docker-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs '((docker-compose-mode) . ("docker-compose-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs '((graphql-mode) . ("npx" "graphql-language-service-cli" "server" "--method" "stream")))
  (add-to-list 'eglot-server-programs '((groovy-mode) . ("java" "-jar" (expand-file-name "~/opt/local/src/groovy-language-server/build/libs/groovy-language-server-all.jar"))))
  (add-to-list 'eglot-server-programs '((hcl-mode terraform-mode) . ("terraform-ls")))
  (add-to-list 'eglot-server-programs '((jq-ts-mode jq-mode) . ("jq-lsp")))
  (add-to-list 'eglot-server-programs '((protobuf-mode) . ("go" "run" "github.com/lasorda/protobuf-language-server@master")))
  (add-to-list 'eglot-server-programs '((vue-mode) . ("vue-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs '((swift-mode) . ("sourcekit-lsp"))))

(when (>= emacs-major-version 28)
  (use-package breadcrumb
    :ensure t
    :pin gnu
    :commands
    breadcrumb-mode
    breadcrumb-jump
    :bind
    (("C-c l j" . breadcrumb-jump))
    :config
    (breadcrumb-mode)))

(use-package rmsbolt
  :ensure t
  :pin melpa)

;;; Jenkins
(use-package jenkinsfile-mode
  :ensure t
  :pin melpa
  :mode
  ("Jenkinsfile.*\\'" . jenkinsfile-mode))

;;; Docker
(when (>= emacs-major-version 25)
  (use-package docker
    :ensure t
    :pin melpa
    :bind
    ("C-c d" . docker)))
(when (and (>= emacs-major-version 25) (< emacs-major-version 30))
  (use-package dockerfile-mode
    :ensure t
    :pin nongnu))
(when (>= emacs-major-version 25)
  (use-package docker-compose-mode
    :ensure t
    :pin melpa))

;;; Kubernetes
(when (>= emacs-major-version 25)
  (use-package kubernetes
    :ensure t
    :pin melpa))
(use-package kubedoc
  :ensure t
  :pin melpa)
(use-package k8s-mode
  :ensure t
  :pin melpa
  :hook (k8s-mode . yas-minor-mode))

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

;;; DevDocs
(use-package devdocs
  :ensure t
  :pin gnu)

;;; Themes
(when (or (>= emacs-major-version 25)
          (and (= emacs-major-version 24)
               (>= emacs-minor-version 5)))
  (use-package acme-theme :ensure t :pin melpa :defer t)
  (use-package aircon-theme :ensure t :pin gnu :defer t)
  (use-package chyla-theme :ensure t :pin melpa :defer t)
  (use-package cyberpunk-theme :ensure t :pin nongnu :defer t)
  (use-package cyberpunk-2019-theme :ensure t :pin melpa :defer t)
  (use-package dracula-theme :ensure t :pin nongnu :defer t)
  (use-package ef-themes :ensure t :pin gnu :defer t)
  (use-package gandalf-theme :ensure t :pin melpa :defer t)
  (use-package grandshell-theme :ensure t :pin melpa :defer t)
  (use-package hemera-theme :ensure t :pin melpa :defer t)
  ;; (use-package material-theme :ensure t :pin nongnu :defer t)
  (use-package material-theme :ensure t :pin melpa :defer t)
  (use-package modus-themes :ensure t :pin gnu :defer t)
  (use-package monotropic-theme :ensure t :pin melpa :defer t)
  (use-package plan9-theme :ensure t :pin melpa :defer t)
  (use-package professional-theme :ensure t :pin melpa :defer t)
  (use-package solarized-theme :ensure t :pin melpa :defer t)
  (use-package solo-jazz-theme :ensure t :pin melpa :defer t)
  (use-package standard-themes :ensure t :pin gnu :defer t)
  (use-package subatomic-theme :ensure t :pin nongnu :defer t)
  (use-package subatomic256-theme :ensure t :pin melpa :defer t)
  (use-package the-matrix-theme :ensure t :pin melpa :defer t)
  (use-package tramp-theme :ensure t :pin gnu :defer t)
  (use-package unobtrusive-magit-theme :ensure t :pin melpa :defer t)

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

  (unless (or (server-running-p)
              (daemonp))
    (server-start)))

;;; Load user- and machine-specific settings
(if (file-exists-p (expand-file-name "~/.emacs.machine.el"))
    (load-file (expand-file-name "~/.emacs.machine.el")))
(if (file-exists-p (expand-file-name "~/.emacs.user.el"))
    (load-file (expand-file-name "~/.emacs.user.el")))

(provide '.emacs)
;;; .emacs ends here
