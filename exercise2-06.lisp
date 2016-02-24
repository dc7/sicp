(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; (add-1 zero)
; ((lambda (f) (lambda (x) (f ((n f) x)))) zero)
; (lambda (f) (lambda (x) (f ((zero f) x))))
; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
; (lambda (f) (lambda (x) (f x)))
(define one (lambda (f) (lambda (x) (f x))))

; (add-1 (add-1 zero))
; (add-1 (lambda (f) (lambda (x) (f x))))
; ((lambda (f) (lambda (x) (f ((n f) x)))) (lambda (f) (lambda (x) (f x))))
; ((lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x)))) )
; ((lambda (f) (lambda (x) (f ((lambda (x) (f x)) x)))))
; ((lambda (f) (lambda (x) (f (f x)))))
(define two (lambda (f) (lambda (x) (f (f x)))))

; from the church numerals
(define (+ a b)
  (lambda (f) (lambda (x) (a (f (b f x))))))
