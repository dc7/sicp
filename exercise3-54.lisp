; basic streams
(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
    the-empty-stream
    (cons-stream (proc (stream-car s))
                 (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
    'done
    (begin (proc (stream-car s))
           (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream
      low
      (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (stream-take stream num)
  (cond ((<= num 0) the-empty-stream)
        (else (cons-stream (stream-car stream)
                           (stream-take (stream-cdr stream) (- num 1))))))

; infinite streams
(define (stream-map proc s1 s2)
  (if (or (stream-null? s1) (stream-null? s2))
    the-empty-stream
    (cons-stream (proc (stream-car s1) (stream-car s2))
                 (stream-map proc (stream-cdr s1) (stream-cdr s2)))))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

; exercise
(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials (cons-stream 1
                                (mul-streams (integers-starting-from 2)
                                             factorials)))

(display-stream (stream-take factorials 10))
