(setq gc-cons-threshold (* 1024 1024 500)) ;; 500mb
(setq read-process-output-max (* 1024 1024 5)) ;; 5mb
(setq comp-deferred-compilation t)

(require 'package)

(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package org
  :ensure org-contrib)

(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))

(garbage-collect)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-show-quick-access t nil nil "Customized with use-package company")
 '(custom-safe-themes
   '("27a1dd6378f3782a593cc83e108a35c2b93e5ecc3bd9057313e1d88462701fcd" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" default))
 '(package-selected-packages
   '(dap-mode keycast esup org-roam golden-ratio deadgrep org-appear carbon-now-sh vterm ng2-mode web-mode slime flycheck rotate emacs-rotate company-box lsp-ui lsp-mode auctex eglot beacon flymake-shellcheck poly-R ess moe-theme moonscript moonscript-mode yasnippet lua-mode neotree undo-tree json-mode helpful ivy-rich rainbow-delimiters company-lsp lsp-mssql ox-twbs ox-twiki typescript-mode ivy winum projectile treemacs company org-bullets doom-modeline elcord which-key evil-collection evil-surround evil-magit evil use-package org-plus-contrib))
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
