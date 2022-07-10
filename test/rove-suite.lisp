(defpackage :cl-drone-example/test
  (:use :cl :rove :cl-drone-example))
(in-package :cl-drone-example/test)

(deftest test-foo
  (testing "numerical equality")
  (ok (= 64 (foo))))
