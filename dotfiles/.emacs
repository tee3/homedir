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
(add-to-list 'load-path (expand-file-name "/usr/local/share/emacs/site-lisp") t)

;;;
;;; Custom Parameters
;;;
;;;    This is the way to set defaults since this is the variable set
;;;    by the configuration menus in Emacs itself.
;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Info-additional-directory-list (quote ("/usr/local/share/info")))
 '(auto-compression-mode t nil (jka-compr))
 '(c-indent-comments-syntactically-p t)
 '(c-macro-shrink-window-flag t)
 '(c-strict-syntax-p t)
 '(calculator-bind-escape t)
 '(calculator-electric-mode nil)
 '(column-number-mode t)
 '(compilation-scroll-output t)
 '(compile-auto-highlight t)
 '(current-language-environment "English")
 '(desktop-globals-to-save (quote (desktop-missing-file-warning tags-file-name tags-table-list search-ring regexp-search-ring register-alist file-name-history kill-ring)))
 '(desktop-save-mode t)
 '(dired-kept-versions 6)
 '(display-time-mode t)
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(flycheck-swift-executable "xcrun swift")
 '(fringe-mode 4 nil (fringe))
 '(generic-define-mswindows-modes t)
 '(global-cwarn-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(gnus-select-method (quote (nntp "news.gmane.org")))
 '(grep-command nil)
 '(gud-pdb-command-name "python -m pdb")
 '(hide-ifdef-lines t)
 '(history-delete-duplicates t)
 '(icomplete-mode t)
 '(inferior-js-program-command "v8 --shell")
 '(inferior-octave-startup-args (quote ("--traditional")))
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold nil)
 '(linum-format "%4d ")
 '(load-home-init-file t t)
 '(matlab-shell-command-switches "-nodesktop")
 '(matlab-shell-mode-hook nil)
 '(menu-bar-mode nil)
 '(mouse-wheel-mode t)
 '(ns-pop-up-frames nil)
 '(octave-auto-indent t)
 '(octave-auto-newline t)
 '(octave-block-offset 3)
 '(octave-continuation-offset 3)
 '(paren-mode (quote sexp) nil (paren))
 '(partial-completion-mode t)
 '(projectile-switch-project-action (quote projectile-dired))
 '(query-user-mail-address nil)
 '(rst-compile-toolsets
   (quote
    ((html "rst2html.py" ".html" "--verbose --strict --date --time")
     (latex "rst2latex.py" ".tex" "--verbose --strict --date --time")
     (newlatex "rst2newlatex.py" ".tex" "--verbose --strict --date --time")
     (pseudoxml "rst2pseudoxml.py" ".xml" "--verbose --strict --date --time")
     (xml "rst2xml.py" ".xml" "--verbose --strict --date --time")
     (pdf "rst2pdf.py" ".pdf" "--verbose --strict --date --time")
     (s5 "rst2s5.py" ".html" "--verbose --strict --date --time"))))
 '(save-place t nil (saveplace))
 '(savehist-mode t nil (savehist))
 '(scroll-bar-mode nil)
 '(scroll-conservatively 100)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(speedbar-use-images nil)
 '(split-height-threshold 0)
 '(sql-sqlite-program "sqlite3")
 '(tags-loop-revert-buffers t)
 '(tcl-application "tclsh")
 '(tcl-auto-newline nil)
 '(tempo-interactive t)
 '(text-mode-hook
   (quote
    (turn-on-flyspell turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(truncate-lines t)
 '(vc-directory-exclusion-list (quote ("SCCS" "RCS" "CVS" ".svn" "_MTN")))
 '(vc-dired-terse-display nil)
 '(vc-make-backup-files t)
 '(version-control t)
 '(visible-bell t)
 '(whitespace-check-indent-whitespace t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;
;;; Set up package
;;;
(when (and (>= emacs-major-version 24)
	   (require 'package nil :noerror))

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
;;; @todo replace use-package with nothingness?
(when (and (require 'package nil :noerror)
           (>= emacs-major-version 24)
           (not (package-installed-p 'use-package)))
  (package-install 'use-package))

(require 'use-package)

;;; Markdown formats
(use-package adoc-mode
  :ensure t
  :defer t)
(use-package creole-mode
  :ensure t
  :defer t)
(use-package jade-mode
  :ensure t
  :defer t)
(use-package markup-faces
  :ensure t
  :defer t)
(use-package pandoc-mode
  :ensure t
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

;;; Configuration files
(use-package apache-mode
  :ensure t
  :defer t)
(use-package crontab-mode
  :ensure t
  :defer t)
(use-package dockerfile-mode
  :ensure t
  :defer t)
(use-package nginx-mode
  :ensure t
  :defer t)
(use-package ninja-mode
  :ensure t
  :defer t)
(use-package osx-plist
  :ensure t
  :defer t)
(use-package syslog-mode
  :ensure t
  :defer t)
(use-package toml-mode
  :ensure t
  :defer t)
(use-package yaml-mode
  :ensure t
  :defer t)

;;; Programming languages
(use-package applescript-mode
  :ensure t
  :defer t)
(use-package dot-mode
  :ensure t
  :defer t)
(use-package graphviz-dot-mode
  :ensure t
  :defer t)
(use-package haskell-mode
  :ensure t
  :defer t)
(use-package jgraph-mode
  :ensure t
  :defer t)
(use-package lua-mode
  :ensure t
  :defer t)
(use-package pov-mode
  :ensure t
  :defer t)
(use-package tidy
  :ensure t
  :defer t)
(use-package web-mode
  :ensure t
  :defer t)

;;; TeX and LaTeX
(use-package tex-site
  :ensure auctex
  :defer t)

;;; C-family programming language
(use-package c-eldoc
  :ensure t
  :defer t)
(use-package cppcheck
  :ensure t
  :defer t)
(use-package cuda-mode
  :ensure t
  :defer t)
(use-package demangle-mode
  :ensure t
  :defer t)
(use-package disaster
  :ensure t
  :defer t)
(use-package dummy-h-mode
  :ensure t
  :defer t)
(use-package glsl-mode
  :ensure t
  :defer t)
(use-package google-c-style
  :ensure t
  :defer t)
(use-package hide-comnt
  :ensure t
  :defer t)
(use-package irony
  :ensure t
  :defer t)
(use-package irony-eldoc
  :ensure t
  :defer t)
(use-package objc-font-lock
  :ensure t
  :defer t)
(use-package malinka
  :ensure t
  :defer t)

;;; Perl programming language
(use-package cperl-mode
  :ensure t
  :defer t)

;;; File formats
(use-package csv-mode
  :ensure t
  :defer t)
(use-package irfc
  :ensure t
  :defer t)

;;; Tags
(use-package ctags
  :ensure t
  :defer t)
(use-package ctags-update
  :ensure t
  :defer t)
(use-package gtags
  :ensure t
  :defer t)

;;; D programming language
(use-package d-mode
  :ensure t
  :defer t)

;;; Emacs
(use-package darkroom
  :ensure t
  :defer t)
(use-package dedicated
  :ensure t
  :defer t)
(use-package electric-case
  :ensure t
  :defer t)
(use-package fm
  :ensure t
  :defer t)
(use-package nav
  :ensure t
  :defer t)
(use-package nav-flash
  :ensure t
  :defer t)
(use-package nlinum
  :ensure t
  :defer t)
(use-package persistent-soft
  :ensure t
  :defer t)
(use-package popup
  :ensure t
  :defer t)
(use-package pos-tip
  :ensure t
  :defer t)
(use-package smooth-scroll
  :ensure t
  :defer t)
(use-package sublimity
  :ensure t
  :defer t)
(use-package sws-mode
  :ensure t
  :defer t)
(use-package textmate
  :ensure t
  :defer t)
(use-package undo-tree
  :ensure t
  :defer t)
(use-package writeroom-mode
  :ensure t
  :defer t)

;;; Evil (vi) emulation
(use-package evil
  :ensure t
  :defer t)

;;; Diffs
(use-package diff-hl
  :ensure t
  :defer t)

;;; Emacs dired
(use-package dired+
  :ensure t
  :defer t)
(use-package dired-details
  :ensure t
  :defer t)
(use-package dired-details+
  :ensure t
  :defer t)
(use-package dired-rainbow
  :ensure t
  :defer t)
(use-package dired-single
  :ensure t
  :defer t)

;;; Windows support
(use-package dos
  :ensure t
  :defer t)
(use-package ntcmd
  :ensure t
  :defer t)
(use-package powershell
  :ensure t
  :defer t)

;;; Revision control
(use-package find-file-in-repository
  :ensure t
  :defer t)
(use-package ibuffer-vc
  :ensure t
  :defer t)

;;; Fish shell programming
(use-package fish-mode
  :ensure t
  :defer t)

;;; Flyspell
(use-package flyspell-lazy
  :ensure t
  :defer t)

;;; Scheme programming language
(use-package geiser
  :ensure t
  :defer t)

;;; TRAMP
(use-package ibuffer-tramp
  :ensure t
  :defer t)

;;; Google
(use-package google-this
  :ensure t
  :defer t)

;;; Learning Emacs
(use-package guru-mode
  :ensure t
  :defer t)
(use-package vimgolf
  :ensure t
  :defer t)

;;; Programming
(use-package howdoi
  :ensure t
  :defer t)

;;; Occur
(use-package ioccur
  :ensure t
  :defer t)
(use-package noccur
  :ensure t
  :defer t)

;;; Mercurial
(use-package monky
  :ensure t
  :defer t)

;;; Org
(use-package org
  :ensure t
  :defer t)

;;; Perforce
(use-package p4
  :ensure t
  :defer t)

;;; Processing programming language
(use-package processing-mode
  :ensure t
  :defer t)
(use-package processing-snippets
  :ensure t
  :defer t)

;;; Protobuf
(use-package protobuf-mode
  :ensure t
  :defer t)

;;; Subversion
(use-package psvn
  :ensure t
  :defer t)

;;; SSH
(use-package ssh
  :ensure t
  :defer t)

;;; Writing
(use-package synonyms
  :ensure t
  :defer t)
(use-package thesaurus
  :ensure t
  :defer t)

;;; Microsoft Team Foundation Server
(use-package tfs
  :ensure t
  :defer t)
(use-package vc-tfs
  :ensure t
  :defer t)

;;; Fossil
(use-package vc-fossil
  :ensure t
  :defer t)

;;;
;;; Ido
;;;
(use-package ido-ubiquitous
  :ensure t
  :defer t)

(when (require 'ido nil :noerror)
  ;; (ido-mode (quote both) nil (ido))
  (ido-mode t)
  (ido-everywhere)

  (setq ido-use-filename-at-point 'guess)
  (setq ido-use-url-at-point t)
  (setq ido-confirm-unique-completion t)

  (when (require 'ido-ubiquitous nil :noerror)
    (ido-ubiquitous-mode t)
    )
  )

;;;
;;; vimrc
;;;
(use-package vimrc-mode
  :ensure t
  :defer t)

;;;
;;; Make
;;;
(when (require 'make-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("Makefile.*\\'" . makefile-mode))

  (add-hook 'makefile-mode-hook (lambda ()
                                  (setq indent-tabs-mode t))))

;;;
;;; Boost.Build programming language
;;;
;;; @todo no official support for this yet

;;;
;;; Jam programming language
;;;
(use-package jam-mode
  :ensure t)

(when (require 'jam-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("[Jj]amroot\\'" . jam-mode))
  (add-to-list 'auto-mode-alist '("[Jj]amfile\\'" . jam-mode))
  (add-to-list 'auto-mode-alist '("\\.jam\\'" . jam-mode))

  (add-hook 'jam-mode-hook (lambda ()
                             (setq indent-tabs-mode nil)))
  (add-hook 'jam-mode-hook (lambda ()
                             (linum-mode 1)))
  (add-hook 'jam-mode-hook 'flyspell-prog-mode))

;;;
;;; CMake
;;;
(use-package cmake-mode
  :ensure t
  :defer t)
(use-package cmake-font-lock
  :ensure t
  :defer t)
(use-package cmake-project
  :ensure t
  :defer t)
(use-package cpputils-cmake
  :ensure t
  :defer t)

(when (require 'cmake-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
  (add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode)))

;;;
;;; Gnuplot
;;;
(use-package gnuplot
  :ensure t
  :defer t)
(use-package gnuplot-mode
  :ensure t
  :defer t)

(when (require 'gnuplot-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.gp\\'" . gnuplot-mode)))

;;;
;;; Go programming language
;;;
(use-package go-mode
  :ensure t
  :defer t)
(use-package company-go
  :ensure t
  :defer t)
(use-package go-autocomplete
  :ensure t
  :defer t)
(use-package go-direx
  :ensure t
  :defer t)
(use-package go-eldoc
  :ensure t
  :defer t)
(use-package go-errcheck
  :ensure t
  :defer t)
(use-package go-play
  :ensure t
  :defer t)
(use-package go-projectile
  :ensure t
  :defer t)
(use-package go-snippets
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

(when (require 'go-mode nil :noerror)
  (when (require 'go-eldoc nil :noerror)
    (add-hook 'go-mode-hook 'go-eldoc-setup))

  (add-hook 'go-mode-hook (lambda ()
                            ;; allow use of tags as it is required by go fmt
			    (setq indent-tabs-mode t)

                            ;; format before save
                            (add-hook 'before-save-hook 'gofmt-before-save)))
  nil)

;;;
;;; Swift programming language
;;;
(use-package swift-mode
  :disabled t
  :ensure t
  :defer t)

;;;
;;; MATLAB
;;;
(use-package matlab-mode
  :ensure t
  :defer t)

(when (require 'matlab nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode)))

;;;
;;; GNU Octave
;;;
(when (require 'octave-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode)))

;;;
;;; PHP programming language
;;;
(when (require 'php-mode nil :noerror)
  )

;;;
;;; Ruby programming language
;;;
(use-package company-inf-ruby
  :ensure t
  :defer t)
(use-package inf-ruby
  :ensure t
  :defer t)
(use-package rbenv
  :ensure t
  :defer t)
(use-package rspec-mode
  :ensure t
  :defer t)
(use-package ruby-compilation
  :ensure t
  :defer t)
(use-package ruby-electric
  :ensure t
  :defer t)
(use-package ruby-mode
  :ensure t
  :defer t)
(use-package bundler
  :ensure t
  :defer t)

(when (require 'ruby-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("[Rr]akefile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode)))

;;;
;;; JSON
;;;
(use-package json-mode
  :ensure t
  :defer t)

(when (require 'json-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode)))

;;;
;;; Objective-J programming language
;;;
(when (require 'objj-mode nil :noerror)
  (require 'compile)

  (add-to-list 'compilation-error-regexp-alist-alist
               '(objj-acorn "^\\(WARNING\\|ERROR\\) line \\([0-9]+\\) in file:\\([^:]+\\):\\(.*\\)$" 3 2))
  (add-to-list 'compilation-error-regexp-alist 'objj-acorn)
  (load-library "objj-mode")
  (add-to-list 'auto-mode-alist '("\\.j\\'" . objj-mode))

  (when (require 'js-mode nil :noerror)

    (add-to-list 'auto-mode-alist '("\\.sj\\'" . js-mode))))

;;;
;;; Jake
;;;
(when (require 'js-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("[Jj]akefile.*\\'" . js-mode))
  (add-to-list 'auto-mode-alist '("\\.jake\\'" . js-mode)))

;;;
;;; C# programming language
;;;
(use-package csharp-mode
  :disabled t
  :ensure t
  :defer t)
(use-package omnisharp
  :disabled t
  :ensure t
  :defer t)

;;;
;;; XML
;;;
(when (require 'nxml nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.xml\\'" . nxml-mode))
  (add-to-list 'auto-mode-alist '("\\.xsl\\'" . nxml-mode))
  (add-to-list 'auto-mode-alist '("\\.xsd\\'" . nxml-mode))
  (add-to-list 'auto-mode-alist '("\\.rng\\'" . nxml-mode))
  (add-to-list 'auto-mode-alist '("\\.xhtml\\'" . nxml-mode)))

;;;
;;; DITA
;;;
(when (require 'nxml nil :noerror)
  (add-to-list 'auto-mode-alist '("\\.dita\\'" . nxml-mode))
  (add-to-list 'auto-mode-alist '("\\.ditamap\\'" . nxml-mode)))

;;;
;;; DocBook
;;;
(use-package docbook
  :ensure t
  :defer t)

(when (require 'nxml nil :noerror)
  (add-to-list 'auto-mode-alist '("\\.docbook\\'" . nxml-mode)))

;;;
;;; SSH
;;;
(use-package ssh-config-mode
  :ensure t
  :defer t)

(when (require 'ssh-config-mode nil :noerror)

  (add-to-list 'auto-mode-alist '(".ssh/config\\'"  . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("sshd?_config\\'" . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("known_hosts\\'"  . ssh-known-hosts-mode))
  (add-to-list 'auto-mode-alist '("authorized_keys2?\\'" . ssh-authorized-keys-mode)))

;;;
;;; Magit
;;;
(use-package magit
  :load-path
  "~/.emacs.d/site-lisp/magit"
  :config
  (add-hook 'magit-mode-hook 'magit-load-config-extensions))

;;;
;;; C-family programming languages
;;;
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

;;
;; Customizations for C mode.
;;
(add-hook 'c-mode-hook
   (lambda ()
     (c-set-style "tbrown")
     )
   )

;;
;; Customizations for C++ mode.
;;
(add-hook 'c++-mode-hook
   (lambda ()
     (c-set-style "tbrown")
     )
   )

;;
;; Customizations for all sub-modes in CC Mode.
;;
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

(when (require 'c-eldoc nil :noerror)
  ;; add more as desired, superset of what you'd like to use
  (setq c-eldoc-includes "-I.")

  (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
  (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode))

;;;
;;; JavaScript programming language
;;;
(use-package js-comint
  :ensure t
  :defer t)

(use-package tern
  :ensure t
  :defer t)
(use-package company-tern
  :ensure t
  :defer t)

;;;
;;; node.js
;;;
(use-package nodejs-repl
  :ensure t
  :defer t)

;;;
;;; CoffeeScript programming language
;;;
(use-package coffee-mode
  :ensure t
  :defer t)

(when (require 'tern nil :noerror)
  (add-hook 'js-mode-hook (lambda ()
                            (tern-mode t))))

;;;
;;; Assembler programming language
;;;
(when (require 'asm-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.[sh][56][45x]\\'" . asm-mode)))

;;;
;;; Generic modes
;;;
(when (require 'generic-x nil :noerror)
  )

;;;
;;; Markdown
;;;
(use-package markdown-mode
  :ensure t
  :defer t)
(use-package markdown-mode+
  :ensure t
  :defer t)

(when (require 'markdown-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

;;;
;;; Python programming language
;;;
(use-package py-autopep8
  :ensure t
  :defer t)
(use-package elpy
  :ensure t
  :defer t)
(use-package flycheck-pyflakes
  :ensure t
  :defer t)
(use-package pip-requirements
  :ensure t
  :defer t)
(use-package nose
  :ensure t
  :defer t)
(use-package virtualenv
  :ensure t
  :defer t)

(when (require 'elpy nil :noerror)
  (elpy-enable)

  ;; disable flymake if flycheck is available
  (when (require 'flycheck nil :noerror)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    )
  )

;;;
;;; Git
;;;
(use-package ibuffer-git
  :ensure t
  :defer t)

(use-package gitattributes-mode
  :ensure t
  :defer t)
(use-package gitconfig-mode
  :ensure t
  :defer t)
(when (require 'gitconfig-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.gitconfig.*\\'" . gitconfig-mode))

  ;; SubGit-generated Git submodules files
  (add-to-list 'auto-mode-alist '("\\.gitsvnextmodules\\'" . gitconfig-mode))
  ;; migration-generated Git submodules files
  (add-to-list 'auto-mode-alist '("\\.gitsvnexternals\\'" . gitconfig-mode)))
(use-package gitignore-mode
  :ensure t
  :defer t)

(use-package git-gutter
  :ensure t
  :defer t)
(use-package git-gutter-fringe
  :ensure t
  :defer t)
(use-package git-messenger
  :ensure t
  :defer t)

;;;
;;; GitHub
;;;
(use-package gist
  :ensure t
  :defer t)
(use-package git-link
  :ensure t
  :defer t)

;;;
;;; Code Composer Studio and DSP/BIOS mode
;;;
;;;    TextConf script types
;;;
(when (require 'cc-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.h[cd]f\\'" . c-mode))
  (add-to-list 'auto-mode-alist '("\\.l[cd]f\\'" . c-mode))

  (add-to-list 'auto-mode-alist '("\\.gel\\'" . c-mode)))

(when (require 'js-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.tcf\\'" . js-mode))
  (add-to-list 'auto-mode-alist '("\\.tci\\'" . js-mode))
  (add-to-list 'auto-mode-alist '("\\.tcp\\'" . js-mode))
  (add-to-list 'auto-mode-alist '("\\.xs\\'" . js-mode)))

;;;
;;; Programming mode hooks
;;;
(add-hook 'prog-mode-hook (lambda ()
                            (setq indent-tabs-mode nil)))
(when (require 'linum nil :noerror)
  (add-hook 'prog-mode-hook (lambda ()
                              (linum-mode 1))))
(when (require 'flyspell nil :noerror)
  (add-hook 'prog-mode-hook 'flyspell-prog-mode))

;;;
;;; Text mode hooks (additional)
;;;
(add-hook 'text-mode-hook (lambda ()
                            (setq indent-tabs-mode nil)))
(add-hook 'text-mode-hook (lambda ()
                            (linum-mode 1)))

;;;
;;; Flycheck
;;;
(use-package flycheck
  :ensure t
  :defer t)
(use-package flycheck-google-cpplint
  :ensure t
  :defer t)
(use-package flycheck-irony
  :ensure t
  :defer t)
(use-package flycheck-package
  :ensure t
  :defer t)
(use-package flycheck-ycmd
  :ensure t
  :defer t)

(when (>= emacs-major-version 24)
  (add-hook 'after-init-hook #'global-flycheck-mode))

;;;
;;; Company completion
;;;
(use-package company
  :ensure t
  :defer t)
(use-package company-auctex
  :ensure t
  :defer t)
(use-package company-c-headers
  :ensure t
  :defer t)
(use-package company-ghc
  :ensure t
  :defer t)
(use-package company-ycmd
  :ensure t
  :defer t)

(when (require 'company nil :noerror)
  (when (require 'company-auctex nil :noerror)
    (add-to-list 'company-backends 'company-auctex t))

  (when (require 'company-c-headers nil :noerror)
    (add-to-list 'company-backends 'company-c-headers t))

  (when (require 'company-ghc nil :noerror)
    (add-to-list 'company-backends 'company-ghc t))

  (when (require 'company-go nil :noerror)
    (add-to-list 'company-backends 'company-go t))

  (when (require 'company-inf-ruby nil :noerror)
    (add-to-list 'company-backends 'company-inf-ruby t))

  (when (require 'company-tern nil :noerror)
    (add-to-list 'company-backends 'company-tern t))

  (when (require 'company-ycmd nil :noerror)
    (add-to-list 'company-backends 'company-ycmd t))

  (add-hook 'after-init-hook 'global-company-mode))

;;;
;;; rtags
;;;
(use-package rtags
  :load-path
  "~/opt/local/src/rtags/src"
  :init
  (use-package company-rtags
    :load-path
    "~/opt/local/src/rtags/src"
    :config
    (add-to-list 'company-backends 'company-rtags t))
  :config
  (rtags-enable-standard-keybindings c-mode-base-map "\C-xt"))

;;;
;;; Projectile
;;;
(use-package projectile
  :ensure t
  :defer t)
(use-package ibuffer-projectile
  :ensure t
  :defer t)

(when (require 'projectile nil :noerror)
  (projectile-global-mode)

  ;; @tood workaround for an issue with tramp
  (setq projectile-mode-line " Projectile"))

;;;
;;; Helm
;;;
(use-package helm
  :ensure t
  :defer t)
(use-package helm-flycheck
  :ensure t
  :defer t)
(use-package helm-flyspell
  :ensure t
  :defer t)
(use-package helm-projectile
  :ensure t
  :defer t)

(when (require 'helm nil :noerror)
  (helm-mode 1)

  (when (require 'helm-flycheck nil :noerror)
    (eval-after-load 'flycheck
      '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))
    )

  (when (require 'helm-flyspell nil :noerror)
    (eval-after-load 'flyspell
      '(define-key flyspell-mode-map (kbd "C-;") 'helm-flyspell))
    )
  )

;;;
;;; Expand region
;;;
(use-package expand-region
  :ensure t
  :defer t)
(when (require 'expand-region nil :noerror)
  (global-set-key (kbd "C-c =") 'er/expand-region))

;;;
;;; Rainbow modes
;;;
(use-package rainbow-delimiters
  :disabled t
  :ensure t
  :defer t
  :config
  (global-rainbow-delimiters-mode))
(use-package rainbow-identifiers
  :disabled t
  :ensure t
  :defer t
  :config
  (rainbow-identifiers-mode))

;;;
;;; Smart mode line
;;;
(use-package smart-mode-line
  :ensure t
  :defer t)
(when (require 'smart-mode-line nil :noerror)
  (setq sml/theme nil)

  (sml/setup))

;;;
;;; Themes
;;;
(use-package afternoon-theme
  :ensure t
  :defer t)
(use-package ahungry-theme
  :ensure t
  :defer t)
(use-package alect-themes
  :ensure t
  :defer t)
(use-package ample-theme
  :ensure t
  :defer t)
(use-package ample-zen-theme
  :ensure t
  :defer t)
(use-package anti-zenburn-theme
  :ensure t
  :defer t)
(use-package assemblage-theme
  :ensure t
  :defer t)
(use-package atom-dark-theme
  :ensure t
  :defer t)
(use-package badger-theme
  :ensure t
  :defer t)
(use-package base16-theme
  :ensure t
  :defer t)
(use-package basic-theme
  :ensure t
  :defer t)
(use-package birds-of-paradise-plus-theme
  :ensure t
  :defer t)
(use-package bubbleberry-theme
  :ensure t
  :defer t)
(use-package busybee-theme
  :ensure t
  :defer t)
(use-package calmer-forest-theme
  :ensure t
  :defer t)
(use-package cherry-blossom-theme
  :ensure t
  :defer t)
(use-package clues-theme
  :ensure t
  :defer t)
(use-package cyberpunk-theme
  :ensure t
  :defer t)
(use-package dakrone-theme
  :ensure t
  :defer t)
(use-package darcula-theme
  :ensure t
  :defer t)
(use-package darkburn-theme
  :ensure t
  :defer t)
(use-package darkmine-theme
  :ensure t
  :defer t)
(use-package darktooth-theme
  :ensure t
  :defer t)
(use-package deep-thought-theme
  :ensure t
  :defer t)
(use-package distinguished-theme
  :ensure t
  :defer t)
(use-package django-theme
  :ensure t
  :defer t)
(use-package eclipse-theme
  :ensure t
  :defer t)
(use-package espresso-theme
  :ensure t
  :defer t)
(use-package farmhouse-theme
  :ensure t
  :defer t)
(use-package firebelly-theme
  :ensure t
  :defer t)
(use-package flatland-theme
  :ensure t
  :defer t)
(use-package flatui-theme
  :ensure t
  :defer t)
(use-package gandalf-theme
  :ensure t
  :defer t)
(use-package github-theme
  :ensure t
  :defer t)
(use-package gotham-theme
  :ensure t
  :defer t)
(use-package grandshell-theme
  :ensure t
  :defer t)
(use-package greymatters-theme
  :ensure t
  :defer t)
(use-package gruber-darker-theme
  :ensure t
  :defer t)
(use-package gruvbox-theme
  :ensure t
  :defer t)
(use-package hc-zenburn-theme
  :ensure t
  :defer t)
(use-package hemisu-theme
  :ensure t
  :defer t)
(use-package heroku-theme
  :ensure t
  :defer t)
(use-package hipster-theme
  :ensure t
  :defer t)
(use-package inkpot-theme
  :ensure t
  :defer t)
(use-package ir-black-theme
  :ensure t
  :defer t)
(use-package jazz-theme
  :ensure t
  :defer t)
(use-package jujube-theme
  :ensure t
  :defer t)
(use-package late-night-theme
  :ensure t
  :defer t)
(use-package lenlen-theme
  :ensure t
  :defer t)
(use-package leuven-theme
  :ensure t
  :defer t)
(use-package light-soap-theme
  :ensure t
  :defer t)
(use-package lush-theme
  :ensure t
  :defer t)
(use-package material-theme
  :ensure t
  :defer t)
(use-package mbo70s-theme
  :ensure t
  :defer t)
(use-package minimal-theme
  :ensure t
  :defer t)
(use-package moe-theme
  :ensure t
  :defer t)
(use-package molokai-theme
  :ensure t
  :defer t)
(use-package monochrome-theme
  :ensure t
  :defer t)
(use-package monokai-theme
  :ensure t
  :defer t)
(use-package mustang-theme
  :ensure t
  :defer t)
(use-package naquadah-theme
  :ensure t
  :defer t)
(use-package niflheim-theme
  :ensure t
  :defer t)
(use-package noctilux-theme
  :ensure t
  :defer t)
(use-package nzenburn-theme
  :ensure t
  :defer t)
(use-package obsidian-theme
  :ensure t
  :defer t)
(use-package occidental-theme
  :ensure t
  :defer t)
(use-package oldlace-theme
  :ensure t
  :defer t)
(use-package organic-green-theme
  :ensure t
  :defer t)
(use-package pastels-on-dark-theme
  :ensure t
  :defer t)
(use-package phoenix-dark-mono-theme
  :ensure t
  :defer t)
(use-package phoenix-dark-pink-theme
  :ensure t
  :defer t)
(use-package plan9-theme
  :ensure t
  :defer t)
(use-package planet-theme
  :ensure t
  :defer t)
(use-package professional-theme
  :ensure t
  :defer t)
(use-package purple-haze-theme
  :ensure t
  :defer t)
(use-package qsimpleq-theme
  :ensure t
  :defer t)
(use-package railscasts-theme
  :ensure t
  :defer t)
(use-package sea-before-storm-theme
  :ensure t
  :defer t)
(use-package seti-theme
  :ensure t
  :defer t)
(use-package smyx-theme
  :ensure t
  :defer t)
(use-package soft-charcoal-theme
  :ensure t
  :defer t)
(use-package soft-morning-theme
  :ensure t
  :defer t)
(use-package soft-stone-theme
  :ensure t
  :defer t)
(use-package solarized-theme
  :ensure t
  :defer t)
(use-package soothe-theme
  :ensure t
  :defer t)
(use-package spacegray-theme
  :ensure t
  :defer t)
(use-package steady-theme
  :ensure t
  :defer t)
(use-package stekene-theme
  :ensure t
  :defer t)
(use-package sublime-themes
  :ensure t
  :defer t)
(use-package subatomic-theme
  :ensure t
  :defer t)
(use-package subatomic256-theme
  :ensure t
  :defer t)
(use-package sunny-day-theme
  :ensure t
  :defer t)
(use-package tango-plus-theme
  :ensure t
  :defer t)
(use-package tao-theme
  :ensure t
  :defer t)
(use-package tangotango-theme
  :ensure t
  :defer t)
(use-package tommyh-theme
  :ensure t
  :defer t)
(use-package toxi-theme
  :ensure t
  :defer t)
(use-package tron-theme
  :ensure t
  :defer t)
(use-package tronesque-theme
  :ensure t
  :defer t)
(use-package twilight-theme
  :ensure t
  :defer t)
(use-package twilight-anti-bright-theme
  :ensure t
  :defer t)
(use-package twilight-bright-theme
  :ensure t
  :defer t)
(use-package ubuntu-theme
  :ensure t
  :defer t)
(use-package ujelly-theme
  :ensure t
  :defer t)
(use-package underwater-theme
  :ensure t
  :defer t)
(use-package waher-theme
  :ensure t
  :defer t)
(use-package warm-night-theme
  :ensure t
  :defer t)
(use-package yoshi-theme
  :ensure t
  :defer t)
(use-package zen-and-art-theme
  :ensure t
  :defer t)
(use-package zenburn-theme
  :ensure t
  :defer t)
(use-package zonokai-theme
  :ensure t
  :defer t)

(when (>= emacs-major-version 24)
  (cond ((display-graphic-p)
         (when (member 'solarized-dark (custom-available-themes))
           (load-theme 'solarized-dark t t)

           (enable-theme 'solarized-dark)))
        ((display-color-p)
         (when (member 'cyberpunk (custom-available-themes))
           (load-theme 'cyberpunk t t)

           (enable-theme 'cyberpunk)))
        (t nil)))

;;;
;;; Start the emacs server (emacsserver/emacsclient)
;;;
(when (require 'server nil :noerror)
  (unless (server-running-p)
    (server-start)))

(provide '.emacs)
;;; .emacs ends here
