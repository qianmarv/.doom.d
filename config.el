;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;; References
;; - https://github.com/hlissner/doom-emacs-private/blob/master/config.el
;; - https://github.com/purcell/emacs.d
;; - https://github.com/syl20bnr/spacemacs


(setq user-full-name "Marvin Qian"
      user-mail-address "qianmarv@gmail.com"
      epa-file-encrypt-to user-mail-address

      ;; If you want to change the style of line numbers, change this to `relative' or
      ;; `nil' to disable it:
      ;; Line numbers are pretty slow all around. The performance boost of
      ;; disabling them outweighs the utility of always keeping them on.
      display-line-numbers-type nil

      ;; On-demand code completion. I don't often need it.
      company-idle-delay nil

      ;; lsp-ui-sideline is redundant with eldoc and much more invasive, so
      ;; disable it by default.
      lsp-ui-sideline-enable nil
      lsp-enable-indentation nil
      lsp-enable-on-type-formatting nil
      lsp-enable-symbol-highlighting nil
      lsp-enable-file-watchers nil

      ;; Disable help mouse-overs for mode-line segments (i.e. :help-echo text).
      ;; They're generally unhelpful and only add confusing visual clutter.
      mode-line-default-help-echo nil
      show-help-function nil
      )

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)

(setq evil-default-state 'emacs)

;;; :editor evil
;; (setq evil-split-window-below t
;;       evil-vsplit-window-right t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Org Related Settings
;; If you intend to use org, it is recommended you change this!

(add-to-list 'load-path (expand-file-name "lisp" doom-private-dir))

;; Private Utilities
(require 'init-util)

;; Org related configurations
(require 'init-org)

;; Programming Related Settings
;;
;; Set default scheme implementation program
;; (setq scheme-program-name "racket")
;; (setq geiser-scheme-implementation "racke")
;; (setq geiser-active-implementations '(racket))


;; Somehow with DOOM, default info directory was not correct
(setq Info-directory-list '("/usr/local/share/info"))
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(org-agenda-files
;;    (quote
;;     ("~/Org/GTD/Work.org" "~/Org/GTD/Projects.org" "~/Org/GTD/Habit.org" "~/Org/GTD/Event.org" "~/Org/GTD/Agenda.org" "/home/qianmarv/Org/Principle.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
