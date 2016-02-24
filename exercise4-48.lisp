(load "/home/daniel/sicp/evaluator-nondeterministic.lisp")

(define (require p)
  (if (not p) (amb)))

(define *unparsed* '())
(define articles '(article the a))
(define nouns '(noun student professor cat class))
(define prepositions '(prep for to in by with))
(define verbs '(verb studies lectures eats sleeps))
(define conjunctions '(conj for and nor but or yet so))

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
  (define (maybe-extend sentence)
    (amb sentence
         (maybe-extend (list 'sentence
                             sentence
                             (parse-word conjunctions)
                             (parse-sentence)))))
  (maybe-extend (parse-simple-sentence)))

(define (parse-simple-sentence)
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

(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (require (memq (car *unparsed*) (cdr word-list)))
  (let ((found-word (car *unparsed*)))
    (set! *unparsed* (cdr *unparsed*))
    (list (car word-list) found-word)))

(define (parse input)
  (set! *unparsed* input)
  (let ((sent (parse-sentence)))
    (require (null? *unparsed*))
    sent))

(parse '(the professor lectures but the cat eats and the student sleeps))

try-again

; solution

; (sentence
;   (sentence
;     (simple-noun-phrase (article the) (noun professor)) (verb lectures))
;   (conj but)
;   (sentence
;     (sentence
;       (simple-noun-phrase (article the) (noun cat)) (verb eats))
;     (conj and)
;     (sentence
;       (simple-noun-phrase (article the) (noun student)) (verb sleeps))))
