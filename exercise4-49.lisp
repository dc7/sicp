(load "/home/daniel/sicp/evaluator-nondeterministic.lisp")

(define (require p)
  (if (not p) (amb)))

(define *unparsed* '())
(define articles '(the a))
(define nouns '(student professor cat class))
(define prepositions '(for to in by with))
(define verbs '(studies lectures eats sleeps))

(define (parse-noun-phrase)
  (define (maybe-extend noun-phrase)
    (amb noun-phrase
         (maybe-extend (list 'noun-phrase
                             noun-phrase
                             (parse-prepositional-phrase)))))
  (maybe-extend (parse-simple-noun-phrase)))

(define (parse-prepositional-phrase)
  (list 'prep-phrase
        (parse-word prepositions)
        (parse-noun-phrase)))

(define (parse-sentence)
  (list 'sentence
        (parse-noun-phrase)
        (parse-verb-phrase)))

(define (parse-simple-noun-phrase)
  (list 'simple-noun-phrase
        (parse-word articles)
        (parse-word nouns)))

(define (parse-verb-phrase)
  (define (maybe-extend verb-phrase)
    (amb verb-phrase
         (maybe-extend (list 'verb-phrase
                             verb-phrase
                             (parse-prepositional-phrase)))))
  (maybe-extend (parse-word verbs)))

; (define (parse-word word-list)
;   (require (not (null? *unparsed*)))
;   (require (memq (car *unparsed*) (cdr word-list)))
;   (let ((found-word (car *unparsed*)))
;     (set! *unparsed* (cdr *unparsed*))
;     (list (car word-list) found-word)))

(define (in-list lst)
  (if (null? lst)
    (amb)
    (amb (car lst) (in-list (cdr lst)))))

(define (parse-word word-list)
  (in-list word-list))

(define (parse input)
  (set! *unparsed* input)
  (let ((sent (parse-sentence)))
    (require (null? *unparsed*))
    sent))

(parse-sentence)
try-again
try-again
try-again
try-again
try-again

; solution

; the student studies
; the student studies for the student
; the student studies for the student for the student
; the student studies for the student for the student for the student
; the student studies for the student for the student for the student for the student
; the student studies for the student for the student for the student for the student for the student
