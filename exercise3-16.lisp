(define (count-pairs x)
  (if (not (pair? x))
    0
    (+ (count-pairs (car x))
       (count-pairs (cdr x))
       1)))
(define x1 (cons 1 2))
(define x2 (cons 3 4))
(define x3 (cons x1 x2))
(count-pairs x3)
(define y1 (cons 1 2))
(define y2 (cons 1 y1))
(define y3 (cons y1 y2))
(count-pairs y3)
(define z1 (cons 1 2))
(define z2 (cons z1 z1))
(define z3 (cons z2 z2))
(count-pairs z3)
