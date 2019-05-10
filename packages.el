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
  '((octave :location built-in)
    (company-octave :location local :toggle (configuration-layer/package-used-p 'company))
    (company :toggle (configuration-layer/layer-used-p 'autocompletion))
    (auto-complete :toggle (configuration-layer/layer-used-p 'auto-completion))
    (ac-helm :toggle (and (configuration-layer/package-used-p 'auto-complete)
                          (configuration-layer/layer-used-p 'helm)))
    (ac-octave :toggle (configuration-layer/package-used-p 'auto-complete))
    ;; ac-capf
    (ggtags :toggle (configuration-layer/layer-used-p 'gtags))
    (helm-gtags :toggle (and (configuration-layer/layer-used-p 'gtags)
                             (configuration-layer/layer-used-p 'helm)))
    ))

(defun octave/init-octave ()
  (use-package octave
    ;; :mode ("\\.m\\'" . octave-mode)
    :commands (run-octave)
    :init (progn
            ;; (ac-octave-setup)
            ;; (add-hook 'octave-mode-hook 'auto-complete-mode)
            ;; (add-hook 'octave-mode-hook 'ac-octave-init)
            (spacemacs/register-repl 'octave 'run-octave "octave"))))

;; (defun octave/-init-ac)
;; (defun octave/init-auto-complete ()
;;  (ac-config-default))

;; (defun octave/post-init-auto-complete ()
;;  (add-hook 'octave-mode-hook 'spacemacs//octave-switch-company-to-auto-complete))

;; (defun octave/init-ac-octave ()
;;  (ac-octave-setup))

;; (defun octave/post-init-ac-octave ()
;;  (add-hook 'octave-mode-hook 'ac-octave-init))

(when (configuration-layer/package-used-p 'ggtags)
  (defun octave/post-init-ggtags ()
    "Make sure gtags are enabled, if available."
    (add-hook 'octave-mode-local-vars-hook #'spacemacs/ggtags-mode-enable))

  (defun octave/post-init-helm-gtags ()
    "Make sure gtags in Helm are enabled, if available."
    (spacemacs/helm-gtags-define-keys-for-mode 'octave-mode)))

(defun octave/init-company-octave ()
  (use-package company-octave
    :defer t
    :init (spacemacs|add-company-backends
            :backends company-octave
            :mode octave-mode)))
