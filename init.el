;; Start server (not working...)
;; (server-start)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(tool-bar-mode -1)
(menu-bar-mode -1)

;; Font sets
(set-default-font "DejaVu Sans Mono 14")

;; Highlight indentation
;(load "~/.emacs.d/Highlight-Indentation-for-Emacs/highlight-indentation.el")
;(require 'highlight-indentation)
;(set-face-background 'highlight-indentation-face "#333333")
;(set-face-background 'highlight-indentation-current-column-face "#535353")
;(highlight-indentation-set-offset 1)

;(add-hook 'markdown-mode-hook 'highlight-indentation-mode)
;(add-hook 'python-mode-hook 'highlight-indentation-mode)
;(add-hook 'js2-mode-hook 'highlight-indentation-mode)

;; Markdown Mode
(autoload 'markdown-mode "~/.emacs.d/markdown-mode/markdown-mode"
   "Major mode for editing Markdown files" t)
(set 'markdown-enable-math t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Haskell Mode
;;(require 'package)
;;(add-to-list 'package-archives
;;             '("marmalade" . "http://marmalade-repo.org/packages/"))
;;(add-to-list 'package-archives
;;             '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(package-initialize)

;;(when (not (package-installed-p 'haskell-mode))
;;  (package-install 'haskell-mode))

(load "~/.emacs.d/haskell-mode/haskell-site-file")

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; (add-hook 'haskell-mode-hook 'highlight-indentation-mode)
;; (add-hook 'haskell-mode-hook 'highlight-indentation-current-column-mode)


(setq haskell-program-name "~/bin/pghci")
;; end of Haskell Mode

;; Monokai
(load-file "~/.emacs.d/el-monokai-theme/monokai-theme.el")

;; IDO
(require 'ido)
(ido-mode t)

;; IDO - sort by mtime
; sort ido filelist by mtime instead of alphabetically
(add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
(add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
(defun ido-sort-mtime ()
  (setq ido-temp-list
	(sort ido-temp-list
	      (lambda (a b)
		(time-less-p
		 (sixth (file-attributes (concat ido-current-directory b)))
		 (sixth (file-attributes (concat ido-current-directory a)))))))
  (ido-to-end  ;; move . files to end (again)
   (delq nil (mapcar
	      (lambda (x) (and (char-equal (string-to-char x) ?.) x))
	      ido-temp-list))))

(require 'recentf)

;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;; enable recent files mode.
(recentf-mode t)

; 50 files ought to be enough.
(setq recentf-max-saved-items 1000)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;;-------- VIM's *
;;(defun my-isearch-word-at-point ()
;;  (interactive)
;;  (call-interactively 'isearch-forward-regexp))
;;
;;(defun my-isearch-yank-word-hook ()
;;  (when (equal this-command 'my-isearch-word-at-point)
;;    (let ((string (concat "\\<"
;;                          (buffer-substring-no-properties
;;                           (progn (skip-syntax-backward "w_") (point))
;;                           (progn (skip-syntax-forward "w_") (point)))
;;                          "\\>")))
;;      (if (and isearch-case-fold-search
;;               (eq 'not-yanks search-upper-case))
;;          (setq string (downcase string)))
;;      (setq isearch-string string
;;            isearch-message
;;            (concat isearch-message
;;                    (mapconcat 'isearch-text-char-description
;;                               string ""))
;;            isearch-yank-flag t)
;;      (isearch-search-and-update))))
;;
;;(add-hook 'isearch-mode-hook 'my-isearch-yank-word-hook)
;;(global-set-key (kbd "C-*") 'my-isearch-word-at-point)

;;----------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))