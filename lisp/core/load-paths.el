;;; core/load-paths.el --- Path names -*- lexical-binding: t; -*-

;; Copyright (c) 2024 Alecu Ștefan-Iulian

;; Author: Alecu Ștefan-Iulian <uneven-shiver@protonmail.com>
;; URL: https://github.com/stalecu/feather-emacs

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Define various PATH variables, and set up load path.

;;; Code:

(require 'xdg)

(defconst user-home-directory
  (expand-file-name "~/")
  "User home directory.")

;; ~/.config/emacs
(defvar ft/feather-directory
  (expand-file-name (concat
		     (file-name-directory (or load-file-name buffer-file-name))
		     "../../"))
  "Feather Emacs' start directory.")

;; ~/.config/emacs/lisp
(defconst ft/lisp-directory
  (expand-file-name "lisp" ft/feather-directory)
  "Feather Emacs' `lisp' directory.")

;; ~/.config/emacs/lisp/core
(defconst ft/core-directory
  (expand-file-name "core" ft/lisp-directory)
  "Feather Emacs' `core' directory.")

;; ~/.config/emacs/lisp/modules
(defconst ft/modules-directory
  (expand-file-name "modules" ft/lisp-directory)
  "Feather Emacs' `modules' directory. Used for the modules inside Feather Emacs (not `core').")

;; ~/.config/emacs/lisp/themes
(defconst ft/themes-directory
  (expand-file-name "themes" ft/lisp-directory)
  "Feather Emacs' `themes' directory. Used for custom themes and Feather Emacs-specific themes.")

(when (file-exists-p ft/themes-directory)
  (add-to-list 'custom-theme-load-path ft/themes-directory))

;; ~/.config/emacs/lisp/themes
(defconst ft/personal-directory
  (expand-file-name "personal" ft/lisp-directory)
  "Feather Emacs' `personal' directory. This is where personal configurations, such as sensitive information and the like are stored.")

;; ~/.cache
(defconst ft/cache-directory
  (concat user-home-directory ".cache/")
  "Cache directory.")

;; ~/.cache/emacs
(defconst ft/emacs-cache-directory
  (concat ft/cache-directory "emacs/")
  "Feather Emacs storage area for persistent files.")

(unless (file-exists-p ft/emacs-cache-directory)
  (make-directory ft/emacs-cache-directory t))

;; ~/.cache/emacs/auto-save
(defconst ft/emacs-auto-save-directory
  (concat ft/emacs-cache-directory "auto-save/")
  "Feather Emacs auto-save dir (default: ~/.cache/emacs/auto.")

(unless (file-exists-p ft/emacs-auto-save-directory)
  (make-directory ft/emacs-auto-save-directory t))

(let ((default-directory ft/lisp-directory))
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-to-load-path '("core" "modules" "themes" "personal")))

(provide 'core/load-paths)
;;; core/load-paths.el ends here
