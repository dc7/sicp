(define (range low high)
  (if (< high low)
    '()
    (cons low (range (+ 1 low) high))))

(define (in-list lst)
  (if (null? lst)
    (amb)
    (amb (car lst) (in-list (cdr lst)))))

(define (build-board size)
  (define (helper remaining max-size old-values)
    (if (= 0 remaining)
      '()
      (let* ((all-values (range 1 max-size))
             (new-values (filter (lambda (x) (not (member x old-values))) all-values))
             (current-value (in-list new-values)))
        (cons current-value (helper (- remaining 1) max-size (cons current-value old-values))))))
  (helper size size '()))

(define (safe? board)
  (if (null? board)
    #t
    (let* ((first-piece (car board))
           (other-pieces (cdr board))
           (x-deltas (range 1 (length other-pieces)))
           (y-deltas (map (lambda (y) (abs (- y first-piece))) other-pieces))
           (deltas (zip x-deltas y-deltas))
           (unsafe (filter (lambda (xy) (= (first xy) (second xy))) deltas)))
      (if (null? unsafe)
        (safe? other-pieces)
        #f))))

(define (queens size)
  (let ((board (build-board size)))
    (require (safe? board))
    board))

; sample solution: a1, b5, c8, d6, e3, f7, g2, h4
