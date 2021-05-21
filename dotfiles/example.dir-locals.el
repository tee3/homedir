;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil . ((eval . (progn
                   (setq-local python-shell-virtualenv-root
	                       (expand-file-name "venv" (project-root (project-current))))
                   (setq-local python-shell-extra-pythonpaths
	                       (list "."
		                     (expand-file-name "some-directory" (project-root (project-current))))))))))
