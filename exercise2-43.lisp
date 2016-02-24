; correct
(flatmap
  (lambda (rest-of-queens)
    (map (lambda (new-row)
           (adjoin-position new-row k rest-of-queens))
         (enumerate-interval 1 board-size)))
  (queen-cols (- k 1)))

; incorrect
(flatmap
  (lambda (new-row)
    (map (lambda (rest-of-queens)
           (adjoin-position new-row k rest-of-queens))
         (queen-cols (- k 1))))
  (enumerate-interval 1 board-size))

; the first k-1 columns are being recalculated every time the inner function is
; applied, causing an exponential slowdown of about T^8
