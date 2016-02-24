; test program

(eval
  '(begin
     (define (fib n)
       (cond ((= n 0) 0)
             ((= n 1) 1)
             (else (+ (fib (- n 1)) (fib (- n 2))))))
     (fib 22))
  the-global-environment)


; original evaluator

; real 18.50
; user 18.36
; sys 0.11


; with analysis

; real 10.67
; user 10.46
; sys 0.18


; The updated version finished 7.83 seconds faster. In the original program, about 42% of the running
; time is being wasted on extra analysis.
