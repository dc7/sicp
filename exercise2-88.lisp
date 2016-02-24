(define *my-hash-table* (make-hash-table))
(define (put op type proc)
  (hash-table/put! *my-hash-table* (list op type) proc)
  'done)
(define (get op type)
  (hash-table/get *my-hash-table* (list op type) #f))

(define (negate x) (apply-generic 'negate x))

;; add into scheme-number package
(put 'negate 'scheme-number
      (lambda (n) (tag (- n))))

;; add into rational package
(put 'negate 'rational
     (lambda (rat) (make-rational (- (numer rat)) (denom rat))))

;; add into complex package
(put 'negate 'complex
     (lambda (z) (make-from-real-imag (- (real-part z))
                                      (- (imag-part z)))))

;; add into polynomial package
(define (negate-terms termlist)
  (if (empty-termlist? termlist)
        the-empty-termlist
        (let ((t (first-term termlist)))
          (adjoin-term (make-term (order t) (negate (coeff t)))
                       (negate-terms (rest-terms termlist))))))
(put 'negate 'polynomial
         (lambda (poly) (make-polynomial (variable poly)
                                         (negate-terms (term-list poly)))))
(put 'sub '(polynomial polynomial)
      (lambda (x y) (tag (add-poly x (negate y)))))
