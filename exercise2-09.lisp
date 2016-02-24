; take interval x = (a, b) and interval y = (c, d)
; width of x = (b - a) / 2
; a = b - 2x
; b = a + 2x
; width of y = (d - c) / 2
; c = d - 2x
; d = c + 2x
; width of x + y = ((b + d) - (a + c)) / 2
; = ((b - a) + (d - c)) / 2
; = (b - a) / 2 + (d - c) / 2
; = width of x + width of y

; however, the width of the product of intervals is not defined by the product
; of the widths. for example, there are an infinite number of intervals with
; width 1, such as (1, 2) and (3, 4). the product of the widths will always be
; 1, but the width of the product here is 5 and can be arbitrarily large.
