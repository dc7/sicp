(define (split first-op second-op)
  (define (helper painter n)
    (if (= n 0)
      painter
      (let ((smaller (helper painter (- n 1))))
        (second-op (first-op smaller smaller) painter))))
  helper)

(define right-split (split beside below))
(define up-split (split beside below))
