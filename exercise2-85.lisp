; First, project, the project package and drop. 
 
(define (project arg) 
  (apply-generic 'project arg)) 
 
(define (install-project-package) 
  ;; internal procedures 
  (define (complex->real x) 
    (make-real (real-part x))) 
  (define (real->integer x) 
    (round x)) 
  (define (rational->integer x) 
    (round (/ (car x) (cdr x)))) 
  ;; interface with system 
  (put 'project '(complex) 
       (lambda (x) (complex->real x))) 
  (put 'project '(real) 
       (lambda (x) (real->integer x))) 
  (put 'project '(rational) 
       (lambda (x) (rational->integer x))) 
  'done) 
 
(install-project-package) 
 
(define (drop arg) 
  (cond ((eq? (type-tag arg) 'scheme-number) arg) 
        ((equ? arg (raise (project arg))) 
         (drop (project arg))) 
        (else arg))) 
 
;; Here is my complete apply generic function. The change is the If statement 
;; after proc. It tests to see if it is a 'raise operation, or an 'equ?  
;; operation. If it is, is keeps the result as is, else it "drop"s it.  
 
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
           (let ((res (apply proc (map contents args)))) 
             (if (or (eq? op 'raise) (eq? op 'equ?)) res (drop res))) 
           (if (not-all-same-type? type-tags) 
               (let ((high-type (higher-type type-tags))) 
                 (let ((raised-args (raise-args args (level high-type)))) 
                   (apply apply-generic (cons op raised-args)))) 
               (error  
                "No Method for these types -- APPLY-GENERIC" 
                (list op type-tags))))))) 
