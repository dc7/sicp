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

(define (stream-to-list stream)
  (cond ((stream-null? stream) '())
        (else (cons (stream-car stream)
                    (stream-to-list (stream-cdr stream))))))

; infinite streams
(define (stream-map2 proc s1 s2)
  (if (or (stream-null? s1) (stream-null? s2))
    the-empty-stream
    (cons-stream (proc (stream-car s1) (stream-car s2))
                 (stream-map2 proc (stream-cdr s1) (stream-cdr s2)))))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (add-streams s1 s2)
  (stream-map2 + s1 s2))

(define (mul-streams s1 s2)
  (stream-map2 * s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))(s2car (stream-car s2)))
            (cond ((< s1car s2car)
                   (cons-stream s1car (merge (stream-cdr s1) s2)))
                  ((> s1car s2car)
                   (cons-stream s2car (merge s1 (stream-cdr s2))))
                  (else
                    (cons-stream s1car
                                 (merge (stream-cdr s1)
                                        (stream-cdr s2)))))))))

(define (stream-zip s1 s2)
  (cond ((or (stream-null? s1) (stream-null? s2)) the-empty-string)
        (else (cons-stream (cons (stream-car s1)
                                 (stream-car s2))
                           (stream-zip (stream-cdr s1)
                                       (stream-cdr s2))))))

; exercise
(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

(define int-pairs (pairs integers integers))

(define (merge-weighted weight s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let* ((s1car (stream-car s1))
                 (s2car (stream-car s2))
                 (s1weight (weight s1car))
                 (s2weight (weight s2car)))
            (cond ((< s1weight s2weight)
                   (cons-stream s1car
                                (merge-weighted weight
                                                (stream-cdr s1)
                                                s2)))
                  ((> s1weight s2weight)
                   (cons-stream s2car
                                (merge-weighted weight
                                                s1
                                                (stream-cdr s2))))
                  (else
                    (cons-stream s1car
                                 (merge-weighted weight
                                                 (stream-cdr s1)
                                                 (stream-cdr s2)))))))))

(define (weighted-pairs weight s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted
      weight
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

; part a
(stream-to-list
  (stream-take
    (weighted-pairs
      (lambda (pair) (+ (car pair) (cadr pair)))
      integers
      integers)
    20))

; part b
(define multiples
  (stream-filter 
    (lambda (x)
      (and
        (not (= 0 (modulo x 2)))
        (not (= 0 (modulo x 3)))
        (not (= 0 (modulo x 5)))))
    integers))

(stream-to-list
  (stream-take
    (weighted-pairs
      (lambda (pair)
        (+ (* 2 (car pair))
           (* 3 (cadr pair))
           (* 5 (car pair) (cadr pair))))
      multiples
      multiples)
    20))
