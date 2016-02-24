(define *my-hash-table* (make-hash-table))
(define (put op type proc)
  (hash-table/put! *my-hash-table* (list op type) proc)
  'done)
(define (get op type)
  (hash-table/get *my-hash-table* (list op type) #f))

;; to be installed in polynomial package
(define (=zero? x)
  (define (poly? x)
    (pair? x))
  (cond ((number? x) (= x 0))
        ((poly? x) false)
        (else (error "Unknown type"))))

(put '=zero? 'polynomial =zero?)
