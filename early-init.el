(setq gc-cons-threshold (* 500 1024 1024))
(setq package-enable-at-startup nil
      inhibit-startup-message t
      frame-resize-pixelwise t
      package-native-compile t)




(unless (fboundp 'package-activate-all) (package-initialize))
(setq package-enable-at-startup nil)

(load "~/.emacs.d/packages.el")
(load "~/.emacs.d/custom.el")
(load "~/.emacs.d/themes.el")
(load "~/.emacs.d/keybindings.el")
(load "~/.emacs.d/fonts.el")
