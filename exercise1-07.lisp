#!/usr/bin/guile
!#
(define (square x)
  (* x x))
(define (average x y)
  (/ (+ x y) 2))
(define (improve guess x)
  (average guess (/ x guess)))
(define (new-sqrt-iter guess x good-enough?)
  (if (good-enough? guess x)
	guess
	(new-sqrt-iter (improve guess x) x good-enough?)))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
(define (new-good-enough? guess x)
  (< (abs (- (square guess) x)) (* 0.001 x)))
(display (rationalize (new-sqrt-iter 1 5 good-enough?) 0.0000001))
(newline)
(display (rationalize (new-sqrt-iter 1 5 new-good-enough?) 0.0000001))
(newline)
(display (rationalize (new-sqrt-iter 1 50000 good-enough?) 0.0000001))
(newline)
(display (rationalize (new-sqrt-iter 1 50000 new-good-enough?) 0.0000001))
(newline)
(display (rationalize (new-sqrt-iter 1 0.000001 good-enough?) 0.0000001))
(newline)
(display (rationalize (new-sqrt-iter 1 0.000001 new-good-enough?) 0.0000001))
# the new function works better on small numbers, since the
# epsilon is scaled down proportionally, but worse on large
# numbers, since e.g. 0.001 * 50000 = 50 >>> 0.001
