(define (subsets s)
  (if (null? s)
    (list '())
    (let ((rest (subsets (cdr s))))
      (append rest (map (lambda (x) (cons (car s) x)) rest)))))
(display (subsets (list 1 2 3)))
(newline)
; for any element x in s, there are two kinds of subsets: those with x and
; those without x. we find the subsets without x recursively, then append a
; copy of each subset with x added back in.
