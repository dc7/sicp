; original
(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (cons (eval (first-operand exps) env)
          (list-of-values (rest-operands exps) env))))

; left to right
(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (let ((eval-first (eval (first-operand exps) env)))
      (cons eval-first (list-of-values (rest-operands exps) env)))))

; right to left
(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (if (no-operands? (rest-operands exps))
      (let ((eval-rest (list-of-values (rest-operands exps) env)))
        (cons (eval (first-operand exps) env) eval-rest)))))
