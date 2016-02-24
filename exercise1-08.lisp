#!/usr/bin/guile
!#
(define (cube x)
  (* x x x))
(define (average x y)
  (/ (+ x y) 2))
(define (cube-iter guess x)
  (if (good-enough? guess x)
	guess
	(cube-iter (new-improve guess x) x)))
(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001))
(define (new-improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))
(display (rationalize (cube-iter 1 5) 0.0000001))
