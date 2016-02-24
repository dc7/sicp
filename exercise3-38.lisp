(define balance 100)
(set! balance (+ balance 10)) ; Peter
(set! balance (- balance 20)) ; Paul
(set! balance (- balance (/ balance 2))) ; Mary

(define balance 100)
(set! balance (+ balance 10)) ; Peter
(set! balance (- balance (/ balance 2))) ; Mary
(set! balance (- balance 20)) ; Paul

(define balance 100)
(set! balance (- balance 20)) ; Paul
(set! balance (+ balance 10)) ; Peter
(set! balance (- balance (/ balance 2))) ; Mary

(define balance 100)
(set! balance (- balance 20)) ; Paul
(set! balance (- balance (/ balance 2))) ; Mary
(set! balance (+ balance 10)) ; Peter

(define balance 100)
(set! balance (- balance (/ balance 2))) ; Mary
(set! balance (+ balance 10)) ; Peter
(set! balance (- balance 20)) ; Paul

(define balance 100)
(set! balance (- balance (/ balance 2))) ; Mary
(set! balance (- balance 20)) ; Paul
(set! balance (+ balance 10)) ; Peter

; possible outcomes: 90, 55 40, 60
; if the processes are interleaved, there are many more possibilities. for example, mary gets balance twice. perhaps she gets 100 the first time and 80 the second time, resulting in 30 instead of 50.
