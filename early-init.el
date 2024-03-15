;;; early-init.el --- Early Init File -*- lexical-binding: t -*-

;; We'll let Elpaca take care of this later on, so we don't want
;; interference from use-package.el.
(setq package-enable-at-startup nil)

;; We'll wrap our init file inside a let, because on every .el and
;; .elc file loaded during startup, it has to run regexps against
;; the filename, which is highly inefficient.
;; With that being said, this alist is still useful and we do not
;; want it to be nil, so we'll restore it after loading everything.
(let ((default-file-name-handler-alist file-name-handler-alist)
      (file-name-handler-alist nil))

  ;; This is so the GC is called less often, thus reducing the number
  ;; of garbage collections (those are quite expensive!)
  (setq gc-cons-threshold most-positive-fixnum
        gc-cons-percentage 0.6)

  ;; Silence compiler warnings
  (setq warning-minimum-level :emergency
        warning-suppress-types '((comp))
        byte-compile-warnings '(not free-vars unresolved
                                    noruntime lexical
                                    make-local cl-functions))

  ;; Prevent unwanted runtime compilation for gccemacs
  ;; (native-comp) users; packages are compiled ahead-of-time
  ;; when they are installed and site files are compiled when
  ;; gccemacs is installed. Also, we're putting 
  (when (and (fboundp 'native-comp-available-p)
             (native-comp-available-p))
    (progn 
      (setq native-comp-async-report-warnings-errors nil)
      (if (version<= "29.1" emacs-version)
          (setq native-comp-jit-compilation nil
                native-comp-jit-compilation-deny-list nil)
        (setq native-comp-deferred-compilation nil
              native-comp-deferred-compilation-deny-list nil))))

  ;; Prevent the glimpse of un-styled Emacs by disabling these UI
  ;; elements early.
  (setq tool-bar-mode nil
        menu-bar-mode nil)
  (when (fboundp 'set-scroll-bar-mode)
    (set-scroll-bar-mode nil))

  ;; While we're here, let's also disable some more visual elements
  ;; from the default frame.
  (setq default-frame-alist
        (append
         (list
          '(min-height . 1)
          '(min-width  . 1)
          '(width  . 100)
          '(border-width . 0)
          '(vertical-scroll-bars . nil)
          '(horizontal-scroll-bars . nil)
          ;; '(internal-border-width . 16)
          '(tool-bar-lines . 0)
          '(menu-bar-lines . 0)
          ;; '(right-fringe . 8)
          ;; '(left-fringe . 8)
          '(menu-bar-lines . 0))))

  ;; (setq left-margin-width 1
  ;;       right-margin-width 1)

  ;; Ignore Xresources, since it will interfere with my theme down the
  ;; line.
  (advice-add #'x-apply-session-resources :override #'ignore)

  ;; Update Emacs UI more frequently.
  (setq idle-update-delay 0.1)

  ;; Inhibit loading the default library.
  (setq inhibit-default-init t)

  ;; Font compacting can be very expensive, so we'll disable it.
  (setq inhibit-compacting-font-caches t)

  ;; Resizing the frame can be very taxing on the init time, since it
  ;; has to resize and redraw the entire frame again.
  (setq frame-inhibit-implied-resize t)

  ;; Emacs by default resizes its frame so it rounds it according to
  ;; `frame-char-height' and `frame-char-width', which can leave ugly
  ;; gaps, especially on tiling window managers. Let's resize it
  ;; pixelwise, so maximizing works as intended.
  (setq frame-resize-pixelwise t)

  ;; Disable startup features
  (setq inhibit-splash-screen t
        inhibit-startup-screen t
        inhibit-startup-message t
        initial-scratch-message "")

  ;; In noninteractive sessions, prioritize non-byte-compiled source
  ;; files to prevent the use of stale byte-code. Otherwise, it saves
  ;; us a little IO time to skip the mtime checks on every *.elc file.
  (setq load-prefer-newer noninteractive)

  ;; Disable bidirectional text scanning
  (setq-default bidi-display-reordering 'left-to-right
  			        bidi-paragraph-direction 'left-to-right)

  (unless (version< emacs-version "27.0")
    (setq bidi-inhibit-bpa t))

  (add-hook 'emacs-startup-hook
            (lambda ()
              "Restore default values and display the loading time."
              (setq file-name-handler-alist
                    default-file-name-handler-alist)
              
              (setq gc-cons-threshold (* 20 1024 1024)
                    gc-cons-percentage 0.1)
              
              (let* ((before before-init-time)
                     (after after-init-time)
                     (time-passed (time-subtract after before)))
                (message "Emacs loaded in %s with %d garbage collection(s)."
                         (format "%.2f seconds" (float-time time-passed))
                         gcs-done)
                ))))


            

(provide 'early-init)
;;; early-init.el ends here
