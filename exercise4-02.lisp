; a. If procedure application is moved before variable assignment in eval, then
; (define x 3) will be interpreted as a primitive function application, meaning
; that x = 3 will be bound in the scope of eval rather than the proper
; environment.

; b. 

(define (application? exp) (equal? 'call (car exp)))

(define (operator exp) (cadr exp))

(define (operands exp) (cddr exp))
