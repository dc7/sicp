(define (make-monitored f)
  (let ((num-calls 0))
    (lambda (x)
      (if (eq? x 'how-many-calls?)
        num-calls
        (begin (set! num-calls (+ num-calls 1))
               (f x))))))
(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls?)
