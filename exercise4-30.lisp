; a. Primitive procedures such as "display" don't get delayed (see "apply").

; b. With the original eval-sequence, the values of (p1 1) and (p2 1) are (1 2)
; and 1, respectively. With Cy’s eval-sequence, the results are (1 2) for both
; expressions.

; c. See a.

; d. I prefer lazy everything, but I realize that lisp relies heavily on
; assignment.
