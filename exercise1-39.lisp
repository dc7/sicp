(define (tan-cf x k)
  (define (n i)
    (if (= i 1)
      x
      (* x x)))
  (define (d i)
    (- (* 2 i) 1))
  (define (tan-helper x k i)
    (if (> i k)
      0
      (/ (n i) (- (d i) (tan-helper x k (+ i 1))))))
  (tan-helper x k 1))
(display (tan-cf 1.0 10)) (newline)
