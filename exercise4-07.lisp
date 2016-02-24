(define (let*->nested-lets exp)
  (define (expand clauses)
    (if (null? clauses)
      (third exp)
      (list 'let
            (list (car clauses))
            (expand (cdr clauses)))))
  (expand (second exp)))
