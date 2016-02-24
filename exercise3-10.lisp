(define (make-withdraw initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))))
(define W1 (make-withdraw 100))
(W1 50)
(define W2 (make-withdraw 100))
(W1 5)
(W2 10)
; as before, there are two environments e1 and e2 for accounts w1 and w2.
; the let is equivalent to ((lambda (balance) (if...) amount).
