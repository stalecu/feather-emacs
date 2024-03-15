;;; feather.el --- Feather Emacs main file -*- lexical-binding: t; -*-

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

;; This is the main file of Feather Emacs, which subsequently loads
;; everything else.

;;; Code:

(require 'core/load-paths)

;; This is so that, by the time Elpaca and all other packages kick in,
;; we move everything to `ft/emacs-cache-directory' so it doesn't
;; clutter our real `ft/feather-directory'. While we're here, we'll
;; also set the auto-save directory.
(setq user-emacs-directory ft/emacs-cache-directory
      auto-save-file-name-transforms `((".*" ,(file-name-as-directory ft/emacs-auto-save-directory) t)))

(require 'core/package-manager)

(provide 'feather)
