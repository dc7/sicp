#!/usr/bin/guile
!#
(define sum-of-larger-squares
  (lambda (a b c)
	(cond
	  ((and
		 (> a c)
		 (> b c))
	   (+
		 (* a a)
		 (* b b)))
	  ((and
		 (> a b)
		 (> c b))
	   (+
		 (* a a)
		 (* c c)))
	  (else
		(+
		  (* b b)
		  (* c c))))))
(display (sum-of-larger-squares 1 1 1))
(newline)
(display (sum-of-larger-squares 1 2 2))
(newline)
(display (sum-of-larger-squares 2 2 1))
(newline)
(display (sum-of-larger-squares 2 1 2))
(newline)
(display (sum-of-larger-squares 1 2 3))
(newline)
(display (sum-of-larger-squares 3 2 1))
(newline)
(display (sum-of-larger-squares 2 3 1))
