(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))
(define (car-helper x)
  (if (= (remainder x 2) 0)
    (+ 1 (car-helper (/ x 2)))
    0))
(define (car x)
  (car-helper x))
(define (cdr-helper x)
  (if (= (remainder x 3) 0)
    (+ 1 (cdr-helper (/ x 3)))
    0))
(define (cdr x)
  (cdr-helper x))
(display (cons 10 20))
(newline)
(display (car (cons 10 20)))
(newline)
(display (cdr (cons 10 20)))
(newline)
