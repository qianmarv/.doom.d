;;; lisp/init-code.el -*- lexical-binding: t; -*-
;;; Commentary:
;; Programming language specific configurations
;;; Code:

;; 这里可以添加编程语言相关的配置
;; 例如：
;; - LSP 配置
;; - 语言特定的 hooks
;; - 代码格式化设置
;; - 调试配置等

;; 示例：Python 配置
;; (after! python
;;   (setq python-shell-interpreter "python3"))

;; 示例：JavaScript/TypeScript 配置
;; (after! js2-mode
;;   (setq js2-basic-offset 2))

(provide 'init-code)
;;; init-code.el ends here
