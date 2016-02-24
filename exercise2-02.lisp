(define (make-segment a b)
  (cons a b))
(define (start-segment x)
  (car x))
(define (end-segment x)
  (cdr x))
(define (make-point x y)
  (cons x y))
(define (x-point a)
  (car a))
(define (y-point a)
  (cdr a))
(define (midpoint-segment s)
  (make-point
    (/ (+ (x-point (start-segment s))
          (x-point (end-segment s)))
       2)
    (/ (+ (y-point (start-segment s))
          (y-point (end-segment s)))
       2)))
(define (print-point p)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  (newline))
(define my-segment
  (make-segment (make-point 2 4)
                (make-point 10 12)))
(print-point (x-point my-segment))
(print-point (y-point my-segment))
(print-point (midpoint-segment my-segment))