(define (cont-frac n d k)
  (define (cont-helper n d k i)
    (if (> i k)
      0
      (/ (n i) (+ (d i) (cont-helper n d k (+ i 1))))))
  (cont-helper n d k 1))
(display (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 10)) (newline)
(display (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 11)) (newline)
; takes 11 iterations to get 4 decimal points of accuracy
(define (cont-frac-iter n d k)
  (define (cont-helper n d k i acc)
    (if (< i 1)
      acc
      (cont-helper n d k (- i 1) (/ (n i) (+ (d i) acc)))))
  (cont-helper n d k k 0))
(display (cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 10)) (newline)
(display (cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 11)) (newline)
