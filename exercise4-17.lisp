(lambda <vars>
  (define u <e1>)
  (define v <e2>)
  <e3>)

; would be transformed into

(lambda <vars>
  (let ((u '*unassigned*)
        (v '*unassigned*))
    (set! u <e1>)
    (set! v <e2>)
    <e3>))


; Why is there an extra frame in the transformed program?

; Here we have a "let" inside of a lambda, but the let is also being transformed
; into a lambda. The latter gives us an extra frame.


; Explain why this difference in environment structure can never make a
; difference in the behavior of a correct program.

; I don't see how it could make a difference. In both programs, any outer "u"s
; and "v"s are hidden by the new definitions. 


; Design a way to make the interpreter implement the ``simultaneous'' scope rule
; for internal definitions without constructing the extra frame.

; As mentioned in the text, as long as all variables are defined before use, the
; two forms are equivalent. Move definitions to the beginning of function
; bodies.
