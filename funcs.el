;;; funcs.el --- Octave Layer functions File for Spacemacs
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3


;;;; functions for toggles

(spacemacs|add-toggle octave-send-echo-input
  :documentation "Toggle whether submissions to the REPL are echoed back."
  :status octave-send-echo-input
  :if (eq major-mode 'octave-mode)
  :on (setq octave-send-echo-input t)
  :on-message "Will echo submissions to Octave RELP."
  :off (setq octave-send-echo-input nil))

(spacemacs|add-toggle octave-send-show-buffer
  :documentation "Toggle whether submissions to the REPL reveal the REPL's buffer."
  :status octave-send-show-buffer
  :if (eq major-mode 'octave-mode)
  :on (setq octave-send-show-buffer t)
  :on-message "Will reveal Octave REPL's buffer when submitting."
  :off (setq octave-send-show-buffer nil))

(spacemacs|add-toggle octave-matlab-syntax-compatability
  :documentation "Toggle whether comments and block insertions are MATLAB-compatible. Spacemacs specific."
  :if (eq major-mode 'octave-mode)
  :on (setq spacemacs-octave-matlab-syntax-compatibility t)
  :on-meassge "Using MATLAB compatible syntax settings"
  :off (setq spacemacs-octave-matlab-syntax-compatibility nil))

(defun spacemacs/toggle-octave-echo-input ()
  "Toggle whether input sent to Octave is echoed."
  (interactive)
  (if octave-send-echo-input
      (progn
        (setq octave-send-echo-input nil)
        (message "Won't echo submissions to Octave RELP."))
    (progn
      (setq octave-send-echo-input t)
      (message "Will echo submissions to Octave RELP."))))


(defun spacemacs/toggle-octave-show-on-input ()
  "Toggle whether sending input to Octave reveals its buffer."
  (interactive)
  (if octave-send-show-buffer
      (progn
        (setq octave-send-show-buffer nil)
        (message "Won't show Octave RELP on send."))
    (progn
      (setq octave-send-show-buffer t)
      (message "Will show Octave REPL on send."))))

(defun spacemacs/toggle-octave-matlab-syntax-compatibility ()
  "Toggle whether input sent to Octave is echoed."
  (interactive)
  (if spacemacs-octave-matlab-syntax-compatibility
      (progn
        (setq spacemacs-octave-matlab-syntax-compatibility
              nil)
        (message "Won't echo submissions to Octave RELP."))
    (progn
      (setq spacemacs-octave-matlab-syntax-compatibility
            t)
      (message "Will echo submissions to Octave RELP."))))

;;;; functions to enable auto-complete
(defun spacemacs//octave-switch-company-to-auto-complete ()
  (if (bound-and-true-p company-mode) (company-mode -1))
  (auto-complete-mode 1))


;;;; repl controls

(defun spacemacs/octave-switch-to-octave ()
  "Switch buffer focus to Octave REPL"
  (interactive)
  (switch-to-buffer "*Inferior Octave*"))


;;;; Functions to insert text

(defun spacemacs/octave-insert-if ()
  "Insert an 'if' block."
  (interactive)
  (end-of-line)
  (newline)
  (insert "if ")
  (prog-indent-sexp)
  (setq-local current-cursor-position
              (point))
  (newline)
  (if spacemacs-octave-matlab-syntax-compatibility
      (progn
        (insert "end")
        (prog-indent-sexp))
    (smie-close-block))
  (goto-char current-cursor-position)
  (evil-append))


(defun spacemacs/octave-insert-if-else ()
  "Insert an 'if-else' block."
  (interactive)
  (end-of-line)
  (newline)
  (insert "if ")
  (prog-indent-sexp)
  (setq-local current-cursor-position
              (point))
  (newline)
  (insert "else")
  (prog-indent-sexp)
  (newline)
  (if spacemacs-octave-matlab-syntax-compatibility
      (progn
        (insert "end")
        (prog-indent-sexp))
    (smie-close-block))
  (goto-char current-cursor-position)
  (evil-append))

(defun spacemacs/octave-insert-switch ()
  "Insert an 'switch' block."
  (interactive)
  (end-of-line)
  (newline)
  (insert "switch ")
  (prog-indent-sexp)
  (setq-local current-cursor-position
              (point))
  (newline)
  (insert "otherwise")
  (prog-indent-sexp)
  (newline)
  (if spacemacs-octave-matlab-syntax-compatibility
      (progn
        (insert "end")
        (prog-indent-sexp))
    (smie-close-block))
  (goto-char current-cursor-position)
  (evil-append))

(defun spacemacs/octave-insert-case ()
  "Insert a 'case' stament."
  (interactive)
  (end-of-line)
  (newline)
  (insert "case ")
  (prog-indent-sexp)
  (evil-append))

(defun spacemacs/octave-insert-for ()
  "Insert a 'for' block."
  (interactive)
  (end-of-line)
  (newline)
  (insert "for ")
  (prog-indent-sexp)
  (setq-local current-cursor-position
              (point))
  (insert " = ")
  (newline)
  (if spacemacs-octave-matlab-syntax-compatibility
      (progn
        (insert "end")
        (prog-indent-sexp))
    (smie-close-block))
  (goto-char current-cursor-position)
  (evil-append))

(defun spacemacs/octave-insert-while ()
  "Insert a 'while' block."
  (interactive)
  (end-of-line)
  (newline)
  (insert "while ")
  (prog-indent-sexp)
  (setq-local current-cursor-position
              (point))
  (newline)
  (if spacemacs-octave-matlab-syntax-compatibility
      (progn
        (insert "end")
        (prog-indent-sexp))
    (smie-close-block))
  (goto-char current-cursor-position)
  (evil-append))
