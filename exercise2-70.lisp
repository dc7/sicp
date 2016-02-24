(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))
(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))
(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
    (list (symbol-leaf tree))
    (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
    (weight-leaf tree)
    (cadddr tree)))
(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
      '()
      (let ((next-branch
              (choose-branch (car bits) current-branch)))
        (if (leaf? next-branch)
          (cons (symbol-leaf next-branch)
                (decode-1 (cdr bits) tree))
          (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))
(define (make-leaf-set pairs)
  (if (null? pairs)
    '()
    (let ((pair (car pairs)))
      (adjoin-set (make-leaf (car pair)     ; symbol
                             (cadr pair))   ; frequency
                             (make-leaf-set (cdr pairs))))))

(define (encode-symbol letter tree)
  (if (leaf? tree)
    '()
    (if (memq letter (symbols (left-branch tree)))
      (cons 0 (encode-symbol letter (left-branch tree)))
      (cons 1 (encode-symbol letter (right-branch tree))))))

(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

(define (successive-merge set)
  (if (= 1 (length set))
    (first set)
    (let ((merged (make-code-tree (first set) (second set)))
          (rest (cddr set)))
      (successive-merge (adjoin-set merged rest)))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define pairs
  (list '(A 2)
        '(NA 16)
        '(BOOM 1)
        '(SHA 3)
        '(GET 2)
        '(YIP 9)
        '(JOB 2)
        '(WAH 1)))

(define message
  '(GET A JOB
    SHA NA NA NA NA NA NA NA NA
    GET A JOB
    SHA NA NA NA NA NA NA NA NA
    WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
    SHA BOOM))

(define tree (generate-huffman-tree pairs))
(define bits (encode message tree))
(decode bits tree)
