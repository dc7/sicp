(define f
  (let ((first-run #t))
    (lambda (x)
      (if first-run
        (begin (set! first-run #f)
               x)
        0))))
(f 0)
(f 1)

(define f
  (let ((first-run #t))
    (lambda (x)
      (if first-run
        (begin (set! first-run #f)
               x)
        0))))
(f 1)
(f 0)
