(define (f g)
  (g 2))
(define (square x)
  (* x x))
(print (f square)) (newline)
(print (f (lambda (z) (* z (+ z 1))))) (newline)
(f f)
; (define (f g) (g 2))
; -> (define f (lambda (g) (g 2)))
; (f f)
; -> ((lambda (g) (g 2)) (lambda (g) (g 2)))
; -> (lambda (lambda (g) (g 2)) (g 2)
; -> ((lambda (g) (g 2)) 2)
; -> (lambda (2) (g 2)
; -> (2 2)
; -> error
