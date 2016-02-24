(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))
(print (A 1 10)) (newline) ; 1024
(print (A 2 4)) (newline) ; 65536
(print (A 3 3)) (newline) ; 65536
(define (f n) (A 0 n)) ; f(n) = 2n
(define (g n) (A 1 n)) ; g(n) = 2^n
(define (h n) (A 2 n)) ; h(n) = 2^2^2...^2 with n exponents
