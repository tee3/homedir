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
       crontab-mode
       csv-mode
       ctags-update
       d-mode
       dart-mode
       dash
       dedicated
       diff-hl
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
       gnuplot
       go-mode
       graphviz-dot-mode
       guru-mode
       haskell-mode
       inf-ruby
       irfc
       jade-mode
       jam-mode
       js-comint
       list-utils
       lua-mode
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
       rbenv
       s
       ssh
       string-utils
       sws-mode
       synonyms
       syslog-mode
       textmate
       tidy
       todotxt
       toml-mode
       vimgolf
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

     '(applescript-mode
       bundler
       c-eldoc
       cmake-mode
       coffee-mode
       company
       company-auctex
       company-c-headers
       company-ghc
       company-go
       company-inf-ruby
       company-tern
       company-ycmd
       cperl-mode
       ctags
       dropbox
       electric-case
       elpy
       expand-region
       flycheck
       git-gutter
       git-gutter-fringe
       gitattributes-mode
       gitconfig
       gitconfig-mode
       gitignore-mode
       go-eldoc
       google-this
       gtags
       helm
       helm-flycheck
       helm-flyspell
       helm-projectile
       ido-ubiquitous
       jabber
       jgraph-mode
       json
       json-mode
       markdown-mode
       monky
       nav-flash
       ntcmd
       osx-plist
       pandoc-mode
       pcache
       persistent-soft
       popup
       powershell
       rainbow-delimiters
       rainbow-identifiers
       rspec-mode
       ruby-compilation
       ruby-mode
       simple-httpd
       smart-mode-line
       smooth-scroll
       ssh-config-mode
       swift-mode
       tern
       twittering-mode
       undo-tree
       vimrc-mode
       writeroom-mode)))

  ;; Install Emacs 24 packages
  ;; @todo not in melpa-stable or marmalade
  ;; (when (>= emacs-major-version 24)
  ;;   (mapc
  ;;    (lambda (package)
  ;;      (or (package-installed-p package)
  ;;          (package-install package)))

  ;;    '(dired+
  ;;      dired-details
  ;;      dired-details+
  ;;      dired-single
  ;;      markup-faces
  ;;      ssh-config-mode
  ;;      tfs
  ;;      thesaurus
  ;;      vc-fossil
  ;;      vimrc-mode
  ;;      asn1-mode
  ;;      go-direx
  ;;      go-errcheck
  ;;      go-snippets
  ;;      jss
  ;;      dash-at-point
  ;;      disaster
  ;;      dummy-h-mode
  ;;      fsharp-mode
  ;;      git-blame
  ;;      git-dwim
  ;;      glsl-mode
  ;;      gnuplot-mode
  ;;      go-autocomplete
  ;;      google-c-style
  ;;      launch
  ;;      markdown-mode+
  ;;      nav
  ;;      powershell-mode
  ;;      ruby-electric
  ;;      sublimity)))

  ;; Install themes only Emacs 24.
  (when (>= emacs-major-version 24)
    (mapc
     (lambda (package)
       (or (package-installed-p package)
           (package-install package)))

     '(afternoon-theme
       ahungry-theme
       alect-themes
       ample-theme
       ample-zen-theme
       anti-zenburn-theme
       assemblage-theme
       atom-dark-theme
       badger-theme
       base16-theme
       basic-theme
       birds-of-paradise-plus-theme
       bubbleberry-theme
       busybee-theme
       calmer-forest-theme
       cherry-blossom-theme
       clues-theme
       cyberpunk-theme
       dakrone-theme
       darcula-theme
       darkburn-theme
       darkmine-theme
       deep-thought-theme
       distinguished-theme
       django-theme
       eclipse-theme
       espresso-theme
       firebelly-theme
       flatland-theme
       flatui-theme
       gandalf-theme
       github-theme
       gotham-theme
       grandshell-theme
       gruber-darker-theme
       gruvbox-theme
       hc-zenburn-theme
       hemisu-theme
       heroku-theme
       hipster-theme
       inkpot-theme
       ir-black-theme
       jazz-theme
       jujube-theme
       late-night-theme
       leuven-theme
       light-soap-theme
       lush-theme
       minimal-theme
       moe-theme
       molokai-theme
       monochrome-theme
       monokai-theme
       mustang-theme
       naquadah-theme
       niflheim-theme
       noctilux-theme
       nzenburn-theme
       obsidian-theme
       occidental-theme
       oldlace-theme
       organic-green-theme
       pastels-on-dark-theme
       phoenix-dark-mono-theme
       phoenix-dark-pink-theme
       planet-theme
       professional-theme
       purple-haze-theme
       qsimpleq-theme
       railscasts-theme
       sea-before-storm-theme
       seti-theme
       smyx-theme
       soft-charcoal-theme
       soft-morning-theme
       soft-stone-theme
       solarized-theme
       soothe-theme
       spacegray-theme
       steady-theme
       stekene-theme
       sublime-themes
       subatomic-theme
       subatomic256-theme
       sunny-day-theme
       tangotango-theme
       tommyh-theme
       toxi-theme
       tron-theme
       tronesque-theme
       twilight-theme
       twilight-anti-bright-theme
       twilight-bright-theme
       ubuntu-theme
       ujelly-theme
       underwater-theme
       waher-theme
       warm-night-theme
       yoshi-theme
       zen-and-art-theme
       zenburn-theme
       zonokai-theme))))

;;;
;;; Ido
;;;
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
(when (require 'swift-mode nil :noerror)
  nil)

;;;
;;; MATLAB mode
;;;
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
(when (require 'ruby-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("[Rr]akefile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode)))

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
(when (require 'nxml nil :noerror)
  (add-to-list 'auto-mode-alist '("\\.docbook\\'" . nxml-mode)))

;;;
;;; SSH Configuration Files
;;;
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
(when (require 'markdown-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

;;;
;;; Python
;;;
(when (require 'elpy nil :noerror)
  (elpy-enable))

;;;
;;; Git modes
;;;
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

(when (require 'js2-mode nil :noerror)

  (add-to-list 'auto-mode-alist '("\\.tcf\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.tci\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.tcp\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.xs\\'" . js2-mode)))

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
(when (>= emacs-major-version 24)
  (add-hook 'after-init-hook #'global-flycheck-mode))

;;;
;;; Company (completion) mode
;;;
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
(when (require 'projectile nil :noerror)
  (projectile-global-mode))

;;;
;;; Helm mode
;;;
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
(when (require 'smart-mode-line nil :noerror)
  (setq sml/theme nil)

  (sml/setup))

;;;
;;; Theme
;;;
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
