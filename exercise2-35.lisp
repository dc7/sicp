(define (count-leaves t)
  (foldr (lambda (this rest) (+ 1 rest)) 0 (flatten t)))

(display (count-leaves (list (list 1 2) (list 3 4))))
(newline)
