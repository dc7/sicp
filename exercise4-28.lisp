; If the operator isn't forced, it can't be used as a function. For example:

(let ((f (lambda (x) (* x x))))
  (f 2))
