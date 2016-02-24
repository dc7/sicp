(define (f n)
  (if (< n 3)
    n
    (+
      (f (- n 1))
      (* 2 (f (- n 2)))
      (* 3 (f (- n 3))))))
(define (f-iter-helper 3ago 2ago 1ago cur end)
  (if (> cur end)
    1ago
    (f-iter-helper 2ago 1ago (+ 1ago (* 2 2ago) (* 3 3ago)) (+ cur 1) end)))
(define (f-iter n)
  (if (< n 3)
    n
    (f-iter-helper 0 1 2 3 n)))
(print (f 13)) (newline)
(print (f-iter 13)) (newline)
(print (f 14)) (newline)
(print (f-iter 14)) (newline)
(print (f 15)) (newline)
(print (f-iter 15)) (newline)
