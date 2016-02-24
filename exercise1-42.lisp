(define (square x) (* x x))
(define (inc x) (+ 1 x))
(define (compose f g) (lambda (x) (f (g x))))
(display ((compose square inc) 6)) (newline)
