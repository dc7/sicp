(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))
(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
          (+ (cc amount
                 (except-first-denomination coin-values))
             (cc (- amount
                    (first-demonination coin-values))
                 coin-values)))))
(define first-demonination car)
(define except-first-denomination cdr)
(define no-more? null?)

(display (cc 100 us-coins))
(newline)

; the order of the list does not affect the answer since the whole answer tree is traversed
