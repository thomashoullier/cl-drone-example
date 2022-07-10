(defpackage :cl-drone-example
  (:use :cl)
  (:export #:foo))
(in-package :cl-drone-example)

(defun foo ()
  "An error must now be detected"
  ;; 64
  0)
