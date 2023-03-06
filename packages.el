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

;; Evil leader
(use-package evil-leader
  :init
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  )

;; Download evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable evil
(require 'evil)
(evil-mode 1)

;;Rainbow
(unless (package-installed-p 'rainbow-delimiters)
  (package-install 'rainbow-delimiters))
(add-hook 'foo-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Dired+


;;Focus
(unless (package-installed-p 'focus)
  (package-install 'focus))
(focus-read-only-mode 1)

;;Helm
;; (use-package helm :straight t
;;   )
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
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Counsel 
(use-package counsel
  :bind (("M-x" . counsel-M-x)
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

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

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
  (global-set-key (kbd "C-:") 'avy-goto-char))


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
  :ensure t)

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
