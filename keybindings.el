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
  "bc" #'smie-close-block
  "bm" #'octave-mark-block
  ;; helpers
  "hh" #'octave-help
  "hi" #'octave-lookfor
  ;; REPL
  "#'" #'run-octave
  "sb" #'octave-send-buffer
  "sp" #'octave-send-block
  "sf" #'octave-send-defun
  "si" #'run-octave
  "sl" #'octave-send-line
  "sr" #'octave-send-region
  ;; gotos
  "gD" #'octave-find-definition
  "gn" #'octave-next-code-line
  "gp" #'octave-previous-code-line
  "ge" #'octave-end-of-line
  "ga" #'octave-beginning-of-line
  ;; insert
  "iF" #'octave-insert-defun
  "in" #'octave-indent-new-comment-line
  "ii" #'spacemacs/octave-insert-if
  "ie" #'spacemacs/octave-insert-if-else
  "if" #'spacemacs/octave-insert-for
  "is" #'spacemacs/octave-insert-switch
  "ic" #'spacemacs/octave-insert-case
  "iw" #'spacemacs/octave-insert-while
  ;; REPL buffer controls
  "rf" #'run-octave
  "rs" #'octave-show-process-buffer
  "rd" #'octave-hide-process-buffer
  "rk" #'octave-kill-process
  ;; search
  ;; "sr" #'
  ;; Toggles
  "Te" #'spacemacs/toggle-octave-echo-input
  "Ts" #'spacemacs/toggle-octave-show-on-input
  "Tm" #'spacemacs/toggle-octave-matlab-syntax-compatibility)
