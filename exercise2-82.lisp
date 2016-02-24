(define *my-hash-table* (make-equal-hash-table)) 

(define (put type1 type2 proc)
  (hash-table/put! *my-hash-table* (list type1 type2) proc)) 
 
(define (get type1 type2) 
  (hash-table/get *my-hash-table* (list type1 type2) '())) 

; dependencies
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  'done)
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(define (install-rational-package);; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)
(define (make-rational n d)
  ((get 'make 'rational) n d))

(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)((get 'make-from-mag-ang 'polar) r a))
  ;; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

;;iter returns the list of coerced argument or gives an error on failing to find a method. 
 
(define (apply-generic op . args) 
(define (iter type-tags args) 
    (if (null? type-tags) 
        (error "No method for these types-ITER") 
        (let ((type1 (car type-tags))) 
          (let ((filtered-args (true-map (lambda (x) 
                                           (let ((type2 (type-tag x))) 
                                             (if (eq? type1 type2) 
                                                 x 
                                                 (let ((t2->t1 (get-coercion type2 type1))) 
                                                   (if (null? t2->t1) #f (t2->t1 x)))))) 
                                         args))) 
            (or filtered-args 
                (iter (cdr type-tags) args)))))) 
  (let ((type-tags (map type-tag args))) 
    (let ((proc (get op type-tags))) 
      (if (not (null? proc)) 
          (apply proc (map contents args)) 
          (apply apply-generic (cons op (iter type-tags args))))))) 
 
;;; true-map function applies proc to each item on the sequence and returns false if any of  
;;;;those results was false otherwise returns the list of each results.  
(define (true-map proc sequence) 
  (define (true-map-iter proc sequence result) 
    (if (null? sequence) 
        (reverse result) 
        (let ((item (proc (car sequence)))) 
          (if item 
              (true-map-iter proc (cdr sequence) (cons item result)) 
              #f)))) 
(true-map-iter proc sequence '())) 
 
;; The following code may be used to try out the solution and see it working. Also you will  
;;;need the scheme-number, rational and complex packages and associated generic declarations  
;;;;which are not given here. 
 
 
(define *coercion-table* (make-equal-hash-table)) 
 
(define (put-coercion type1 type2 proc) 
  (hash-table/put! *coercion-table* (list type1 type2) proc)) 
 
(define (get-coercion type1 type2) 
  (hash-table/get *coercion-table* (list type1 type2) '())) 
 
(define (install-coercion-package) 
(define (scheme-number->complex n) 
  (make-complex-from-real-imag (contents n) 0)) 
(define (scheme-number->rational n) 
  (make-rational (contents n) 1)) 
(put-coercion 'scheme-number 'rational scheme-number->rational) 
(put-coercion 'scheme-number 'complex scheme-number->complex) 
'done) 
 
(install-coercion-package) 
 
;;The following are some example evaluations 
 
(add (make-scheme-number 1) (make-scheme-number 4)) 
(add (make-complex-from-real-imag 1 1) (make-complex-from-real-imag 3 2)) 
(add (make-scheme-number 1) (make-complex-from-real-imag 1 1)) 
(add (make-scheme-number 2) (make-rational 3 4)) 
