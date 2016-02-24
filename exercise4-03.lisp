; original
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ; more rules can be added here
        (else (error "unknown expression type -- DERIV" exp))))

; data-directed
(put 'op 'quote text-of-quotation) 

(put 'op 'set! eval-assignment) 

(put 'op 'define eval-definition) 

(put 'op 'if eval-if) 

(put 'op 'lambda (lambda (x y) (make-procedure (lambda-parameters x) (lambda-body x) y))) 

(put 'op 'begin (lambda (x y) (eval-sequence (begin-sequence x) y))) 

(put 'op 'cond (lambda (x y) (evaln (cond->if x) y))) 

(define (evaln expr env) 
  (cond ((self-evaluating? expr) expr) 
        ((variable? expr) (lookup-variable-value expr env)) 
        ((get 'op (car expr)) (applyn (get 'op (car expr) expr env))) 
        ((application? expr) (applyn (evaln (operator expr) env)
                                     (list-of-values (operands expr) env))) 
        (else  
          (error "Unkown expression type -- EVAL" expr)))) 
