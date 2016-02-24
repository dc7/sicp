; environments

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

; exercise - abstract procedure

(define (find-variable-env var env success failure)
  (if (eq? env the-empty-environment)
    (failure)
    (let ((pair (assoc var (first-frame env))))
      (if (pair? pair)
        (success pair)
        (find-variable-env var (enclosing-environment env) success failure)))))

(define same-key? eq?)

; and "assoc" from previous exercises

(define (assoc key records)
  (cond ((null? records) false)
        ((same-key? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

; exercise - implementations

(define (define-variable! var val env)
  (if (eq? env the-empty-environment)
    (error "First frame not found -- define-variable!" var)
    (let ((pair (assoc var (first-frame env))))
      (if (pair? pair)
        (set-cdr! pair val)
        (add-binding-to-frame! var val (first-frame env)))))
  'ok)

(define (lookup-variable-value var env)
  (find-variable-env var
                     env
                     (lambda (pair) (cdr pair))
                     (lambda () (error "Variable not found -- lookup-variable-value" var))))

(define (set-variable-value! var val env)
  (find-variable-env var
                     env
                     (lambda (pair) (set-cdr! pair val))
                     (lambda () (error "Variable not found -- set-variable-value!" var val)))
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
