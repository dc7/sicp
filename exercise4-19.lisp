(let ((a 1))
  (define (f x)
    (define b (+ a x))
    (define a 5)
    (+ a b))
  (f 10))

; Ben: b = 11, a = 5, a + b = 16
; Alyssa: error (a unassigned when b computed)
; Eva: a = 5, b = 15, a + b = 20


; Which (if any) of these viewpoints do you support?

; Ben is correct. Scheme uses eager evaluation, so when "b" is defined on line
; 3, we save the value of (eval (+ a x)) where a = 1 and x = 10, giving b = 11.


; Can you devise a way to implement internal definitions so that they behave as
; Eva prefers?

; You could implement lazy evaluation or a let* form.
