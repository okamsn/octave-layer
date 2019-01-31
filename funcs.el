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

(defun spacemacs/octave-beginning-of-defun (&optional arg)
  "Octave-specific `beginning-of-defun-function' (which see)."
  (interactive)
  (or arg (setq arg 1))
  ;; Move out of strings or comments.
  (when (octave-in-string-or-comment-p)
    (goto-char (octave-in-string-or-comment-p)))
  (letrec ((orig (point))
           (toplevel (lambda (pos)
                       (condition-case nil
                           (progn
                             (backward-up-list 1)
                             (funcall toplevel (point)))
                         (scan-error pos)))))
    (goto-char (funcall toplevel (point)))
    (when (and (> arg 0) (/= orig (point)))
      (setq arg (1- arg)))
    (forward-sexp (- arg))
    (and (< arg 0) (forward-sexp -1))
    (/= orig (point))))



(defun spacemacs/octave-add-breakpoint ()
  "Add a breakpoint to the curent line."
  (interactive))

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

(define-skeleton spacemacs/octave-insert-if
  "Insert if stmt" nil
  > "if (" _ ")\n"
  > ?\n
  (if spacemacs-octave-matlab-syntax-compatibility
        "end"
    "endif")
  ;; Indent line appropriately after inserting end.
  '(smie-indent-line)
  "\n")


(defun spacemacs/octave-insert-if-dwim ()
  "Insert an if statement. If region active, insert around region."
  (interactive)
  (if (region-active-p)
      (let ((beg (region-beginning))
            (end (+ (region-end) 1))) ; want to insert after region
        (goto-char beg)
        (insert "if (")
        (save-excursion
          (insert ")\n")
          (goto-char (+ end 6)) ; account for text inserted
          (insert "\n")
          (insert (if spacemacs-octave-matlab-syntax-compatibility
                      "end\n"
                    "endif\n"))
          (indent-region beg (point))))
    (let ((beg (point)))
      (insert "if (")
      (save-excursion
        (insert ")\n\n")
        (insert
         (if spacemacs-octave-matlab-syntax-compatibility
             "end\n"
           "endif\n"))
        (indent-region beg (point))))))

(defun spacemacs/octave-insert-if-else (&optional number-of-elseifs)
  "Insert an if-else block and indent properly. With an argument, insert NUMBER-OF-ELSEIFS many elseifs in between the if and else."
  (interactive "p")
  (let ((beg (point)))
  (insert "if (")
  (save-excursion
   (insert ")\n\n")
   (if number-of-elseifs
       (dotimes (n number-of-elseifs nil) ;
         (insert "elif ()\n\n")))
   (insert "else\n\n")
   (insert (if spacemacs-octave-matlab-syntax-compatibility
               "end\n" "endif\n"))
   (indent-region beg (point)))))

(defun spacemacs/octave-insert-switch (&optional number-of-cases)
  "Insert an if-else block and indent properly. With an argument, insert NUMBER-OF-ELSEIFS many elseifs in between the if and else."
  (interactive "p")
  (let ((beg (point)))
    (insert "switch (")
    (save-excursion
      (insert ")\n")
      (if number-of-cases
          (dotimes (n number-of-cases nil) ;
            (insert "case ()\n\n")))
      (insert "otherwise\n\n")
      (insert (if spacemacs-octave-matlab-syntax-compatibility
                  "end\n" "endswitch\n"))
      (indent-region beg (point)))))

(defun spacemacs/octave-insert-for-dwim ()
  "Insert a 'for' block. If region active, insert around region."
  (interactive)
  (if (region-active-p)
      (let ((beg (region-beginning))
            (end (+ (region-end) 1))) ; want to insert after region
        (goto-char beg)
        (insert "for (")
        (save-excursion
          (insert ")\n")
          (goto-char (+ end 6)) ; account for text inserted
          (insert (if spacemacs-octave-matlab-syntax-compatibility
                      "\nend\n"
                    "\nendfor\n"))
          (indent-region beg (point))))
    (let ((beg (point)))
      (insert "for (")
      (save-excursion
        (insert ")\n\n")
        (insert
         (if spacemacs-octave-matlab-syntax-compatibility
             "end\n"
           "endfor\n"))
        (indent-region beg (point))))))

(defun spacemacs/octave-insert-while-dwim ()
  "Insert a 'while' block. If region active, insert around region."
  (interactive)
  (if (region-active-p)
      (let ((beg (region-beginning))
            (end (+ (region-end) 1))) ; want to insert after region
        (goto-char beg)
        (insert "while (")
        (save-excursion
          (insert ")\n")
          (goto-char (+ end 8)) ; account for text inserted
          (insert (if spacemacs-octave-matlab-syntax-compatibility
                      "\nend\n"
                    "\nendwhile\n"))
          (indent-region beg (point))))
    (let ((beg (point)))
      (insert "for (")
      (save-excursion
        (insert ")\n\n")
        (insert
         (if spacemacs-octave-matlab-syntax-compatibility
             "end\n"
           "endwhile\n"))
        (indent-region beg (point))))))
