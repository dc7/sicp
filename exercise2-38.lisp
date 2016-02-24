(display (foldr / 1 '(1 2 3)))
(newline)
(display (foldl / 1 '(1 2 3)))
(newline)
(display (foldr list '() '(1 2 3)))
(newline)
(display (foldl list '() '(1 2 3)))
(newline)

; op must be commutative
