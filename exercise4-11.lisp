(define (enclosing-environment env) (cdr env))

(define (first-frame env) (car env))

(define the-empty-environment '())

(define zip (lambda lists (apply map cons lists)))

(define (make-frame variables values)
  (zip variables values))

(define (add-binding-to-frame! var val frame)
  (set-cdr! frame (cons (car frame) (cdr frame)))
  (set-car! frame (cons var val))
  'ok)

(define (extend-environment vars vals base-env)
  (append (zip vars vals) base-env))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan pairs)
      (cond ((null? pairs)
             (env-loop (enclosing-environment env)))
            ((eq? var (caar pairs))
             (cdar pairs))
            (else (scan (cdr pairs)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (scan frame))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan pairs)
      (cond ((null? pairs)
             (env-loop (enclosing-environment env)))
            ((eq? var (caar pairs))
             (set-cdr! (car pairs) val))
            (else (scan (cdr pairs)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable -- SET!" var)
      (let ((frame (first-frame env)))
        (scan frame))))
  (env-loop env)
  'ok)

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan pairs)
      (cond ((null? pairs)
             (add-binding-to-frame! var val frame))
            ((eq? var (caar pairs))
             (set-cdr! (car pairs) val))
            (else (scan (cdr pairs)))))
    (scan frame))
  'ok)

; tests

(define my-env '(((a . 10) (c . 3)) ((a . 1) (b . 2))))

(define-variable! 'd 5 my-env)

(define-variable! 'c 33 my-env)

(define-variable! 'a 55 my-env)

(set-variable-value! 'a 550 my-env)

(set-variable-value! 'b 220 my-env)

(set-variable-value! 'c 330 my-env)

(lookup-variable-value 'a my-env)

(lookup-variable-value 'b my-env)

(lookup-variable-value 'c my-env)

my-env
