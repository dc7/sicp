(define *my-hash-table* (make-hash-table))
(define (put op type proc)
  (hash-table/put! *my-hash-table* (list op type) proc)
  'done)
(define (get op type)
  (hash-table/get *my-hash-table* (list op type) #f))

;; all we should change are procedure first-term and adjoin-term

(define (first-term term-list)
  (list (car term-list) (- (length term-list) 1)))
(define (adjoin-term term term-list)
  (let ((exponent (order term))
        (len (length term-list)))
    (define (iter-adjoin times terms)
      (cond ((=zero? (coeff term))
             terms))
            ((= exponent times)
             (cons (coeff term) terms))
            (else (iter-adjoin (+ times 1)
                               (cons 0 terms))))
        (iter-adjoin len term-list)))
