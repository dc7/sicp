(define (cycle? x)
  (define visited '())
  (define (cycle-helper x)
    (if (null? x)
      #f
      (if (member x visited)
        #t
        (begin (set! visited (cons x visited))
               (cycle-helper (cdr x))))))
    (cycle-helper x))
(define x '(1 2 3))
(set-cdr! (cddr x) x)
(cycle? x)
(cycle? '(1 2 3))
