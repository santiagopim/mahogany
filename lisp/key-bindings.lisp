(in-package #:mahogany)

(defun handle-server-stop (sequence seat)
  (declare (ignore sequence seat))
  (server-stop *compositor-state*))

(defun open-terminal (sequence seat)
  (declare (ignore sequence seat))
  (sys:open-terminal))

(defun open-kcalc (sequence seat)
  (declare (ignore sequence seat))
  (uiop:launch-program (sys:find-program "kcalc")))

(defun split-frame-h (sequence seat)
  (declare (ignore sequence seat))
  (let ((frame (mahogany-current-frame *compositor-state*)))
    (when frame
      (tree:split-frame-h frame :direction :left))))

(defun split-frame-v (sequence seat)
  (declare (ignore sequence seat))
  (let ((frame (mahogany-current-frame *compositor-state*)))
    (when frame
      (tree:split-frame-v frame :direction :top))))

(defun maximize-current-frame (sequence seat)
  (declare (ignore sequence seat))
  (let ((group (mahogany-current-group *compositor-state*)))
    (group-maximize-current-frame group)))

(defun next-view (sequence seat)
  "Raise the next hidden view in the current group"
  (declare (ignore sequence seat))
  (let ((group (mahogany-current-group *compositor-state*)))
    (group-next-hidden group)))

(defun previous-view (sequence seat)
  "Raise the next hidden view in the current group"
  (declare (ignore sequence seat))
  (let ((group (mahogany-current-group *compositor-state*)))
    (group-previous-hidden group)))

(setf (mahogany-state-keybindings *compositor-state*)
      (list (define-kmap
	      (kbd "C-t") (define-kmap
			    (kbd "q") #'handle-server-stop
			    (kbd "c") #'open-terminal
			    (kbd "s") #'split-frame-v
			    (kbd "S") #'split-frame-h
			    (kbd "Q") #'maximize-current-frame
			    (kbd "n") #'next-view
			    (kbd "p") #'previous-view
			    (kbd "+") #'open-kcalc))))
