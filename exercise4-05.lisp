(define (expand-clauses clauses)
  (if (null? clauses)
    'false ; no else clause
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (if (cond-else-clause? first)
        (if (null? rest)
          (sequence->exp (cond-actions first))
          (error "ELSE clause isn't last -- COND->IF"
                 clauses))
        (if (eq? '=> (car (cond-actions first)))         ; new
          (let ((truth (cond-predicate first)))          ; new
            (make-if truth                               ; new
                     ((cadr (cond-actions first)) truth) ; new
                     (expand-clauses rest)))             ; new
          (make-if (cond-predicate first)
                   (sequence->exp (cond-actions first))
                   (expand-clauses rest)))))))
