;;; cl-typesetting copyright 2003 Marc Battyani see license.txt for details of the license
;;; You can reach me at marc.battyani@fractalconcept.com or marc@battyani.net

(in-package typeset)

(defclass box ()
  ((dx :accessor dx :initform 0 :initarg :dx)
   (dy :accessor dy :initform 0 :initarg :dy)
   (baseline :accessor baseline :initform 0 :initarg :baseline)
   (offset :accessor offset :initform *offset* :initarg :offset)
   ))

(defmethod dx (box)
  0)

(defmethod (setf dx) (value box)
  value)

(defmethod dy (box)
  0)

(defmethod (setf dy) (value box)
  value)

(defmethod baseline (box)
  0)

(defmethod (setf baseline) (value box)
  value)

(defmethod offset (box)
  0)

(defmethod (setf offset) (value box)
  value)

(defclass h-mode-mixin ()
  ())

(defclass v-mode-mixin ()
  ())

(defmethod v-splitable-p (box max-dy)
  nil)

(defmethod h-splitable-p (box max-dx)
  nil)

(defclass elasticity ()
  ((delta-size :accessor delta-size :initform 0)
   (max-expansion :accessor max-expansion :initform 0 :initarg :max-expansion)
   (expansibility :accessor expansibility :initform 0 :initarg :expansibility)
   (max-compression :accessor max-compression :initform 0 :initarg :max-compression)
   (compressibility :accessor compressibility :initform 0 :initarg :compressibility)
   (locked :accessor locked :initform nil :initarg :locked)
   ))

(defmethod delta-size (obj)
  0)

(defmethod max-expansion (obj)
  0)

(defmethod expansibility (obj)
  0)

(defmethod max-compression (obj)
  0)

(defmethod compressibility (obj)
  0)

(defclass soft-box (box elasticity)
  ())

(defmethod locked (box)
  t)

(defmethod (setf locked) (value box)
  value)

(defclass container-box (soft-box)
  ((boxes :accessor boxes :initform nil :initarg :boxes)
   (adjustable-p :accessor adjustable-p :initform nil :initarg :adjustable-p)
   (internal-baseline :accessor internal-baseline :initform 0)))

(defclass vbox (container-box h-mode-mixin)
  ())

(defclass hbox (container-box v-mode-mixin)
  ())

(defclass glue (soft-box)
  ())

(defclass hglue (glue h-mode-mixin)
  ())

(defclass vglue (glue v-mode-mixin)
  ())

(defclass spacing (soft-box) ;; non trimable white space
  ())

(defclass h-spacing (spacing h-mode-mixin) 
  ())

(defclass v-spacing (spacing v-mode-mixin)
  ())

(defclass char-box (box h-mode-mixin)
  ((boxed-char :accessor boxed-char :initform nil :initarg :boxed-char)))

(defclass white-char-box (hglue)
  ())

(defmethod soft-box-p (box)
  nil)

(defmethod soft-box-p ((box soft-box))
  t)

(defmethod char-box-p (box)
  nil)

(defmethod char-box-p ((box char-box))
  t)

(defmethod white-char-box-p (box)
  nil)

(defmethod white-char-box-p ((box white-char-box))
  t)

(defmethod trimable-p (box)
  nil)

(defmethod trimable-p ((box glue))
  t)

(defmethod white-space-p (box)
  nil)

(defmethod white-space-p ((box glue))
  t)

(defmethod white-space-p ((box spacing))
  t)

(defmethod hmode-p (box)
  nil)

(defmethod hmode-p ((box h-mode-mixin))
  t)

(defmethod vmode-p (box)
  nil)

(defmethod vmode-p ((box v-mode-mixin))
  t)

(defmethod adjust-box-dx (box dx baseline)
  nil)

(defmethod adjust-box-dx ((box hbox) dx baseline)
  (when (adjustable-p box)
    (setf (dx box) dx
	  (baseline box) baseline)))

(defmethod adjust-box-dy ((box vbox) dy baseline)
  (when (adjustable-p box)
    (setf (dy box) dy
	  (baseline box) baseline)))

(defmethod adjust-box-dy (box dy baseline)
  nil)

