;;; packages.el --- Octave Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq octave-packages
      '(auto-complete
        ac-capf
        ac-helm
        ac-octave
        ggtags
        helm-gtags
        (octave :location built-in)))

(defun octave/init-octave ()
  (use-package octave
    :mode ("\\.m\\'" . octave-mode)
    :commands (run-octave)
    :init (progn
            ;; (ac-octave-setup)
            ;; (add-hook 'octave-mode-hook 'auto-complete-mode)
            ;; (add-hook 'octave-mode-hook 'ac-octave-init)
            (spacemacs/register-repl 'octave 'run-octave "octave"))
    :config (progn
              (spacemacs|defvar-company-backends octave-mode) ;; USE AC AS COMPANY BACKEN

             (spacemacs/declare-prefix-for-mode 'octave-mode "mb" "block controls")
             (spacemacs/declare-prefix-for-mode 'octave-mode "mh" "help")
             (spacemacs/declare-prefix-for-mode 'octave-mode "mi" "insert")
             (spacemacs/declare-prefix-for-mode 'octave-mode "mg" "goto")
             (spacemacs/declare-prefix-for-mode 'octave-mode "mm" "mark")
             (spacemacs/declare-prefix-for-mode 'octave-mode "mr" "REPL controls")
             (spacemacs/declare-prefix-for-mode 'octave-mode "ms" "submit/send")
             (spacemacs/declare-prefix-for-mode 'octave-mode "mT" "toggle")
             (spacemacs/set-leader-keys-for-major-mode 'octave-mode
              ;; block controls
              "bc" 'smie-close-block
              "bm" 'octave-mark-block
              ;; helpers
              "hh" 'octave-help
              "hi" 'octave-lookfor
              ;; REPL
              "'" 'run-octave
              "sb" 'octave-send-buffer
              "sp" 'octave-send-block
              "sf" 'octave-send-defun
              "si" 'run-octave
              "sl" 'octave-send-line
              "sr" 'octave-send-region
              ;; gotos
              "gD" 'octave-find-definition
              "gn" 'octave-next-code-line
              "gp" 'octave-previous-code-line
              "ge" 'octave-end-of-line
              "ga" 'octave-beginning-of-line
              ;; insert
              "iF" 'octave-insert-defun
              "in" 'octave-indent-new-comment-line
              "ii" 'spacemacs/octave-insert-if
              "ie" 'spacemacs/octave-insert-if-else
              "if" 'spacemacs/octave-insert-for
              "is" 'spacemacs/octave-insert-switch
              "ic" 'spacemacs/octave-insert-case
              "iw" 'spacemacs/octave-insert-while
              ;; REPL buffer controls
              "rf" 'run-octave
              "rs" 'octave-show-process-buffer
              "rd" 'octave-hide-process-buffer
              "rk" 'octave-kill-process
              ;; search
              ;; "sr" '
              ;; Toggles
              "Te" 'spacemacs/toggle-octave-echo-input
              "Ts" 'spacemacs/toggle-octave-show-on-input
              "Tm" 'spacemacs/toggle-octave-matlab-syntax-compatibility
              ))))

;; (defun octave/-init-ac)
(defun octave/init-auto-complete ()
  (ac-config-default))

(defun octave/post-init-auto-complete ()
  (add-hook 'octave-mode-hook 'spacemacs//octave-switch-company-to-auto-complete))

(defun octave/init-ac-octave ()
  (ac-octave-setup))

(defun octave/post-init-ac-octave ()
  (add-hook 'octave-mode-hook 'ac-octave-init))


(defun octave/post-init-ggtags ()
  "Make sure gtags are enabled, if available."
  (add-hook 'octave-mode-local-vars-hook #'spacemacs/ggtags-mode-enable))

(defun octave/post-init-helm-gtags ()
  "Make sure gtags in Helm are enabled, if available."
  (spacemacs/helm-gtags-define-keys-for-mode 'octave-mode))
