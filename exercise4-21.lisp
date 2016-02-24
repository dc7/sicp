; example

((lambda (n)
   ((lambda (fact)
      (fact fact n))
    (lambda (ft k)
      (if (= k 1)
        1
        (* k (ft ft (- k 1)))))))
 10)

; part a

((lambda (n)
   ((lambda (fib)
      (fib fib n))
    (lambda (f k)
      (cond ((<= k 0) 0)
            ((=  k 1) 1)
            (else (+ (f f (- k 1))
                     (f f (- k 2))))))))
 10)

; example

(define (f x)
  (define (even? n)
    (if (= n 0)
      true
      (odd? (- n 1))))
  (define (odd? n)
    (if (= n 0)
      false
      (even? (- n 1))))
  (even? x))

; part b

(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0)
       true
       (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0)
       false
       (ev? ev? od? (- n 1))))))

; test

(map f '(0 1 2 3 4 5 6 7 8 9 10))
