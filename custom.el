;;; Custom --- My settings
;;; Commentary:
;;; Code:
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(blink-cursor-mode 0)
(setq visible-bell t)
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Display number lines
(column-number-mode)
(global-display-line-numbers-mode t)
;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
		prog-mode-hook
		conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Overide some modes which derive from the above
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook
		))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))



;; Auto pair for ()
(electric-pair-mode t)
(hl-line-mode -1)
(recentf-mode 1)
(setq history-length 25)
(savehist-mode 1)
(save-place-mode 1)

;; Open directory
(defun open-directory(path)
  "Open directory"
  (interactive)
  (find-file path)
  )
;; Off dialog gui
(setq use-dialog-box nil)
;; Auto update buffer if file is changed out emacs
(global-auto-revert-mode 1)
;; Auto update Dired and other buffers
(setq global-auto-revert-non-file-buffers t)
(setq backup-directory-alist '(("." . "~/.emacs-saves")
			       backup-by-copying t    ; Don't delink hardlinks
			       version-control t      ; Use version numbers on backups
			       delete-old-versions t  ; Automatically delete excess backups
			       kept-new-versions 20   ; how many of the newest versions to keep
			       kept-old-versions 5    ; and how many of the old
			       )
      )
