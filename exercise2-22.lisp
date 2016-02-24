(define (square x) (* x x))
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons (square (car things))
                  answer))))
  (iter items '()))
(display (square-list (list 1 2 3 4)))
(newline)
; the results are being accumulated in reverse order

(define (square x) (* x x))
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons answer
                  (square (car things))))))
  (iter items '()))
(display (square-list (list 1 2 3 4)))
(newline)
; this is the incorrect list with each pair flipped

(define (square x) (* x x))
(define (square-list items)
  (define (iter things)
    (if (null? things)
      '()
      (cons (square (car things))
            (iter (cdr things)))))
  (iter items))
(display (square-list (list 1 2 3 4)))
(newline)
; the correct order (or just use map)
