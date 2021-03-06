(define accumulate foldr)
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    '()
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))
(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v)) m))
(define (transpose mat)
  (accumulate-n cons '() mat))
(define (matrix-*-matrix m n)
  (map (lambda (row)
         (map (lambda (col)
                (dot-product row col))
              (transpose n)))
       m))

(define my-matrix (list (list 1 2 3)
                        (list 4 5 6)
                        (list 7 8 9)))
(define my-vector (list 10 11 12))
(display (dot-product my-vector my-vector))
(newline)
(display (matrix-*-vector my-matrix my-vector))
(newline)
(display (transpose my-matrix))
(newline)
(display (matrix-*-matrix my-matrix my-matrix))
(newline)
