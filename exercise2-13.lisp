; let x = (c1, t1) and y = (c2, t2)
; x * y
; = ((c1 - c1 * t1) * (c2 - c2 * t2), (c1 + c1 * t1) * (c2 + c2 * t2))
; = (c1 * c2 - c1 * t1 * c2 - c1 * c2 * t2 + c1 * c2 * t1 * t2,
;    c1 * c2 + c1 * t1 * c2 + c1 * c2 * t2 + c1 * t1 * c2 * t2)
; = ((c1 * c2) * (1 - t1 - t2 + t1 * t2), (c1 * c2) * (1 + t1 + t2 + t1 * t2))
; if t1 and t2 are small, t1 * t2 =~ 0
; (c1 * c2 * (1 - t1 - t2), c1 * c2 * (1 + t1 + t2))
; convert to center form
; (c1, -t1 - t2), (c2, t1 + t2)
; in other words, the approximate product is the sum of the tolerances
