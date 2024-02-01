;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 14))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)
(global-display-line-numbers-mode)


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;

(map! :leader
      (:desc "Save file"
       :nv "SPC" #'save-buffer)
      (:desc "Switch to previous buffer"
       :n "TAB" #'evil-switch-to-windows-last-buffer)
      (:desc "Kill buffer"
       :n "wq" #'kill-this-buffer))


(after! org
  (setq org-agenda-files (list "~/org" "~/dev")))

(map! :n "J" "ddp" :desc "Move selected text down"
      :n "K" "ddkP" :desc "Move selected text up")

(after! org
  (setq org-log-done 'time))

;; add timestamp to completed event even if it was created with org-capture
(after! org-capture
  (add-to-list 'org-capture-templates
               '("t" "Todo with timestamp" entry
                 (file+headline "~/path/to/your/todo.org" "Tasks")
                 "* TODO %? %^g\nSCHEDULED: %t\n%i")))

(setq vscode-dark-plus-box-org-todo nil)

(setq mu4e-change-filenames-when-moving t)

;; Refresh mail using isync every 10 mins
(auth-source-pass-enable)
(setq ;; MU4E setup
 mu4e-update-interval(* 10 60)
 mu4e-get-mail-command "mbsync -a"
 mu4e-maildir "~/Mail"
 auth-source-debug t
 auth-source-do-cache nil
 auth-sources '(password-store)
 message-kill-buffer-on-exit t
 mu4e-attachment-dir "~/Downloads"
 send-mail-function 'smtpmail-send-it
 smtpmail-smtp-server "smtp.gmail.com"
 smtpmail-smtp-service 465
 smtpmail-stream-type 'ssl
 mu4e-drafts-folder "/[Gmail].Drafts"
 mu4e-sent-folder "/[Gmail].Sent Mail"
 mu4e-refile-folder "/[Gmail].All Mail"
 mu4e-trash-folder "/[Gmail].Trash"
 mu4e-maildir-shortcuts
 `(("/Inbox"                . ?i)
   ("/[Gmail].Sent Mail"    . ?s)
   ("/[Gmail].Trash"        . ?t)
   ("/[Gmail].Drafts"       . ?d)
   ("/[Gmail].All Mail"     . ?a)
   ))
