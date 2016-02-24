; Recursive functions will run slower without memoization, including "fib" and
; "fact".

(define (square x)
  (* x x))

;;; L-Eval input:
(square (id 10))

;;; L-Eval value:
<response>

;;; L-Eval input:
count

;;; L-Eval value:
<response>

; With memoization, count will be 1 as before. Without it, count will be 2.
