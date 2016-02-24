(define (reverse x)
  (define (rev-helper x acc)
    (if (null? x)
      acc
      (rev-helper (cdr x) (cons (car x) acc))))
  (rev-helper x '()))
(define (deep-reverse x)
  (define (rev-helper x acc)
    (if (null? x)
      acc
      (if (not (pair? x))
        x
        (rev-helper (cdr x) (cons (rev-helper (car x) '()) acc)))))
  (rev-helper x '()))

(define x (list (list 1 2) (list 3 4)))
(display (reverse x))
(newline)
(display (deep-reverse x))
(newline)
