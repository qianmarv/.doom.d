;;; lisp/init-org-roam.el -*- lexical-binding: t; -*-

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ac t)
  :custom
  (setq org-roam-directory (file-truename "~/Knowledger"))
  (org-roam-completion-everywhere t)
  (org-roam-db-autosync-mode)
  :bind (("C-c r l" . org-roam-buffer-toggle)
         ("C-c r f" . org-roam-node-find)
         ("C-c r i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point)))
