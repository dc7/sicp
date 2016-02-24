(define (make-point x y)
  (cons x y))
(define (x-point a)
  (car a))
(define (y-point a)
  (cdr a))
(define (print-point p)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  (newline))
; (define (make-rectangle a b c d)
;   (cons (cons a b)
;         (cons c d)))
; (define (first-point r)
;   (caar r))
; (define (second-point r)
;   (cdar r))
; (define (third-point r)
;   (cadr r))
; (define (fourth-point r)
;   (cddr r))
(define (make-rectangle a b c d)
  (list a b c d))
(define (first-point r)
  (car r))
(define (second-point r)
  (cadr r))
(define (third-point r)
  (caddr r))
(define (fourth-point r)
  (cadddr r))
(define (square x)
  (* x x))
(define (point-distance a b)
  (sqrt (+ (square (- (x-point a)
                      (x-point b)))
           (square (- (y-point a)
                      (y-point b))))))
(define (perimeter r)
  (+ (point-distance (first-point r)
                     (second-point r))
     (point-distance (second-point r)
                     (third-point r))
     (point-distance (third-point r)
                     (fourth-point r))
     (point-distance (fourth-point r)
                     (first-point r))))
(define (area r)
  (* (point-distance (first-point r)
                     (second-point r))
     (point-distance (second-point r)
                     (third-point r))))
(print (point-distance (make-point 1 2)
                       (make-point 3 4)))
(newline)
(define my-rect
  (make-rectangle (make-point 1 2)
                  (make-point 3 4)
                  (make-point 5 6)
                  (make-point 7 8)))
(print (perimeter my-rect))
(newline)
(print (area my-rect))
(newline)
