(define (enumerate-interval low high)
  (if (> low high)
    '()
    (cons low (enumerate-interval (+ low 1) high))))
(define (flatmap proc seq)
  (foldr append '() (map proc seq)))

(define (unique-pairs n)
  (flatmap (lambda (i)
         (map (lambda (j) (list j i))
              (enumerate-interval 1 (- i 1))))
       (enumerate-interval 2 n)))

(display (unique-pairs 4))
(newline)

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))
(define (prime? n)
  (foldr (lambda (x y) (and x y)) #t (map (lambda (x) (not (= (remainder n x) 0))) (enumerate-interval 2 (/ n 2)))))
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs n))))

(display (prime-sum-pairs 5))
(newline)
