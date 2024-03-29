;;; init.el --- Feather Emacs init file -*- lexical-binding: t; -*-

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

;; This is the initialization file for Feather Emacs. It is nothing
;; more than just a loader for the real init file, which is
;; `lisp/feather.el'.

;;; Code:

(load (expand-file-name "lisp/core/load-paths"
                        (file-name-directory
                         (or load-file-name
			     (buffer-file-name)))) nil)
(require 'feather)

;;; init.el ends here
