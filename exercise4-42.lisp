(define (half-true x y)
  (or
    (and x (not y))
    (and (not x) y)))

(define (liars)
  (let ((betty (amb 1 2 3 4 5))
        (ethel (amb 1 2 3 4 5))
        (joan (amb 1 2 3 4 5))
        (kitty (amb 1 2 3 4 5))
        (mary (amb 1 2 3 4 5)))
    (require (distinct? (list betty ethel joan kitty mary)))
    (require (half-true (= kitty 2) (= betty 3)))
    (require (half-true (= ethel 1) (= joan 2)))
    (require (half-true (= joan 3) (= ethel 5)))
    (require (half-true (= kitty 2) (= mary 4)))
    (require (half-true (= mary 4) (= betty 1)))
    (list betty ethel joan kitty mary)))

; solution: kitty, joan, betty, mary, ethel
