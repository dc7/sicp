(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner
      (term a)
      (accumulate combiner null-value term (next a) next b))))
(print (accumulate + 0 (lambda (x) x) 1 (lambda (x) (+ x 1)) 10)) (newline)
(define (acc-helper combiner null-value term a next b acc)
  (if (> a b)
    acc
    (acc-helper combiner null-value term (next a) next b
                (combiner (term a) acc))))
(define (acc-iter combiner null-value term a next b)
  (acc-helper combiner null-value term a next b null-value))
(print (acc-iter + 0 (lambda (x) x) 1 (lambda (x) (+ x 1)) 10)) (newline)
