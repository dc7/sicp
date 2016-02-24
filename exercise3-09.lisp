(define (factorial n)
  (if (= n 1)
    1
    (* n (factorial (- n 1)))))
(factorial 6)
; 6 environments created, n ranging from 6 to 1

(define (factorial n)
  (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
  (if (> counter max-count)
    product
    (fact-iter (* counter product)
               (+ counter 1)
               max-count)))
(factorial 6)
; 7 environments created, max-count ranges from 6 to 1
