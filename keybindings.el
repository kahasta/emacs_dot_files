
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

;; Leader keys
(kahasta/leader-keys
  "t" '(:ignore t :which-key "toggles")
  "tt" '(counsel-load-theme :which-key "choose theme")
  "ts" '(eshell :which-key "run eshell")

  "b" '(:ignore t :which-key "buffers")
  "bb" '(switch-to-buffer :which-key "choose buffer")
  "bk" '(kill-this-buffer :which-key "kill this buffer")
  "TAB" '(switch-to-next-buffer :which-key "next buffer")

  "c" '(:ignore t :which-key "code")
  "cf" '(format-all-buffer :which-key "format all")
  "cr" '(quickrun :which-key "run code")

  "o" '(:ignore t :which-key "open")
  "or" '(recentf-open-files :which-key "open recent files")
  "oc" '((lambda() (interactive)( open-directory "~/.emacs.d/")) :which-key "~/.emacs.d/")
  "op" '((lambda() (interactive)( open-directory "~/Projects/")) :which-key "Projects")
  "ol" '((lambda() (interactive)( open-directory "~/.config/")) :which-key "~/.config/")
  "os" '(eshell :which-key "open eshell")
  )

;; (kahasta/ctrl-c-keys
;;   )
