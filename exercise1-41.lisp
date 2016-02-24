(define (double f)
  (lambda (x)
    (f (f x))))
(define (inc x) (+ x 1))
(display (((double (double double)) inc) 5)) (newline)
; (double double) = 4 times
; (double (double double)) = 16 times
