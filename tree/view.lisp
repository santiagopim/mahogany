(in-package :mahogany/tree)

(defclass view-frame (frame)
  ((view :initarg :view
	 :accessor frame-view
	 :initform nil
	 :documentation "The client of the frame")
   (modes :initarg :modes
	  :accessor frame-modes)))

(defun fit-view-into-frame (view frame)
  "Make the view fit in the dimensions of the frame"
  (setf (view-x view) (truncate (frame-x frame))
	(view-y view) (truncate (frame-y frame)))
  (set-dimensions view (truncate (frame-width frame)) (truncate (frame-height frame))))

(defmethod print-object ((object view-frame) stream)
  (print-unreadable-object (object stream :type t)
    (with-slots (width height x y view)
	object
      (format stream ":w ~A :h ~A :x ~A :y ~A view: ~S"
	      width height x y view))))

(defmethod (setf frame-x) :before (new-x (frame view-frame))
  (when (frame-view frame)
    (setf (view-x (frame-view frame)) (truncate new-x))))

(defmethod (setf frame-y) :before (new-y (frame view-frame))
  (when (frame-view frame)
    (setf (view-y (frame-view frame)) (truncate new-y))))

(defmethod set-dimensions ((frame view-frame) width height)
  (set-dimensions (frame-view frame) (truncate width) (truncate height)))

(defmethod (setf frame-width) :before (new-width (frame view-frame))
  (when (frame-view frame)
    (set-dimensions (frame-view frame) (truncate new-width) (truncate (frame-height frame)))))

(defmethod (setf frame-height) :before (new-height (frame view-frame))
  (when (frame-view frame)
    (set-dimensions (frame-view frame) (truncate (frame-width frame)) (truncate new-height))))