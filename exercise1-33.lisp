(define (filtered-accumulate combiner null-value term a next b filter)
  (if (> a b)
    null-value
    (combiner
      (if (filter a)
        (term a)
        null-value)
      (filtered-accumulate combiner null-value term (next a) next b filter))))
(define (prime? n)
  (define (prime-helper n i)
    (if (>= i n)
      #t
      (if (= (remainder n i) 0)
        #f
        (prime-helper n (+ i 1)))))
  (if (< n 2)
    #f
    (prime-helper n 2)))
(define (sum-of-prime-squares a b)
  (filtered-accumulate + 0 (lambda (x) (* x x)) a (lambda (x) (+ x 1)) b prime?))
(print (sum-of-prime-squares 1 10)) (newline)
(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))
(define (product-of-relative-primes n)
  (filtered-accumulate * 1 (lambda (x) x) 1 (lambda (x) (+ x 1)) (- n 1)
                       (lambda (x) (= (gcd x n) 1))))
; note that n and (- n 1) are equivalent in filter-acc since gcd(n,n) != 1
(print (product-of-relative-primes 5)) (newline)
