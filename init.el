;; -*- lexical-binding: t; -*-
;; Emacs comes with package.el for installing packages.
;; Try M-x list-packages to see what's available.

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; setup.el provides a macro for configuration patterns
;; it makes package installation and config nice and tidy!
;; https://www.emacswiki.org/emacs/SetupEl
(if (package-installed-p 'setup)
    nil
  (if (memq 'setup package-archive-contents)
      nil
    (package-refresh-contents))
  (package-install 'setup))
(require 'setup)

;; All other features are loaded one by one from
;; the customizations directory. Read those files
;; to find out what they do.
(add-to-list 'load-path "~/.emacs.d/customizations")

(defvar addons
  '("ui.el"
    "navigation.el"
    "projects.el"
    "git.el"
    "filetree.el"
    "editing.el"
    "elisp-editing.el"
    "setup-clojure.el"
    "setup-js.el"
    "shell-integration.el"))

(dolist (x addons)
  (load x))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

(require 'evil)
(evil-mode 1)

(evil-define-key 'normal 'global
  (kbd "j") 'evil-next-visual-line
  (kbd "k") 'evil-previous-visual-line)

;;Start maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;; Set transparency
(set-frame-parameter (selected-frame) 'alpha '(80 80))
(add-to-list 'default-frame-alist '(alpha 80 80))


;;Cider hotkeys
(add-hook 'clojure-mode-hook
          (lambda ()
            (local-set-key (kbd "s-j") 'cider-jack-in)))
(add-hook 'clojure-mode-hook
          (lambda ()
            (local-set-key (kbd "s-i") 'cider-inspect-last-result)))

;;icon fixes
(require 'all-the-icons-nerd-fonts)



