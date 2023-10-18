;;; init-org.el --- Org-Mode Customizing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(setq org-directory "~/Org/")

(setq org-clock-clocked-in-display 'frame-title)

(defun my-org/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets."
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(defun my-org/org-refile-anywhere (&optional goto default-buffer rfloc msg)
  "A version of `org-refile' which allows refiling to any subtree."
  (interactive "P")
  (let ((org-refile-target-verify-function))
    (org-refile goto default-buffer rfloc msg)))

(defun my-org/org-agenda-refile-anywhere (&optional goto rfloc no-update)
  "A version of `org-agenda-refile' which allows refiling to any subtree."
  (interactive "P")
  (let ((org-refile-target-verify-function))
    (org-agenda-refile goto rfloc no-update)))

;; Incompatiable change after Orgmode upgrade to v9.1
;; https://stackoverflow.com/questions/22720526/set-clock-table-duration-format-for-emacs-org-mode
(setq org-duration-format (quote h:mm))
;; Different Apps to Be Called Under Different OS Platform
;;   Win: Powershell Tool https://github.com/Windos/BurntToast


;; org-download already sufficient
(setq-default org-download-image-dir "./IMG")

(setq my-org/gtd-directory "~/Org/GTD")

(defmacro my-org/expand-template (name)
  "Expand template NAME to full path."
  (concat my-org/gtd-directory "/templates/" name ".tpl"))

(defun my-org/make-notebook (name)
  "Make notebook NAME to full path. TODO create the notebook if NOT exist."
  (concat my-org/gtd-directory "/" name ".org"))

;; The function defined to adapt same configuration for spacemacs inside package.el
(defun my-org/post-init-org ()
  (add-hook 'org-mode-hook (lambda ()
                             (add-hook 'before-save-hook 'time-stamp)) 'append)

  (with-eval-after-load 'org
    (progn
      (require 'org-compat)
      (require 'org)
      (require 'org-habit)

      (auto-fill-mode)
      (visual-line-mode)

      ;; Enable publish taskjuggler
      ;; https://orgmode.org/worg/exporters/taskjuggler/ox-taskjuggler.html
;;       (require 'ox-taskjuggler)

;;       (setq org-taskjuggler-reports-directory "~/Org/TaskJuggler/reports")
;;       ;;https://hugoideler.com/2018/09/org-mode-and-wide-taskjuggler-html-export/
;;       (setq org-taskjuggler-default-reports
;;             '("textreport report \"Plan\" {
;;   formats html
;;   header '== %title =='
;;   center -8<-
;;     [#Plan Plan] | [#Resource_Allocation Resource Allocation]
;;     ----
;;     === Plan ===
;;     <[report id=\"plan\"]>
;;     ----
;;     === Resource Allocation ===
;;     <[report id=\"resourceGraph\"]>
;;   ->8-
;; }
;; # A traditional Gantt chart with a project overview.
;; taskreport plan \"\" {
;;   headline \"Project Plan\"
;;   columns bsi, name, start, end, resources, complete, effort, effortdone, effortleft, chart { width 1000 }
;;   loadunit shortauto
;;   hideresource 1
;; }
;; # A graph showing resource allocation. It identifies whether each
;; # resource is under- or over-allocated for.
;; resourcereport resourceGraph \"\" {
;;   headline \"Resource Allocation Graph\"
;;   columns no, name, effort, weekly { width 1000 }
;;   loadunit shortauto
;;   hidetask ~(isleaf() & isleaf_())
;;   sorttasks plan.start.up
;; }"))

;;       (setq org-taskjuggler-valid-task-attributes '(account start note duration endbuffer endcredit end flags journalentry length limits maxend maxstart minend minstart period reference responsible scheduling startbuffer startcredit statusnote chargeset charge priority))

;;       (setq org-taskjuggler-valid-resource-attributes '(limits vacation shift booking efficiency journalentry rate workinghours flags leaves))
      ;; Resume Clocking Task On Clock-in If The Clock Is Open
      (setq org-clock-in-resume t)

      ;; Resume Clocking Task When Emacs Is Restarted
      (org-clock-persistence-insinuate)

      ;; Save The Running Clock And All Clock History When Exiting Emacs, Load It On Startup
      (setq org-clock-persist t)

      ;; Do Not Prompt To Resume An Active Clock
      (setq org-clock-persist-query-resume nil)

      ;; Set Agenda Span to Daily by Default
      (setq org-agenda-span 'day)

      ;; Set Start Day as Today for Agenda View
      (setq org-agenda-start-day nil)

      ;; Removes Clocked Tasks With 0:00 Duration
      (setq org-clock-out-remove-zero-time-clocks t)

      ;; Set Org Clock, Change default leve from 2 to 3
      (setq org-clock-clocktable-default-properties '(:maxlevel 4 :scope file))

      ;; When Setting This Variable To nil,
      ;; 'a_b' Will Not Be Interpreted As A Subscript, But 'a_{b}' Will.
      ;; Default value is t
      (setq org-export-with-sub-superscripts nil)

      ;; Active Org-babel languages
     (org-babel-do-load-languages
      'org-babel-load-languages
      '(;; other Babel languages
        ;; Config plantuml
        ;; http://archive.3zso.com/archives/plantuml-quickstart.html
        (plantuml . t)
        (ditaa . t)
        (python . t)
        (perl . t)
        (ruby . t)
        (R . t)
        (shell . t)
        (gnuplot . t)
        (org . t)
        (latex . t)
        (java . t)
        (emacs-lisp . t)
        ;; (racket . t)
        (calc . t)
        (sql . t)
        (dot . t)
        ))
      ;; ;; Config plantuml path
      (setq plantuml-default-exec-mode 'jar)

      ;; Setup for GTD
      ;; Refer to http://www.i3s.unice.fr/~malapert/org/tips/emacs_orgmode.html
      (setq org-todo-keywords
            (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
                    (sequence "PROJECT" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
                    (sequence "STARTED(s)" "WAITING(w@/!)" "DELEGATED(e!)" "HOLD(h)" "|" "CANCELLED(c@/!)")))
            org-todo-repeat-to-state "TODO")

      (setq org-todo-keyword-faces
            '(("NEXT" . (:foreground "IndianRed1" :weight bold))
              ("STARTED" . (:foreground "OrangeRed" :weight bold))
              ("WAITING" . (:foreground "coral" :weight bold)) 
              ("CANCELED" . (:foreground "LimeGreen" :weight bold))
              ("DELEGATED" . (:foreground "LimeGreen" :weight bold))
              ("SOMEDAY" . (:foreground "LimeGreen" :weight bold))
              ))
      ;; (setq org-tag-persistent-alist
      ;;       '((:startgroup . nil)
      ;;         ("G@2019_EfficientWork" . ?e)
      ;;         ("G@2019_DevExpert" . ?d)
      ;;         ("G@2019_BizExpert" . ?b)
      ;;         (:endgroup . nil)
      ;;         ;; (:startgroup . nil)
      ;;         ;; ("EASY" . ?e)
      ;;         ;; ("MEDIUM" . ?m)
      ;;         ;; ("HARD" . ?a)
      ;;         ;; (:endgroup . nil)
      ;;         ;; ("URGENT" . ?u)
      ;;         ;; ("KEY" . ?k)
      ;;         ;; ("BONUS" . ?b)
      ;;         )
      ;;       )

      ;; (setq org-tag-faces
      ;;       '(
      ;;         ("G@2019_EfficientWork" . (:foreground "GoldenRod" :weight bold))
      ;;         ("G@2019_DevExpert" . (:foreground "GoldenRod" :weight bold))
      ;;         ("G@2019_BizExpert" . (:foreground "GoldenRod" :weight bold))
      ;;         ("G@2019_MSE2020" . (:foreground "Red" :weight bold))
      ;;         ("G@2019_SelfMastery" . (:foreground "Red" :weight bold))
      ;;         ("@2019_Emacsen" . (:foreground "Red" :weight bold))
      ;;         ("@2019_Health" . (:foreground "OrangeRed" :weight bold))
      ;;         ("G@2019_Education" . (:foreground "OrangeRed" :weight bold))
      ;;         ("G@2019_Trip" . (:foreground "OrangeRed" :weight bold))
      ;;         ("G@2019_Decorate" . (:foreground "OrangeRed" :weight bold))
      ;;         ;; ("BONUS" . (:foreground "GoldenRod" :weight bold))
      ;;         )
      ;;       )


;;; Refiling

      (setq org-refile-use-cache nil)

      ;; Targets include this file and any file contributing to the agenda - up to 5 levels deep
      (setq org-refile-targets '((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5)))

      (add-to-list 'org-agenda-after-show-hook 'org-show-entry)

      ;; (advice-add 'org-refile :after (lambda (&rest _) (org-save-all-org-buffers)))

      ;; Exclude DONE state tasks from refile targets

      (setq org-refile-target-verify-function 'my-org/verify-refile-target)

      ;; Targets start with the file name - allows creating level 1 tasks
      ;;(setq org-refile-use-outline-path (quote file))
      (setq org-refile-use-outline-path t)
      (setq org-outline-path-complete-in-steps nil)

      ;; Allow refile to create parent tasks with confirmation
      (setq org-refile-allow-creating-parent-nodes 'confirm)


      ;; (setq org-enable-priority-commands t)
      ;; --------------------------------------------------------------------
      ;; Encypting files or org
      ;; https://orgmode.org/worg/org-tutorials/encrypting-files.html
      ;; Below solve error: signing failed: Inappropriate ioctl for device 
      ;; https://d.sb/2016/11/gpg-inappropriate-ioctl-for-device-errors
      ;; --------------------------------------------------------------------
      ;; (require 'epa-file)
      ;; (epa-file-enable)
      (setq epa-file-select-keys nil) 
      (require 'org-crypt)

      (when (my/is-mac)
        (custom-set-variables '(epg-gpg-program  "/usr/local/bin/gpg")))
      (when (my/is-linux)
        (custom-set-variables '(epg-gpg-program  "/usr/bin/gpg")))
      (when (my/is-win)
        (custom-set-variables '(epg-gpg-program "C:/Program Files (x86)/GnuPG/bin/gpg")))

      (org-crypt-use-before-save-magic)
      (setq org-tags-exclude-from-inheritance (quote ("crypt" "P@story" "P@backlog")))
      ;; GPG key to use for encryption
      ;; Either the Key ID or set to nil to use symmetric encryption.
      ;; 

      ;; (setq org-crypt-key "AC88F93004D199BC") ;
      (setq org-crypt-key nil)

      (let* ((journal-book (my-org/make-notebook "Journal"))
             (inbox-book (my-org/make-notebook "Inbox"))
             (capture-book (my-org/make-notebook "Event"))
             (agenda-book (my-org/make-notebook "Agenda"))
             (project-book (my-org/make-notebook "Projects")))

        (setq org-capture-templates
              `(
                ("j" "Journals, Morning Write" entry
                 (file+olp+datetree ,journal-book) "* Morning Write\n%U\n%?" :tree-type week)
                ("d" "Daily Review"  entry
                 (file+olp+datetree ,journal-book) (file ,(my-org/expand-template "daily_review"))  :clock-in t :clock-resume t  :tree-type week :time-prompt t)
                ("b" "Break / Interrupt" entry
                 (file+headline ,agenda-book "Unplanned") "* DONE %?\n%U %i\n" :clock-in t :clock-resume t)
                ("c" "Collect/Capture")
                ("cn" "Take Notes" entry
                 (file+headline ,capture-book "Notes") "* %^{Note Title}\nNote taken on %U \\\\\n%?\n%K")
                ("ci" "Capture Ideas/Mighty new todos" entry
                 (file+headline ,capture-book "Ideas")  "* TODO %?\n %i\n")
                ("cb" "Books want Read" entry
                 (file+headline ,capture-book "Books") (file ,(my-org/expand-template "book")))
                ("cm" "Movies want Watch" entry
                 (file+headline ,capture-book "Movies") (file ,(my-org/expand-template "movie")))
                ("r" "Review")
                ("rf" "Free Review"  entry
                 (file+olp+datetree ,journal-book) "* %^{Review Title}\n Review at %U \n?" :tree-type week :time-prompt t)
                ("rw" "Weekly Review"  entry
                 (file+olp+datetree ,journal-book) (file ,(my-org/expand-template "weekly_review")) :tree-type week :time-prompt t)
                ("rm" "Monthly Review"  entry
                 (file+olp+datetree ,journal-book) (file ,(my-org/expand-template "monthly_review")) :tree-type week :time-prompt t))))

      (setq org-agenda-compact-blocks nil)
      ;;      (spacemacs/set-leader-keys "'" 'my-org/insert-screenshot)
      ;; Re-align tags when window shape changes
      (add-hook 'org-agenda-mode-hook
                (lambda ()
                  (add-hook 'window-configuration-change-hook 'org-agenda-align-tags nil t)
                  ))
      ;;
      ;; Setup Publish
      (require 'ox-publish)
      (setq org-pandoc-options-for-latex-pdf '((pdf-engine . "xelatex")))

      (setq org-agenda-include-diary t
            diary-file (concat my-org/gtd-directory "/diary.org")
            org-agenda-diary-file 'diary-file)
      )))

(after! org
  (my-org/post-init-org))

(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c j") 'org-capture)
(define-key global-map (kbd "C-c l") 'org-store-link)

;; Configuration for super agenda

;; (use-package! org-super-agenda
;;   :after org-agenda
;;   :init
;;   (setq org-super-agenda-groups
;;         '((:name "Clocked Today"
;;            :log t)
;;           (:name "Time Grid"
;;            :time-grid t)
;;           (:name "Current Focus "
;;            :todo "STARTED")
;;           (:name "Track Habits "
;;            :habit t)
;;           (:name "Due today "
;;            :deadline today)
;;           (:name "Scheduled Today"
;;            :scheduled today)
;;           (:name "Overdue "
;;            :deadline past)
;;           (:name "Due soon "
;;            :deadline future)
;;           (:name "Scheduled earlier "
;;            :scheduled past)
;;           (:name "Scheduled this week"
;;            :scheduled future)
;;           ))
;;   :config
;;   (org-super-agenda-mode))

;; (setq org-ellipsis "⤵")

;; Org-roam setting
(setq org-roam-directory (file-truename "~/Org/Roam"))
(use-package! org-roam
  :after org
  :init
  :config
  (setq org-roam-db-node-include-function
        (lambda ()
          (not (member "ATTACH" (org-get-tags))))))
;; :commands
;; (org-roam-completion-everywhere t)
;; (org-roam-db-autosync-mode))

;; Deft
;; (setq deft-directory "~/Org/Roam")
;; (use-package! deft
;;   :after org
;;   :init
;;   :config
;;   (setq deft-recursive t))

(provide 'init-org)
;;; init-org.el ends here
