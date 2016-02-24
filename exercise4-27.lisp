(define count 0)

(define (id x)
  (set! count (+ count 1))
  x)

(define w (id (id 10)))

; (id (...)) is evaluated, (id 10) is delayed

;;; L-Eval input:
count

;;; L-Eval value:
1

;;; L-Eval input:
w ; (id 10) is forced

;;; L-Eval value:
10

;;; L-Eval input:
count

;;; L-Eval value:
2

; Evaluating "w" further will not change "count".
