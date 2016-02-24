(define (make-accumulator total)
  (lambda (x)
    (begin (set! total (+ total x))
           total)))
(define A (make-accumulator 5))
(A 10)
(A 10)