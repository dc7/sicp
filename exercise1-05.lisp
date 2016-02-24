#!/usr/bin/guile
!#
(define (p) (p))
(define (test x y)
  (if (= x 0)
	0
	y))
(display (test 0 (p)))
# causes an infinite loop, since guile uses
# applicative order (eval, then apply)
