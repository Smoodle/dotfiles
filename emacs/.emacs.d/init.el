(let ((gc-cons-threshold most-positive-fixnum))

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/") t)

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
  :ensure org-plus-contrib)

(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))

(garbage-collect))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("27a1dd6378f3782a593cc83e108a35c2b93e5ecc3bd9057313e1d88462701fcd" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" default))
 '(package-selected-packages
   '(lsp-ui lsp-mode auctex eglot beacon flymake-shellcheck tree-sitter-langs tree-sitter poly-R ess moe-theme moonscript moonscript-mode yasnippet lua-mode neotree undo-tree json-mode helpful ivy-rich rainbow-delimiters company-lsp lsp-mssql ox-twbs ox-twiki typescript-mode ivy winum projectile treemacs company org-bullets doom-modeline elcord which-key evil-collection evil-surround evil-magit evil use-package org-plus-contrib)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
