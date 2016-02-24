; from rosetta code

(define (insert l n e)
  (if (= 0 n)
    (cons e l)
    (cons (car l) 
          (insert (cdr l) (- n 1) e))))

(define (seq start end)
  (if (= start end)
    (list end)
    (cons start (seq (+ start 1) end))))

(define (permute l)
  (if (null? l)
    '(())
    (apply append (map (lambda (p)
                         (map (lambda (n)
                                (insert p n (car l)))
                              (seq 0 (length p))))
                       (permute (cdr l))))))

; exercise

(define (valid? x)
  (let ((baker (first x))
        (cooper (second x))
        (fletcher (third x))
        (miller (fourth x))
        (smith (fifth x)))
    (and (distinct? (list baker cooper fletcher miller smith))
         (not (= baker 5))
         (not (= cooper 1))
         (not (= fletcher 5))
         (not (= fletcher 1))
         (> miller cooper)
         (not (= (abs (- smith fletcher)) 1))
         (not (= (abs (- fletcher cooper)) 1)))))

(filter valid? (permute '(1 2 3 4 5)))
