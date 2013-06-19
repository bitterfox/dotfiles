
(setq load-path
      (append
       '("~/.emacs.d/auto-install")
       load-path))

;; emacsに関する基本設定
;; タイトルバーをファイル名に
(setq frame-title-format "%b")

;; メニューバーを表示しない
(menu-bar-mode 0)

;; 起動時の画面を表示しない
(setq inhibit-startup-message t)

;; 行数，列数表示
(line-number-mode t)
(column-number-mode t)

;; タブ幅の設定
;;(setq-default tab-width 4 indent-tabs-mode nil)

;;(add-hock 'c-mode-common-hock
;;              '(lambda ()
;;                 (c-set-style "bsd")
;;                 (setq c-basic-offset 4)
;;                 (setq indent-tabs-mode nil)
;;))
 (add-hook 'c-mode-common-hook
                '(lambda ()
                  (c-set-style "bsd")
;; ;              (setq c-indent-level 0)
;; ;              (setq c-brace-offset 0)
;; ;              (setq c-continued-statement-offset 0)
;; ;              (setq c-tab-width 4)
                  (setq c-basic-offset 4)
;; ;              (setq tab-width 4)
                  (setq indent-tabs-mode nil)
 ))

;; Emacs標準のオートセーブを無効化
(setq backup-inhibited t)
(setq delete-auto-save-files t)

;; #のバックアップファイルを作成しない
(setq make-backup-files nil)

;; 最終行に必ず一行挿入
(setq require-final-newline t)

;; ウインドウモードの際の設定
(if window-system
    (progn
      ;; ツールバーを表示しない
      (tool-bar-mode 0)

      ;; スクロールバーを左に表示
      (set-scroll-bar-mode nil)
))

;; スペースとタブを表示
(defface my-face-b-1 '((t (:background "gray"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append))))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; C-hをbackspaceに
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

;; 行末で折り返す
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; 圧縮されたファイルも編集できるようにする
(auto-compression-mode t)

;; 同名ファイルのバッファ名を識別できるようにする
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; コピーをクリップボードと共有する
(cond (window-system
       (setq x-select-enable-clipboard t)
       ))

;; デフォルトブラウザ変更
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")
(when (eq system-type 'darwin)
  (add-to-list 'exec-path "/usr/local/bin")
  (setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"))

;; ;; 対応する括弧をハイライト
;; (show-paren-mode t)
;; (setq show-paren-style 'expression)
;; (set-face-background 'show-paren-match-face "gray15")
;; (set-face-foreground 'show-paren-match-face "white")

;; auto-installの設定
(when (require 'auto-install nil t)

  ;;EmacsWikiに登録されているelispの名前を取得する
  (auto-install-update-emacswiki-package-name t)

  ;;install-elispの関数を利用可能にする
  (auto-install-compatibility-setup))

;; package.elの設定
(when (require 'package nil t)

  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives
               '("ELPA" . "http://tromey.com/elpa/"))
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/"))

  ;;インストールしたパッケージにロードパスを通して読み込む
  (package-initialize))

;; color-themeの設定
(require 'color-theme)
(color-theme-calm-forest)

;; auto-save-buffer-enhanced
(require 'auto-save-buffers-enhanced)
(auto-save-buffers-enhanced-include-only-checkout-path t)
(auto-save-buffers-enhanced t)

;; sudden-death
(require 'sudden-death)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete")
(setq ac-comphist "~/.emacs.d/auto-complete")
(setq ac-delay 0.1)
(setq ac-auto-show-menu 0.2)
(setq ac-use-menu-map t)
(setq ac-use-fuzzy t)

;; linux
(require 'linum)
(global-linum-mode t)
(setq linum-format "%4d")

;; cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; git-gutter-fringe
(require 'git-gutter-fringe)
(global-git-gutter-mode t)

;; haskell-mode
(require 'haskell-mode)
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; org-mode
(setq org-export-latex-coding-system 'utf-8)
(setq org-export-latex-date-format "%Y-%m-%d")
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
  '("jarticle"
    "\\documentclass[a4j]{jsarticle}"
    ("\\section{%s}" . "\\section*{%s}")
    ("\\subsection{%s}" . "\\subsection*{%s}")
    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
    ("\\paragraph{%s}" . "\\paragraph*{%s}")
    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
))
(add-to-list 'org-export-latex-classes
  '("jreport"
    "\\documentclass[report]{jsbook}"
    ("\\chapter{%s}" . "\\chapter*{%s}")
    ("\\section{%s}" . "\\section*{%s}")
    ("\\subsection{%s}" . "\\subsection*{%s}")
    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
    ("\\paragraph{%s}" . "\\paragraph*{%s}")
    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
))

;; twittering-mode読み込み
(require 'twittering-mode)
;; 起動時パスワード認証 *要 gpgコマンド
(setq twittering-use-master-password t)
;; 表示する書式 区切り線いれたら見やすい
(setq twittering-status-format "%i @%s %S %p: \n%T  [%@]%r %R %f%L\n -------------------------------------------")
;; アイコンを表示する
(setq twittering-icon-mode t)
;; アイコンサイズを変更する *48以外を希望する場合 要 imagemagickコマンド
;; (setq twittering-convert-fix-size 40)
;; 更新の頻度（秒）
(setq twittering-timer-interval 20)
;; ツイート取得数
(setq twittering-number-of-tweets-on-retrieval 50)

;; json-mode
(require 'json-mode)
