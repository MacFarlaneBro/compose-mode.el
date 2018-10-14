;;; compose-mode.el --- Change the currently active docker-compose file

;;; Commentary:
;; A small wrapper around the tool 'compose-mode' allowing easy switching of modes from macs.

;;; Code:

(defun compose-mode ()
  "Base command to bring up list of compose-modes to switch between."
  (interactive)
  (let ((root-directory (compose-root)))
    (print root-directory)
    (let ((current-modes (split-string (shell-command-to-string "compose-mode") "\n")))
      (ivy-read "Choose mode: " current-modes
		:action (lambda (x)
			  (switch-mode x))
		)
      )))

(defun compose-root ()
  "Find and return the location of the compose-modes.ymll file in the directory hierarchy."
  (locate-dominating-file default-directory "compose-modes.yml"))

(defun compose-mode-test ()
  "Change to the test docker-compose mode."
  (interactive)
  (switch-mode "test"))

(defun compose-mode-dev ()
  "Change to the dev docker-compose mode."
  (interactive)
  (switch-mode "dev"))

(defun switch-mode (mode)
  "Change to the docker-compose mode as specified in MODE."
  (let ((test-string
	 (format
	  "docker-compose down && compose-mode %s && docker-compose up -d" mode)))
      (message test-string)
      (async-shell-command test-string)))


(provide 'compose-mode)
;;; compose-mode.el ends here
