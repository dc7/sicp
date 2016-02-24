(define (equal? a b)
  (fold-left (lambda (a b) (and a b)) #t (map eq? a b)))

(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))
