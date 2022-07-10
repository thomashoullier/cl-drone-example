(defsystem cl-drone-example
  :name "cl-drone-example"
  :components
  ((:module "src"
    :components ((:file "foo"))))
  :in-order-to ((test-op (test-op "cl-drone-example/test"))))

(defsystem cl-drone-example/test
  :name "cl-drone-example/test"
  :depends-on ("rove" "cl-drone-example")
  :components
  ((:module "test"
    :components ((:file "rove-suite"))))
  :perform (test-op (o c) (symbol-call :rove '#:run c)))
