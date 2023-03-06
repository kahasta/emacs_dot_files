;; Open recent files
(global-set-key (kbd "C-c l") 'recentf-open-files)
;; Format buffer
(global-set-key (kbd "C-M-l") 'format-all-buffer)
;; Quckrun
(global-set-key (kbd "C-c r") 'quickrun)

;;Fix scroll up
(global-set-key (kbd "C-u") 'evil-scroll-up)

;; Open config
(global-set-key (kbd "C-c c") (lambda() (interactive) (open-directory "~/.emacs.d/")))
;; Open Projects
(global-set-key (kbd "C-c p") (lambda() (interactive) (open-directory "~/Projects")))
;; Open dot_files
(global-set-key (kbd "C-c .") (lambda() (interactive) (open-directory "~/.config/")))
;; Open eshell
(global-set-key (kbd "C-c t") 'eshell)

;; Leader keys
(evil-leader/set-key
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "n" 'switch-to-next-buffer
  "p" 'switch-to-prev-buffer
  )
