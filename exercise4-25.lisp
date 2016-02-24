(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1))

(factorial 5)

; This results in a stack overflow, since (factorial (- n 1)) evaluated every
; time the function is entered.

; In a lazy language (e.g. Haskell), it works fine:

; let unless condition usual exceptional = if condition then exceptional else usual
; let factorial n = unless (n == 1) (n * factorial (n - 1)) 1
; factorial 5
