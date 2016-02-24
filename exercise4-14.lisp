; The primitive "map" is mangling the s-expression before our evaluator can process it.

; The error message looks like this:

; The object
; (procedure
;   (x)
;   ((* x x))
;   (((my-list false true car cdr cons null? map)
;     (1 2 3 4 5) #f #t
;     (primitive #[compiled-procedure 13 ("list" #x1) #x1a #x1d4d3e2])
;     (primitive #[compiled-procedure 14 ("list" #x2) #x1a #x1d4d452])
;     (primitive #[compiled-procedure 15 ("list" #x3) #x14 #x1d4d4bc])
;     (primitive #[compiled-procedure 16 ("list" #x5) #x14 #x1d4d55c])
;     (primitive #[compiled-procedure 17 ("list" #x6) #x1a #x1d57a6a]))))
; is not applicable. 

; If "map" is defined inside the evaluator instead, it's a well-behaved function shaped like (procedure ...).
