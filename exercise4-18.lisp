(lambda <vars>
  (define u <e1>)
  (define v <e2>)
  <e3>)

; would be transformed into

(lambda <vars>
  (let ((u '*unassigned*)
        (v '*unassigned*))
    (let ((a <e1>)
          (b <e2>))
      (set! u a)
      (set! v b))
    <e3>))

; Here a and b are meant to represent new variable names, created by the
; interpreter, that do not appear in the user's program. Consider the solve
; procedure from section 3.5.4:

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)


; Will this procedure work if internal definitions are scanned out as shown in
; this exercise?

; In this exercise, all the right-hand values are evaluated before any of the
; left-hand values. This only works if (a b ...) don't depend on the values of
; (u v ...). (Consider if u and v are even? and odd? from before.)


; What if they are scanned out as shown in the text?

; Of course this works since all the left-hand values are evaluated before any
; of the right-hand values.
