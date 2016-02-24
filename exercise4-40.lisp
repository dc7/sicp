; Before the requirement, there are 5 * 5 * 5 * 5 * 5 = 3125 combinations. Only
; 5 * 4 * 3 * 2 * 1 = 120 of those are distinct.

(define (in-list lst)
  (if (null? lst)
    (amb)
    (amb (car lst) (in-list (cdr lst)))))

(define (multiple-dwelling)
  (let* ((floors '(1 2 3 4 5))
         (baker (in-list floors))
         (not-baker (delete baker floors))
         (cooper (in-list not-baker))
         (not-cooper (delete cooper not-baker))
         (fletcher (in-list not-cooper))
         (not-fletcher (delete fletcher not-cooper))
         (miller (in-list not-fletcher))
         (not-miller (delete miller not-fletcher))
         (smith (in-list not-miller)))
    (require (not (= baker 5)))
    (require (not (= cooper 1)))
    (require (not (= fletcher 5)))
    (require (not (= fletcher 1)))
    (require (> miller cooper))
    (require (not (= (abs (- smith fletcher)) 1)))
    (require (not (= (abs (- fletcher cooper)) 1)))
    (list (list 'baker baker) (list 'cooper cooper)
          (list 'fletcher fletcher)
          (list 'miller miller)
          (list 'smith smith))))
