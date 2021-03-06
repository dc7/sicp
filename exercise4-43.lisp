(define (fathers)
  (let* ((hood-yacht 'gabrielle)
         (moore-yacht 'lorna)
         (hall-yacht 'rosalind)
         (downing-yacht 'melissa)
         (parker-yacht 'mary-ann)
         (moore-daughter 'mary-ann)
         (hood-daughter 'melissa)
         (hall-daughter (amb 'gabrielle 'lorna 'rosalind))
         (downing-daughter (amb 'gabrielle 'lorna 'rosalind))
         (parker-daughter (amb 'gabrielle 'lorna 'rosalind))
         (gabrielle-father (cond ((equal? hall-daughter 'gabrielle) 'hall)
                                 ((equal? downing-daughter 'gabrielle) 'downing)
                                 ((equal? parker-daughter 'gabrielle) 'parker)))
         (gabrielle-father-yacht (cond ((equal? gabrielle-father 'moore) moore-yacht)
                                       ((equal? gabrielle-father 'hall) hall-yacht)
                                       ((equal? gabrielle-father 'parker) parker-yacht)
                                       ((equal? gabrielle-father 'downing) downing-yacht))))
    (require (distinct? (list hall-daughter downing-daughter parker-daughter)))
    (require (not (equal? hall-daughter hall-yacht)))
    (require (not (equal? downing-daughter downing-yacht)))
    (require (not (equal? parker-daughter parker-yacht)))
    (require (not (equal? parker-daughter 'gabrielle)))
    (require (equal? gabrielle-father-yacht parker-daughter))
    (cond ((equal? hall-daughter 'lorna) 'hall)
          ((equal? downing-daughter 'lorna) 'downing)
          ((equal? parker-daughter 'lorna) 'parker))))

(fathers)

; solution: Colonel Downing

(define (fathers)
  (let* ((hood-yacht 'gabrielle)
         (moore-yacht 'lorna)
         (hall-yacht 'rosalind)
         (downing-yacht 'melissa)
         (parker-yacht 'mary-ann)
         (hood-daughter 'melissa)
         (moore-daughter (amb 'mary-ann 'gabrielle 'lorna 'rosalind))
         (hall-daughter (amb 'mary-ann 'gabrielle 'lorna 'rosalind))
         (downing-daughter (amb 'mary-ann 'gabrielle 'lorna 'rosalind))
         (parker-daughter (amb 'mary-ann 'gabrielle 'lorna 'rosalind))
         (gabrielle-father (cond ((equal? moore-daughter 'gabrielle) 'moore)
                                 ((equal? hall-daughter 'gabrielle) 'hall)
                                 ((equal? downing-daughter 'gabrielle) 'downing)
                                 ((equal? parker-daughter 'gabrielle) 'parker)))
         (gabrielle-father-yacht (cond ((equal? gabrielle-father 'moore) moore-yacht)
                                       ((equal? gabrielle-father 'hall) hall-yacht)
                                       ((equal? gabrielle-father 'parker) parker-yacht)
                                       ((equal? gabrielle-father 'downing) downing-yacht))))
    (require (distinct? (list moore-daughter hall-daughter downing-daughter parker-daughter)))
    (require (not (equal? moore-daughter moore-yacht)))
    (require (not (equal? hall-daughter hall-yacht)))
    (require (not (equal? downing-daughter downing-yacht)))
    (require (not (equal? parker-daughter parker-yacht)))
    (require (not (equal? parker-daughter 'gabrielle)))
    (require (equal? gabrielle-father-yacht parker-daughter))
    (list moore-daughter hall-daughter downing-daughter parker-daughter)))

(fathers)

; If Mary Ann's last name is unknown, there is a second solution where Lorna's
; father is Dr. Parker.
