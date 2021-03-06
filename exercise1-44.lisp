(define (compose f g) (lambda (x) (f (g x))))
(define (repeated f n)
  (if (< n 1)
    (lambda (x) x)
    (compose f (repeated f (- n 1)))))
(define dx 0.00001)
(define (smooth f)
  (lambda (x) (/
                (+
                  (f (- x dx))
                  (f x)
                  (f (+ x dx)))
                3)))
(define (n-fold-smoothed f n)
  ((repeated smooth n) f))
(display ((smooth sin) 1.23)) (newline)
(display ((n-fold-smoothed sin 1) 1.23)) (newline)
(display ((smooth (smooth sin)) 1.23)) (newline)
(display ((n-fold-smoothed sin 2) 1.23)) (newline)
(display ((smooth (smooth (smooth sin))) 1.23)) (newline)
(display ((n-fold-smoothed sin 3) 1.23)) (newline)
