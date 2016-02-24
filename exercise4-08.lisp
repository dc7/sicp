(define (let->combination exp env)
  (if (pair? (second exp))
    ; ordinary let
    (let ((vars (map first (second exp)))
          (exps (map second (second exp)))
          (body (cddr exp)))
      (cons (make-procedure vars body) exps))
    ; named let
    (let* ((var (second exp))
           (bindings (third exp))
           (body (cdddr exp))
           (make-def (lambda (pair) (cons 'define pair)))
           (definitions (map make-def bindings)))
      (cons 'begin (append definitions body)))))
