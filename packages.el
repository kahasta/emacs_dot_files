(require 'package)
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
	     '("org" . "https://https://orgmode.org/elpa/"))
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))


;; (add-to-list 'load-path "~/.emacs.d/dired-plus")
;; (require 'dired+)

(package-initialize)
;;(package-refresh-contents)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
	use-package-expand-minimally t))

;;Install straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;Install use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package general
  :config
  (general-evil-setup t)
  )
;; now usable `jj` is possible!
;; Escape key changed on jj in insert evil mode 
(general-imap "j"
  (general-key-dispatch 'self-insert-command
    :timeout 0.25
    "j" 'evil-normal-state))

(defun kahasta/evil-hook ()
  (dolist (mode '(custom-mode
		  eshell-mode
		  get-rebase-mode
		  erc-mode
		  circle-server-mode
		  circle-chat-mode
		  circle-query-mode
		  sauron-mode
		  term-mode
		  ))
    (add-to-list 'evil-emacs-state-modes mode)))

;; Evil mode
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :hook (evil-mode . kahasta/evil-hook)
  :config
  (evil-mode 1)
  ;; (define-key evil-insert-state-map (kbd "jJ") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  )

;; Evil collection - во всех режимах и окнах доступно сочетание клавишь как в Vim
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Evil leader
(use-package evil-leader
  :ensure t
  :init
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  )

;;Rainbow
(unless (package-installed-p 'rainbow-delimiters)
  (package-install 'rainbow-delimiters))
(add-hook 'foo-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Hydra
(use-package hydra)

;;Focus
;; (unless (package-installed-p 'focus)
;;   (package-install 'focus))
;; (focus-read-only-mode 1)

;; Dimmer
(use-package dimmer
  :config
  (dimmer-configure-which-key)
  (dimmer-configure-helm)
  (dimmer-mode t)
  :custom
  (dimmer-fraction 0.5)
  )

;; Helm
(use-package helm :straight t
  )
(use-package helm
  :ensure t
  :init
  :config
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (helm-mode 1)
  )


;; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-mode))

;; Help projectile
(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

;; Ivy
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;;Lsp
;; (unless (package-installed-p 'lsp-mode)
;;   (package-install 'lsp-mode))
;; (require 'lsp-mode)
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-l")
  :config
  (lsp-enable-which-key-integration t))



;;lang hooks
(add-hook 'c-mode-hook #'lsp)

;;helm lsp
					; (define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol)

;;Evil commentary
(use-package evil-commentary
  :config (evil-commentary-mode))

;;Flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;;Formater apheleia
(use-package apheleia
  :config (apheleia-global-mode +1))
;;Formater all the code
(use-package format-all)

;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode)
  (setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
  (setq savehist-file "~/.emacs-saves/tmp/savehist")
  )

;; Load last session
					; (use-package psession
					;   :config
					;   (psession-mode 1)
					;   (psession-savehist-mode 1))

;; Counsel
(use-package counsel
  :bind (("M-x" . counsel-M-x  )
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)


  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;;Which-key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :ensure t
  :config
  (setq which-key-idle-delay 0.3)
  (which-key-mode))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

;;Avy go to char
(use-package avy
  :init
  (global-set-key (kbd "C-;") 'avy-goto-char))


;; Company
(use-package company
  :init
  (global-company-mode)
  (global-set-key (kbd "<tab>") #'company-indent-or-complete-common)
  (with-eval-after-load 'company
    (define-key company-active-map
      (kbd "TAB")
      #'company-complete-common-or-cycle)
    (define-key company-active-map
      (kbd "<backtab>")
      (lambda ()
        (interactive)
        (company-complete-common-or-cycle -1))))
  )

;; Magit
(use-package magit
  :ensure t
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  )
(use-package evil-magit
  :after magit)

;; QuickRun
(use-package quickrun)

;; Nim lang
(use-package nim-mode
  :config
  ;; The `nimsuggest-path' will be set to the value of
  ;; (executable-find "nimsuggest"), automatically.
  (setq nimsuggest-path "~/.nimble/bin/nimsuggest")

  (defun my--init-nim-mode ()
    "Local init function for `nim-mode'."

    ;; Just an example, by default these functions are
    ;; already mapped to "C-c <" and "C-c >".
    (local-set-key (kbd "M->") 'nim-indent-shift-right)
    (local-set-key (kbd "M-<") 'nim-indent-shift-left)

    ;; Make files in the nimble folder read only by default.
    ;; This can prevent to edit them by accident.
    (when (string-match "/\.nimble/" (or (buffer-file-name) "")) (read-only-mode 1))

    ;; If you want to experiment, you can enable the following modes by
    ;; uncommenting their line.
    (nimsuggest-mode 1)
    ;; Remember: Only enable either `flycheck-mode' or `flymake-mode' at the same time.
    ;; (flycheck-mode 1)
    (flymake-mode 1)

    ;; The following modes are disabled for Nim files just for the case
    ;; that they are enabled globally.
    ;; Anything that is based on smie can cause problems.
    (auto-fill-mode 0)
    (electric-indent-local-mode 0)
    )

  (add-hook 'nim-mode-hook 'my--init-nim-mode)
  )

;; Auto pair *
(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode))

;; Markdown
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))

;; Alternative Help
(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; Save session
;; (use-package workgroups2
;;   :config
;;   (workgroups-mode 1))
(use-package nix-mode
  :config
  (nix-mode))

(use-package lua-mode
  :config
  (lua-mode))

(use-package luarocks)
;; (use-package prettier)
; Golang
;; (use-package go-mode)
;; (use-package dap-mode)
;; (use-package company-go :requires company)
;; (use-package counsel-gtags)
;; (use-package eldoc)
;; (use-package ggtags)
;; (use-package go-eldoc)
;; (use-package go-fill-struct)
;; (use-package go-gen-test)
;; (use-package go-guru)
;; (use-package go-impl)
;; (use-package go-rename)
;; (use-package go-tag)
;; (use-package godoctor)
;; (use-package popwin)

