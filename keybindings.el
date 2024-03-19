
;;Fix scroll up
(global-set-key (kbd "C-u") 'evil-scroll-up)

;; Fast formating
(global-set-key (kbd "C-M-l") 'format-all-buffer)

;; Definer user name space
(general-create-definer kahasta/leader-keys
  :keymaps '(normal insert visual emacs)
  :prefix "SPC"
  :global-prefix "C-SPC")

(general-create-definer kahasta/ctrl-c-keys
  :prefix "C-c")

(defhydra hydra-text-scale (:timeout 4)
  "Scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t)
  )

;; Leader keys
(kahasta/leader-keys
  ;; Toggles
  "t" '(:ignore t :which-key "toggles")
  "tt" '(counsel-load-theme :which-key "choose theme")
  "ts" '(hydra-text-scale/body :which-key "scale text")
  ;; Buffers
  "b" '(:ignore t :which-key "buffers")
  "bb" '(switch-to-buffer :which-key "choose buffer")
  "bk" '(kill-this-buffer :which-key "kill this buffer")
  "TAB" '(switch-to-next-buffer :which-key "next buffer")
  ;; Code actions
  "l" '(:ignore t :which-key "code")
  "lf" '(format-all-buffer :which-key "format all")
  "lr" '(quickrun :which-key "run code")
  ;; Open
  "o" '(:ignore t :which-key "open")
  "or" '(recentf-open-files :which-key "open recent files")
  "oc" '((lambda() (interactive)( open-directory "~/.emacs.d/")) :which-key "~/.emacs.d/")
  "op" '((lambda() (interactive)( open-directory "~/Projects/")) :which-key "Projects")
  "ol" '((lambda() (interactive)( open-directory "~/.config/")) :which-key "~/.config/")
  "os" '(eshell :which-key "open eshell")

  ;; Magit
  "g" '(:ignore t :which-key "git")
  "gs" '(magit-status :which-key "status")
  "gd" '(magit-diff-unstaged :which-key "diff unstaged")
  "gc" '(magit-branch-or-checkout :which-key "branch or checkout")

  "gl" '(:ignore t :which-key "log")
  "glc" '(magit-log-current :which-key "log current")
  "glf" '(magit-log-buffer-file :which-key "log buffer line")

  "gb" '(magit-branch :which-key "branch")
  "gP" '(magit-push-current :which-key "push current")
  "gp" '(magit-pull-branch :which-key "pull branch")
  "gf" '(magit-fetch :which-key "fetch")
  "gF" '(magit-fetch-all :which-key "fetch all")
  "gr" '(magit-rebase :which-key "rebase")

  "w" '(save-buffer :which-key "save buffer")
  "c" '(kill-this-buffer :which-key "close")

  )

;; (kahasta/ctrl-c-keys
;;   )
