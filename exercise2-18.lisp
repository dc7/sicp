(define (reverse x)
  (define (rev-helper x acc)
    (if (null? x)
      acc
      (rev-helper (cdr x) (cons (car x) acc))))
  (rev-helper x '()))
(display (reverse (list 1 4 9 16 25)))
(newline)
