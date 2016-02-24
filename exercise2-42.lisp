(define (flatmap proc seq)
  (foldr append '() (map proc seq)))
(define (enumerate-interval low high)
  (if (> low high)
    '()
    (cons low (enumerate-interval (+ low 1) high))))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list empty-board)
      (filter
        (lambda (positions) (safe? k positions))
        (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define empty-board '())

(define (adjoin-position new-row k rest-of-queens)
  (if (null? rest-of-queens)
    (list new-row)
    (map (lambda (old-position) (flatten (cons old-position new-row))) rest-of-queens)))

(define (safe-pair? board i j)
  (let ((delta (- j i))
        (ival (list-ref board (- i 1)))
        (jval (list-ref board (- j 1))))
    (not (or (= ival jval)
             (= ival (- jval delta))
             (= ival (+ jval delta))))))

(define (safe-position? board k)
  (foldr (lambda (x y) (and x y))
         #t
         (flatmap (lambda (i) (map (lambda (j) (safe-pair? board i j))
                                   (range (+ i 1) (+ k 1))))
                  (range 1 (+ k 1)))))

(define (safe? k positions)
  (foldr (lambda (x y) (and x y))
         #t
         (map (lambda (position) (safe-position? position k))
                  positions)))

(display (queens 8))
(newline)
