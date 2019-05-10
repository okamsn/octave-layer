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

;; variables

(spacemacs|define-jump-handlers octave-mode)
;; (spacemacs|defvar-company-backends octave-mode)
(defvar spacemacs-octave-matlab-syntax-compatibility nil
  "Block skeletons end with keyword 'end' when non-nil, else use block specific keyword, e.g., 'endfunction'.")
