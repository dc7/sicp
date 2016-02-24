(define (run-forever) (run-forever))

(define (try p)
  (if (halts? p p)
    (run-forever)
    'halted))

(try try)

; If (try try) halts, then (halts? try try) is true, and (run-forever) is
; called. If (try try) does not halt, then (halts? try try) is false, and the
; program halts. Either way, we have a contradiction.
