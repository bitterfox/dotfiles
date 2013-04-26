
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
(setq-default tab-width 4 indent-tabs-mode nil)

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
