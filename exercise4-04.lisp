; and, special form
(define (eval-and exps env)
  (let ((truth (eval (first-exp exps) env)))
    (cond ((last-exp? exps) truth)
          (truth (eval-and (rest-exps exps) env))
          (else #f))))

; or, special form
(define (eval-or exps env)
  (let ((truth (eval (first-exp exps) env)))
    (cond (truth truth)
          ((last exp? exps) #f)
          (else (eval-and (rest-exps exps) env)))))

; and, derived
(define (and->if exp)
  (define (expand clauses)
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (if (null? rest)
        first
        (make-if first (and->if rest) #f))))
  (expand (cdr exp)))

; or, derived
(define (or->if exp)
  (define (expand clauses)
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (if (null? rest)
        first
        (make-if first #t (or->if rest)))))
  (expand (cdr exp)))
