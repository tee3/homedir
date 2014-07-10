;;;;
;;;; Emacs user configuration file.
;;;;
;;;;    This file customizes Emacs for a specific user's needs.
;;;;

;;;
;;; Update the load path to include the user's lisp files.
;;;
(add-to-list 'load-path "~/opt/local/share/emacs/site-lisp" t)
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp" t)

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
 '(ac-auto-start t)
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
 '(desktop-save-mode t)
 '(dired-kept-versions 6)
 '(display-time-mode t)
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(fringe-mode 4 nil (fringe))
 '(git-commit-confirm-commit t)
 '(global-auto-complete-mode t)
 '(global-cwarn-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(gnus-select-method (quote (nntp "news.gmane.org")))
 '(grep-command nil)
 '(gud-pdb-command-name "python -m pdb")
 '(hide-ifdef-lines t)
 '(history-delete-duplicates t)
 '(icomplete-mode t)
 '(ido-case-fold nil)
 '(ido-everywhere t)
 '(ido-mode (quote both) nil (ido))
 '(ido-ubiquitous-mode t)
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-url-at-point t)
 '(inferior-octave-startup-args (quote ("--traditional")))
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold nil)
 '(linum-format "%4d ")
 '(load-home-init-file t t)
 '(magit-diff-options nil)
 '(magit-diff-refine-hunk nil)
 '(magit-gitk-executable "gitk")
 '(magit-log-auto-more t)
 '(matlab-shell-command-switches "-nodesktop")
 '(matlab-shell-mode-hook nil)
 '(menu-bar-mode nil)
 '(mouse-wheel-mode t)
 '(ns-pop-up-frames nil)
 '(nxml-slash-auto-complete-flag t)
 '(octave-auto-indent t)
 '(octave-auto-newline t)
 '(octave-block-offset 3)
 '(octave-continuation-offset 3)
 '(paren-mode (quote sexp) nil (paren))
 '(partial-completion-mode t)
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
 '(rtags-completion-mode (quote rtags-complete-with-dabbrev-and-autocomplete))
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
    (turn-on-flyspell turn-on-auto-fill text-mode-hook-identify linum-mode)))
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
(when (require 'package nil :noerror)

  ;; add packages libraries
  (when (< emacs-major-version 24)
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
  (when (>= emacs-major-version 23)
    (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")))
  (when (>= emacs-major-version 23)
    (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/")))

  (package-initialize)

  ;; Update the package list from the network
  (package-refresh-contents)

  ;; Install any desired packages that are not installed
  (when (>= emacs-major-version 23)
    (mapc
     (lambda (package)
       (or (package-installed-p package)
	   (package-install package)))

     '(adoc-mode
       ag
       android-mode
       apache-mode
       ascii
       auctex
       coffee-mode
       crontab-mode
       csv-mode
       ctags-update
       d-mode
       dart-mode
       dash
       dedicated
       diff-hl
       dired+
       dired-details
       dired-details+
       dired-single
       docbook
       dot-mode
       ctable
       emamux
       epc
       evil
       feature-mode
       find-file-in-repository
       flyspell-lazy
       geiser
       git-commit-mode
       gitty
       gnuplot
       go-mode
       graphviz-dot-mode
       guru-mode
       haskell-mode
       inf-ruby
       irfc
       jade-mode
       jam-mode
;       jedi
       js-comint
       list-utils
       lua-mode
       magit
       markup-faces
       mo-git-blame
       mustache-mode
       nginx-mode
       nodejs-repl
       nose
       oauth
       org
       p4
       pos-tip
       pov-mode
       processing-mode
       projectile
       protobuf-mode
       psvn
       pylint
       rbenv
       s
       ssh
       ssh-config-mode
       string-utils
       sws-mode
       synonyms
       syslog-mode
       textmate
       tfs
       thesaurus
       tidy
       todotxt
       toml-mode
       vimgolf
       vimrc-mode
       virtualenv
       web-mode
       websocket
       yaml-mode)))

  ;; Install Emacs 24 packages
  (when (>= emacs-major-version 24)
    (mapc
     (lambda (package)
       (or (package-installed-p package)
	   (package-install package)))

     '(ac-js2
       ac-math
       asn1-mode
       apples-mode
       auto-complete
       electric-case
       flycheck
       gitattributes-mode
       gitconfig-mode
       gitignore-mode
       go-direx
       go-eldoc
       go-errcheck
       go-snippets
       ido-ubiquitous
       jgraph-mode
       js2-mode
       js3-mode
       jss
       magit-svn
       simple-httpd
       skewer-mode
       swift-mode
       undo-tree

       ; not in marmalade
       bundler
       cmake-mode
       cperl-mode
       ctags
       dash-at-point
       disaster
       dropbox
       dummy-h-mode
       fsharp-mode
       git-blame
       git-dwim
       git-gutter
       git-gutter-fringe
       gitconfig
       glsl-mode
       gnuplot-mode
       go-autocomplete
       google-c-style
       google-this
       gtags
       jabber
       json
       json-mode
       launch
       markdown-mode
       markdown-mode+
       monky
       nav
       nav-flash
       ntcmd
       osx-plist
       pandoc-mode
       pcache
       persistent-soft
       popup
       powershell
       powershell-mode
       rspec-mode
       ruby-compilation
       ruby-electric
       ruby-mode
       smooth-scrolling
       sublimity
       tern
       tern-auto-complete
       twittering-mode
       writeroom-mode)))

  ;; Install themes only Emacs 24.
  (when (>= emacs-major-version 24)
    (mapc
     (lambda (package)
       (or (package-installed-p package)
	   (package-install package)))

     '(alect-themes
       ample-theme
       ample-zen-theme
       anti-zenburn-theme
       zen-and-art-theme
       assemblage-theme
       base16-theme
       birds-of-paradise-plus-theme
       busybee-theme
       clues-theme
       cyberpunk-theme
       dakrone-theme
       deep-thought-theme
       django-theme
       espresso-theme
       flatland-theme
       gandalf-theme
       github-theme
       grandshell-theme
       gruber-darker-theme
       hemisu-theme
       inkpot-theme
       jujube-theme
       heroku-theme
       ir-black-theme
       late-night-theme
       leuven-theme
       moe-theme
       molokai-theme
       monokai-theme
       mustang-theme
       naquadah-theme
       noctilux-theme
       nzenburn-theme
       obsidian-theme
       occidental-theme
       pastels-on-dark-theme
       phoenix-dark-mono-theme
       phoenix-dark-pink-theme
       purple-haze-theme
       qsimpleq-theme
       reverse-theme
       sea-before-storm-theme
       soft-morning-theme
       solarized-theme
       soothe-theme
       subatomic-theme
       subatomic256-theme
       sublime-themes
       tango-2-theme
       tangotango-theme
       tommyh-theme
       toxi-theme
       tronesque-theme
       twilight-anti-bright-theme
       twilight-bright-theme
       twilight-theme
       ujelly-theme
       underwater-theme
       waher-theme
       zen-and-art-theme
       zenburn-theme))))

;;;
;;; Makefile mode
;;;
(when (require 'make-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("Makefile.*\\'" . makefile-mode)))

;;;
;;; Boost.Build mode
;;;
(when (require 'jam-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("[Jj]amroot\\'" . jam-mode))
  (add-to-list 'auto-mode-alist '("[Jj]amfile\\'" . jam-mode))
  (add-to-list 'auto-mode-alist '("\\.jam\\'" . jam-mode)))

;;;
;;; Jamfile mode
;;;
(when (require 'jam-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.jam\\'" . jam-mode)))

;;;
;;; CMake mode.
;;;
(when (require 'cmake-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
  (add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode)))

;;;
;;; Gnuplot mode
;;;
(when (require 'gnuplot-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.gp\\'" . gnuplot-mode)))

;;;
;;; Go mode
;;;
(when (require 'go-mode nil :noerror)
  nil)

;;;
;;; MATLAB mode
;;;
(when (require 'matlab nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode)))

;; ;;;
;; ;;; GNU Octave mode (MATLAB)
;; ;;;
;; (require 'octave-mode)

;; (add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

;; ;;;
;; ;;; PHP mode
;; ;;;
;; (require 'php-mode)

;;;
;;; Ruby mode
;;;
(when (require 'ruby-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("[Rr]akefile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode)))

;;;
;;; JavaScript mode
;;;
(when (require 'js2-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

;;;
;;; JSON mode
;;;
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

  (when (require 'js2-mode nil :noerror)

    (add-to-list 'auto-mode-alist '("\\.sj\\'" . js2-mode))))

;;;
;;; Jakefile mode
;;;
(when (require 'js2-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("[Jj]akefile\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.jake\\'" . js2-mode)))

;; ;;;
;; ;;; C# mode
;; ;;;
;; (require 'csharp-mode)

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
(when (require 'nxml nil :noerror)
  (add-to-list 'auto-mode-alist '("\\.docbook\\'" . nxml-mode)))

;;;
;;; SSH Configuration Files
;;;
(when (require 'ssh-config-mode nil :noerror)

  (add-to-list 'auto-mode-alist '(".ssh/config\\'"  . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("sshd?_config\\'" . ssh-config-mode)))

;;;
;;; Magit Subversion Support
;;;
(add-hook 'magit-mode-hook 'magit-load-config-extensions)

;;;
;;; CC Mode customizations.
;;;
;;;    All CC Mode mode configurations
;;;
;;; NOTE: This is based on the sample from the Info node on CC Mode.
;;;
(defconst tbrown-c-style
  '((c-basic-offset                   . 3)
     (tab-width                       . 8)
     (indent-tabs-mode                . nil)

;;     (c-comment-only-line-offset    . 4)
;;     (c-block-comment-prefix        . X)
;;     (c-comment-prefix              . X)

;;     (c-cleanup-list                . (scope-operator
;;                                       empty-defun-braces
;;                                       defun-close-semi))
    (c-hanging-braces-alist        . ((brace-list-open)
				      (substatement-open before after)
				      (block-close . c-snug-do-while)))
;;     (c-hanging-colons-alist        . ((member-init-intro before)
;;                                       (inher-intro)
;;                                       (case-label after)
;;                                       (label after)
;;                                       (access-label after)))
;;     (c-hanging-semi&comma-alist    . ())
    (c-backslash-column             . 76)
    (c-backslash-max-column         . 152)
;;     (c-special-indent-hook          . nil)
;;     (c-label-minimum-indentation    . nil)
    (c-offsets-alist               . ((arglist-close          . c-lineup-arglist)
				      (substatement-open      . 0)
				      (inline-open            . 0)
				      (case-label             . +)))
    )
  "tbrown C Programming Style")

(defconst msvc-c-style
  '((c-basic-offset                . 4)
     (tab-width                    . 4)
     (indent-tabs-mode             . t)

;;     (c-comment-only-line-offset    . 4)
;;     (c-block-comment-prefix        . X)
;;     (c-comment-prefix              . X)

;;     (c-cleanup-list                . (scope-operator
;;                                       empty-defun-braces
;;                                       defun-close-semi))
;;     (c-hanging-braces-alist        . ((brace-list-open)
;;                                       (substatement-open before after)
;;                                       (block-close . c-snug-do-while)))
;;     (c-hanging-colons-alist        . ((member-init-intro before)
;;                                       (inher-intro)
;;                                       (case-label after)
;;                                       (label after)
;;                                       (access-label after)))
;;     (c-hanging-semi&comma-alist    . ())
    (c-backslash-column             . 76)
    (c-backslash-max-column         . 152)
;;     (c-special-indent-hook          . nil)
;;     (c-label-minimum-indentation    . nil)
    (c-offsets-alist               . ((arglist-close          . c-lineup-arglist)
				      (substatement-open      . 0)
				      (inline-open            . 0)
				      (case-label             . +)))
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
     (c-toggle-auto-state                1)
     (c-toggle-hungry-state              1)
;;     (c-toggle-auto-hungry-state         1)

;;      (auto-fill-mode                           t)
;;      (abbrev-mode                              t)
;;      (line-number-mode                         t)
;;      (column-number-mode                       t)

;;      (setq tab-width                     8)
     (setq indent-tabs-mode                 nil)

;;      (setq c-tab-always-indent           t)
;;      (setq c-insert-tab-function         nil)

     (hs-minor-mode t)
     (gtags-mode t)
     (auto-complete-mode t)

     (flyspell-prog-mode)
     (linum-mode t)))

;;;
;;; Customizations for Python.
;;;
(add-hook 'python-mode-hook
          (lambda ()
	    (setq indent-tabs-mode                 nil)

	    (flyspell-prog-mode)
	    (linum-mode t)))

;;;
;;; Customizations for JavaScript
;;;
(add-hook 'js-mode-hook
	  (lambda ()
	    (tern-mode t)

	    (flyspell-prog-mode)
	    (linum-mode t)))
(add-hook 'js2-mode-hook
	  (lambda ()
	    (tern-mode t)

	    (flyspell-prog-mode)
	    (linum-mode t)))

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
(require 'generic-x)

;; ;;;
;; ;;; ComSim mode
;; ;;;
;; (require 'comsim-mode)

;; (add-to-list 'auto-mode-alist '("\\.in\\'" . comsim-mode))

;;;
;;; Code Composer Studio and DSP/BIOS mode
;;;
;;;    TextConf script types
;;;
(when (require 'cc-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.h[cd]f\\'" . c-mode))
  (add-to-list 'auto-mode-alist '("\\.l[cd]f\\'" . c-mode))

  (add-to-list 'auto-mode-alist '("\\.gel\\'" . c-mode)))

(when (require 'js2-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.tcf\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.tci\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.tcp\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.xs\\'" . js2-mode)))

;;;
;;; Flycheck mode
;;;
(when (>= emacs-major-version 24)
  (add-hook 'after-init-hook #'global-flycheck-mode))

;;;
;;; Auto-complete mode
;;;
(when (require 'auto-complete nil :noerror)
  )

;;;
;;; rtags mode
;;;
(when (require 'rtags nil :noerror)
;;   (require 'auto-complete)

;;   (rtags-enable-standard-keybindings c-mode-base-map)
  )

;;;
;;; Set helper scrolling
;;;
(defun scroll-up-one-line ()
  (interactive)
  (scroll-up 1))

(defun scroll-down-one-line ()
  (interactive)
  (scroll-down 1))

;;;
;;; Theme
;;;
(when (>= emacs-major-version 24)
  (cond ((display-graphic-p)
	 (load-theme 'solarized-dark t t)

	 (enable-theme 'solarized-dark))
	((display-color-p)
	 (load-theme 'cyberpunk t t)

	 (enable-theme 'cyberpunk))
	(t nil)))

;;;
;;; Start the emacs server (emacsserver/emacsclient)
;;;
(when (require 'server nil :noerror)
  (unless (server-running-p)
    (server-start)))
