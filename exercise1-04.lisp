#!/usr/bin/guile
!#
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
# here + and - are functions
# to be applied to a and b
(display (a-plus-abs-b 1 1))
(newline)
(display (a-plus-abs-b 1 0))
(newline)
(display (a-plus-abs-b 1 -1))
