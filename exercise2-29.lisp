(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

(define left-branch car)
(define right-branch cadr)
(define branch-length car)
(define branch-structure cadr)

(define (total-weight x)
  (if (not (pair? x))
    x
    (+ (total-weight (branch-structure (left-branch x)))
       (total-weight (branch-structure (right-branch x))))))

(define x (make-mobile (make-branch 3 (make-mobile
                                        (make-branch 1 2)
                                        (make-branch 1 2)))
                       (make-branch 3 4)))
(display (total-weight x))
(newline)

(define (balanced? x)
  (if (not (pair? x))
    #t
    (and (= (* (branch-length (left-branch x))
               (total-weight (branch-structure (left-branch x))))
            (* (branch-length (right-branch x))
               (total-weight (branch-structure (right-branch x)))))
         (balanced? (branch-structure (left-branch x)))
         (balanced? (branch-structure (right-branch x))))))

(display (balanced? x))
(newline)

(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))

; we just need to change the selectors to match the constructors and update any old data structures

(define right-branch cdr)
(define branch-structure cdr)

(define x (make-mobile (make-branch 3 (make-mobile
                                        (make-branch 1 2)
                                        (make-branch 1 2)))
                       (make-branch 3 4)))

(display (total-weight x))
(newline)
(display (balanced? x))
(newline)
