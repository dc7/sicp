 (define (apply-generic op . args) 
 (define (higher-type types) 
  (define (iter x types) 
    (cond ((null? types) x) 
          ((> (level x) (level (car types))) 
           (iter x (cdr types))) 
          (else  
           (iter (car types) (cdr types))))) 
  (if (null? (cdr types)) (car types) (iter (car types) (cdr types)))) 
  (define (raise-args args level-high-type) 
    (define (iter-raise arg level-high-type) 
      (if (< (level (type-tag arg)) level-high-type) 
          (iter-raise (raise arg) level-high-type) 
          arg)) 
    (map (lambda (arg) (iter-raise arg level-high-type)) args)) 
(define (not-all-same-type? lst) 
  (define (loop lst) 
    (cond ((null? lst) #f) 
          ((eq? #f (car lst)) #t) 
          (else (loop (cdr lst))))) 
  (loop (map (lambda (x) (eq? (car lst) x)) 
     (cdr lst)))) 
 
  (let ((type-tags (map type-tag args))) 
    (let ((proc (get op type-tags))) 
      (if proc                   
          (apply proc (map contents args)) 
          (if (not-all-same-type? type-tags)    ; only raise if the args are not 
;; all of the same type, if they are, then there is not "op" for them.  
              (let ((high-type (higher-type type-tags))) 
                (let ((raised-args (raise-args args (level high-type)))) 
                  (apply apply-generic (cons op raised-args)))) 
              (error  
               "No Method for these types -- APPLY-GENERIC" 
               (list op type-tags))))))) 
 
 
; The level procedure. 
 
(define (level type) 
  (get 'level type)) 
 
; The package of the levels. Each of these statements, can be placed in the  
; package of the number type it belongs to. I have done it here for the  
; exercise. Also I have a polar and rectangular level just in case level gets 
; called with a complex number without the 'complex tag.  
 
(define (install-level-package) 
  (put 'level 'scheme-number 1) 
  (put 'level 'rational 2) 
  (put 'level 'real 3) 
  (put 'level 'complex 4) 
  (put 'level 'rectangular 4) 
  (put 'level 'polar 4) 
  'done) 
 
(install-level-package) 
