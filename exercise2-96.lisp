(define *my-hash-table* (make-hash-table))
(define (put op type proc)
  (hash-table/put! *my-hash-table* (list op type) proc)
  'done)
(define (get op type)
  (hash-table/get *my-hash-table* (list op type) #f))

;; a
(define (pseudoremainder-terms a b)
  (let* ((o1 (order (first-term a)))
         (o2 (order (first-term b)))
         (c (coeff (first-term b)))
         (divident (mul-terms (make-term 0
                                         (expt c (+ 1 (- o1 o2))))
                              a)))
    (cadr (div-terms divident b))))

(define (gcd-terms a b)
  (if (empty-termlist? b)
    a
    (gcd-terms b (pseudoremainder-terms a b))))

;; b
(define (gcd-terms a b)
  (if (empty-termlist? b)
    (let* ((coeff-list (map cadr a))
           (gcd-coeff (apply gcd coeff-list)))
      (div-terms a (make-term 0  gcd-coeff)))
    (gcd-terms b (pseudoremainder-terms a b))))
