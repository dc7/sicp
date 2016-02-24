(define make-vect cons)
(define xcor-vect car)
(define ycor-vect cdr)
(define (add-vect a b)
  (make-vect (+ (xcor-vect a)
                (xcor-vect b))
             (+ (ycor-vect a)
                (ycor-vect b))))
(define (sub-vect a b)
  (make-vect (- (xcor-vect a)
                (xcor-vect b))
             (- (ycor-vect a)
                (ycor-vect b))))
(define (scale-vect a s)
  (make-vect (* (xcor-vect a)
                s)
             (* (ycor-vect a)
                s)))

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define origin-frame first)
(define edge1-frame second)
(define edge2-frame third)

(define my-frame (make-frame (make-vect 1 2)
                             (make-vect 3 4)
                             (make-vect 5 6)))
(display (origin-frame my-frame))
(newline)
(display (edge1-frame my-frame))
(newline)
(display (edge2-frame my-frame))
(newline)

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define origin-frame car)
(define edge1-frame cadr)
(define edge2-frame cddr)