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
;;; Helper for installing packages
;;;
(defun init-install-package (package)
  "Install PACKAGE in Emacs 24 if it is not already installed."
  (when (and (>= emacs-major-version 24)
             (not (package-installed-p package)))
    (package-install package)))

;;; Markdown formats
(init-install-package 'adoc-mode)
(init-install-package 'creole-mode)
(init-install-package 'jade-mode)
(init-install-package 'markup-faces)
(init-install-package 'pandoc-mode)
(init-install-package 'sphinx-frontend)

;;; Utilities
(init-install-package 'ascii)

;;; Android development
(init-install-package 'android-mode)

;;; Configuration files
(init-install-package 'apache-mode)
(init-install-package 'crontab-mode)
(init-install-package 'dockerfile-mode)
(init-install-package 'nginx-mode)
(init-install-package 'ninja-mode)
(init-install-package 'osx-plist)
(init-install-package 'syslog-mode)
(init-install-package 'toml-mode)
(init-install-package 'yaml-mode)

;;; Programming languages
(init-install-package 'applescript-mode)
(init-install-package 'dot-mode)
(init-install-package 'graphviz-dot-mode)
(init-install-package 'haskell-mode)
(init-install-package 'jgraph-mode)
(init-install-package 'lua-mode)
(init-install-package 'pov-mode)
(init-install-package 'tidy)
(init-install-package 'web-mode)

;;; TeX and LaTeX
(init-install-package 'auctex)

;;; C-family programming language
(init-install-package 'c-eldoc)
(init-install-package 'cppcheck)
(init-install-package 'cuda-mode)
(init-install-package 'demangle-mode)
(init-install-package 'disaster)
(init-install-package 'dummy-h-mode)
(init-install-package 'glsl-mode)
(init-install-package 'google-c-style)
(init-install-package 'hide-comnt)
(init-install-package 'irony)
(init-install-package 'irony-eldoc)
(init-install-package 'objc-font-lock)
(init-install-package 'malinka)

;;; Perl programming language
(init-install-package 'cperl-mode)

;;; File formats
(init-install-package 'csv-mode)
(init-install-package 'irfc)

;;; Tags
(init-install-package 'ctags)
(init-install-package 'ctags-update)
(init-install-package 'gtags)

;;; D programming language
(init-install-package 'd-mode)

;;; Emacs
(init-install-package 'darkroom)
(init-install-package 'dedicated)
(init-install-package 'electric-case)
(init-install-package 'fm)
(init-install-package 'nav)
(init-install-package 'nav-flash)
(init-install-package 'nlinum)
(init-install-package 'persistent-soft)
(init-install-package 'popup)
(init-install-package 'pos-tip)
(init-install-package 'smooth-scroll)
(init-install-package 'sublimity)
(init-install-package 'sws-mode)
(init-install-package 'textmate)
(init-install-package 'undo-tree)
(init-install-package 'writeroom-mode)

;;; Evil (vi) emulation
(init-install-package 'evil)

;;; Diffs
(init-install-package 'diff-hl)

;;; Emacs dired
(init-install-package 'dired+)
(init-install-package 'dired-details)
(init-install-package 'dired-details+)
(init-install-package 'dired-rainbow)
(init-install-package 'dired-single)

;;; Windows support
(init-install-package 'dos)
(init-install-package 'ntcmd)
(init-install-package 'powershell)

;;; Revision control
(init-install-package 'find-file-in-repository)
(init-install-package 'ibuffer-vc)

;;; Fish shell programming
(init-install-package 'fish-mode)

;;; Flyspell
(init-install-package 'flyspell-lazy)

;;; Scheme programming language
(init-install-package 'geiser)

;;; TRAMP
(init-install-package 'ibuffer-tramp)

;;; Google
(init-install-package 'google-this)

;;; Learning Emacs
(init-install-package 'guru-mode)
(init-install-package 'vimgolf)

;;; Programming languages
(init-install-package 'howdoi)
(init-install-package 'rainbow-delimiters)
(init-install-package 'rainbow-identifiers)

;;; Occur
(init-install-package 'ioccur)
(init-install-package 'noccur)

;;; Mercurial
(init-install-package 'monky)

;;; Org mode
(init-install-package 'org)

;;; Perforce
(init-install-package 'p4)

;;; Processing programming language
(init-install-package 'processing-mode)
(init-install-package 'processing-snippets)

;;; Protobuf
(init-install-package 'protobuf-mode)

;;; Subversion
(init-install-package 'psvn)

;;; SSH
(init-install-package 'ssh)

;;; Writing
(init-install-package 'synonyms)
(init-install-package 'thesaurus)

;;; Microsoft Team Foundation Server
(init-install-package 'tfs)
(init-install-package 'vc-tfs)

;;; Initialization utilities
(init-install-package 'use-package)
(init-install-package 'wonderland)

;;; Fossil
(init-install-package 'vc-fossil)

;;;
;;; Ido
;;;
(init-install-package 'ido-ubiquitous)

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
;;; vimrc mode
;;;
(init-install-package 'vimrc-mode)

(when (require 'vimrc-mode nil :noerror)
  )

;;;
;;; Makefile mode
;;;
(when (require 'make-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("Makefile.*\\'" . makefile-mode))

  (add-hook 'makefile-mode-hook (lambda ()
                                  (setq indent-tabs-mode t))))

;;;
;;; Boost.Build mode
;;;
;;; @todo no official support for this yet

;;;
;;; Jamfile mode
;;;
(init-install-package 'jam-mode)

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
;;; CMake mode.
;;;
(init-install-package 'cmake-mode)
(init-install-package 'cmake-font-lock)
(init-install-package 'cmake-project)
(init-install-package 'cpputils-cmake)

(when (require 'cmake-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
  (add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode)))

;;;
;;; Gnuplot mode
;;;
(init-install-package 'gnuplot)
(init-install-package 'gnuplot-mode)

(when (require 'gnuplot-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.gp\\'" . gnuplot-mode)))

;;;
;;; Go mode
;;;
(init-install-package 'go-mode)
(init-install-package 'company-go)
(init-install-package 'go-autocomplete)
(init-install-package 'go-direx)
(init-install-package 'go-eldoc)
(init-install-package 'go-errcheck)
(init-install-package 'go-play)
(init-install-package 'go-projectile)
(init-install-package 'go-snippets)
(init-install-package 'go-stacktracer)
(init-install-package 'golint)
(init-install-package 'gore-mode)
(init-install-package 'gotest)
(init-install-package 'govet)

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
;;; Swift mode
;;;
;; (init-install-package 'swift-mode)

(when (require 'swift-mode nil :noerror)
  nil)

;;;
;;; MATLAB mode
;;;
(init-install-package 'matlab-mode)

(when (require 'matlab nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode)))

;;;
;;; GNU Octave mode (MATLAB)
;;;
(when (require 'octave-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode)))

;;;
;;; PHP mode
;;;
(when (require 'php-mode nil :noerror)
  )

;;;
;;; Ruby mode
;;;
(init-install-package 'company-inf-ruby)
(init-install-package 'inf-ruby)
(init-install-package 'rbenv)
(init-install-package 'rspec-mode)
(init-install-package 'ruby-compilation)
(init-install-package 'ruby-electric)
(init-install-package 'ruby-mode)
(init-install-package 'bundler)

(when (require 'ruby-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("[Rr]akefile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode)))

;;;
;;; JSON mode
;;;
(init-install-package 'json-mode)

(when (require 'json-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode)))

;;;
;;; Objective-J mode
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
;;; Jakefile mode
;;;
(when (require 'js-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("[Jj]akefile.*\\'" . js-mode))
  (add-to-list 'auto-mode-alist '("\\.jake\\'" . js-mode)))

;;;
;;; C# mode
;;;
;; (init-install-package 'csharp-mode)
;; (init-install-package 'omnisharp)

(when (require 'csharp-mode nil :noerror)
  )

;;;
;;; XML mode
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
(init-install-package 'docbook)

(when (require 'nxml nil :noerror)
  (add-to-list 'auto-mode-alist '("\\.docbook\\'" . nxml-mode)))

;;;
;;; SSH Configuration Files
;;;
(init-install-package 'ssh-config-mode)

(when (require 'ssh-config-mode nil :noerror)

  (add-to-list 'auto-mode-alist '(".ssh/config\\'"  . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("sshd?_config\\'" . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("known_hosts\\'"  . ssh-known-hosts-mode))
  (add-to-list 'auto-mode-alist '("authorized_keys2?\\'" . ssh-authorized-keys-mode)))

;;;
;;; Magit
;;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/magit"))

(when (require 'magit nil :noerror)
  (add-hook 'magit-mode-hook 'magit-load-config-extensions))

;;;
;;; CC Mode customizations.
;;;
;;;    All CC Mode mode configurations
;;;
;;; NOTE: This is based on the sample from the Info node on CC Mode.
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

;;;
;;; C eldoc
;;;
(when (require 'c-eldoc nil :noerror)
  ;; add more as desired, superset of what you'd like to use
  (setq c-eldoc-includes "-I.")

  (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
  (add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode))

;;;
;;; Customizations for JavaScript
;;;
(init-install-package 'js-comint)

(init-install-package 'tern)
(init-install-package 'company-tern)

(init-install-package 'nodejs-repl)

(init-install-package 'coffee-mode)

(when (require 'tern nil :noerror)
  (add-hook 'js-mode-hook (lambda ()
                            (tern-mode t))))

;;;
;;; Asm Mode Configuration
;;;
;;; TBD: Fix this up for new version of emacs!
;;;
(when (require 'asm-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.[sh][56][45x]\\'" . asm-mode)))

;;;
;;; Generic modes (configuration files, etc.)
;;;
(when (require 'generic-x nil :noerror)
  )

;;;
;;; Markdown mode
;;;
(init-install-package 'markdown-mode)
(init-install-package 'markdown-mode+)

(when (require 'markdown-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

;;;
;;; Python
;;;
(init-install-package 'py-autopep8)
(init-install-package 'elpy)
(init-install-package 'flycheck-pyflakes)
(init-install-package 'pip-requirements)
(init-install-package 'nose)
(init-install-package 'virtualenv)

(when (require 'elpy nil :noerror)
  (elpy-enable)

  ;; disable flymake if flycheck is available
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    )
  )

;;;
;;; Git modes
;;;
(init-install-package 'gitattributes-mode)
(init-install-package 'gitconfig-mode)
(init-install-package 'gitignore-mode)

(init-install-package 'git-gutter)
(init-install-package 'git-gutter-fringe)
(init-install-package 'git-link)
(init-install-package 'git-messenger)
(init-install-package 'gitconfig)

(init-install-package 'gist)

(init-install-package 'ibuffer-git)

(when (require 'gitconfig-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.gitconfig.*\\'" . gitconfig-mode))

  ;; SubGit-generated Git submodules files
  (add-to-list 'auto-mode-alist '("\\.gitsvnextmodules\\'" . gitconfig-mode))
  ;; migration-generated Git submodules files
  (add-to-list 'auto-mode-alist '("\\.gitsvnexternals\\'" . gitconfig-mode)))

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
;;; Flycheck mode
;;;
(init-install-package 'flycheck)
(init-install-package 'flycheck-google-cpplint)
(init-install-package 'flycheck-irony)
(init-install-package 'flycheck-package)
(init-install-package 'flycheck-ycmd)

(when (>= emacs-major-version 24)
  (add-hook 'after-init-hook #'global-flycheck-mode))

;;;
;;; Company (completion) mode
;;;
(init-install-package 'company)
(init-install-package 'company-auctex)
(init-install-package 'company-c-headers)
(init-install-package 'company-ghc)
(init-install-package 'company-ycmd)

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
;;; rtags mode
;;;
(add-to-list 'load-path (expand-file-name "~/opt/local/src/rtags/src") t)
(when (require 'rtags nil :noerror)
  (when (require 'company nil :noerror)
    (when (require 'company-rtags nil :noerror)
      (add-to-list 'company-backends 'company-rtags t)))

  (rtags-enable-standard-keybindings c-mode-base-map "\C-xt"))

;;;
;;; Projectile mode
;;;
(init-install-package 'projectile)
(init-install-package 'ibuffer-projectile)

(when (require 'projectile nil :noerror)
  (projectile-global-mode)

  ;; @tood workaround for an issue with tramp
  (setq projectile-mode-line " Projectile"))

;;;
;;; Helm mode
;;;
(init-install-package 'helm)
(init-install-package 'helm-flycheck)
(init-install-package 'helm-flyspell)
(init-install-package 'helm-projectile)

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
(init-install-package 'expand-region)
(when (require 'expand-region nil :noerror)
  (global-set-key (kbd "C-c =") 'er/expand-region))

;;;
;;; Rainbow modes
;;;
;; (when (require 'rainbow-delimiters nil :noerror)
;;   (global-rainbow-delimiters-mode))
;; (when (require 'rainbow-identifiers nil :noerror)
;;   (rainbow-identifiers-mode))

;;;
;;; Smart mode line
;;;
(init-install-package 'smart-mode-line)
(when (require 'smart-mode-line nil :noerror)
  (setq sml/theme nil)

  (sml/setup))

;;;
;;; Theme
;;;
(init-install-package 'afternoon-theme)
(init-install-package 'ahungry-theme)
(init-install-package 'alect-themes)
(init-install-package 'ample-theme)
(init-install-package 'ample-zen-theme)
(init-install-package 'anti-zenburn-theme)
(init-install-package 'assemblage-theme)
(init-install-package 'atom-dark-theme)
(init-install-package 'badger-theme)
(init-install-package 'base16-theme)
(init-install-package 'basic-theme)
(init-install-package 'birds-of-paradise-plus-theme)
(init-install-package 'bubbleberry-theme)
(init-install-package 'busybee-theme)
(init-install-package 'calmer-forest-theme)
(init-install-package 'cherry-blossom-theme)
(init-install-package 'clues-theme)
(init-install-package 'cyberpunk-theme)
(init-install-package 'dakrone-theme)
(init-install-package 'darcula-theme)
(init-install-package 'darkburn-theme)
(init-install-package 'darkmine-theme)
(init-install-package 'darktooth-theme)
(init-install-package 'deep-thought-theme)
(init-install-package 'distinguished-theme)
(init-install-package 'django-theme)
(init-install-package 'eclipse-theme)
(init-install-package 'espresso-theme)
(init-install-package 'farmhouse-theme)
(init-install-package 'firebelly-theme)
(init-install-package 'flatland-theme)
(init-install-package 'flatui-theme)
(init-install-package 'gandalf-theme)
(init-install-package 'github-theme)
(init-install-package 'gotham-theme)
(init-install-package 'grandshell-theme)
(init-install-package 'greymatters-theme)
(init-install-package 'gruber-darker-theme)
(init-install-package 'gruvbox-theme)
(init-install-package 'hc-zenburn-theme)
(init-install-package 'hemisu-theme)
(init-install-package 'heroku-theme)
(init-install-package 'hipster-theme)
(init-install-package 'inkpot-theme)
(init-install-package 'ir-black-theme)
(init-install-package 'jazz-theme)
(init-install-package 'jujube-theme)
(init-install-package 'late-night-theme)
(init-install-package 'lenlen-theme)
(init-install-package 'leuven-theme)
(init-install-package 'light-soap-theme)
(init-install-package 'lush-theme)
(init-install-package 'material-theme)
(init-install-package 'mbo70s-theme)
(init-install-package 'minimal-theme)
(init-install-package 'moe-theme)
(init-install-package 'molokai-theme)
(init-install-package 'monochrome-theme)
(init-install-package 'monokai-theme)
(init-install-package 'mustang-theme)
(init-install-package 'naquadah-theme)
(init-install-package 'niflheim-theme)
(init-install-package 'noctilux-theme)
(init-install-package 'nzenburn-theme)
(init-install-package 'obsidian-theme)
(init-install-package 'occidental-theme)
(init-install-package 'oldlace-theme)
(init-install-package 'organic-green-theme)
(init-install-package 'pastels-on-dark-theme)
(init-install-package 'phoenix-dark-mono-theme)
(init-install-package 'phoenix-dark-pink-theme)
(init-install-package 'plan9-theme)
(init-install-package 'planet-theme)
(init-install-package 'professional-theme)
(init-install-package 'purple-haze-theme)
(init-install-package 'qsimpleq-theme)
(init-install-package 'railscasts-theme)
(init-install-package 'sea-before-storm-theme)
(init-install-package 'seti-theme)
(init-install-package 'smyx-theme)
(init-install-package 'soft-charcoal-theme)
(init-install-package 'soft-morning-theme)
(init-install-package 'soft-stone-theme)
(init-install-package 'solarized-theme)
(init-install-package 'soothe-theme)
(init-install-package 'spacegray-theme)
(init-install-package 'steady-theme)
(init-install-package 'stekene-theme)
(init-install-package 'sublime-themes)
(init-install-package 'subatomic-theme)
(init-install-package 'subatomic256-theme)
(init-install-package 'sunny-day-theme)
(init-install-package 'tango-plus-theme)
(init-install-package 'tao-theme)
(init-install-package 'tangotango-theme)
(init-install-package 'tommyh-theme)
(init-install-package 'toxi-theme)
(init-install-package 'tron-theme)
(init-install-package 'tronesque-theme)
(init-install-package 'twilight-theme)
(init-install-package 'twilight-anti-bright-theme)
(init-install-package 'twilight-bright-theme)
(init-install-package 'ubuntu-theme)
(init-install-package 'ujelly-theme)
(init-install-package 'underwater-theme)
(init-install-package 'waher-theme)
(init-install-package 'warm-night-theme)
(init-install-package 'yoshi-theme)
(init-install-package 'zen-and-art-theme)
(init-install-package 'zenburn-theme)
(init-install-package 'zonokai-theme)

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
