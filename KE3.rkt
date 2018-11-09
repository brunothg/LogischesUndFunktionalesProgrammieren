;; Aufgabe 1
(define (insert-sort liste)

  (define (insert element liste)
    (if (null? liste)
        (list element)
        (let ((firstListElement (car liste)) (restListe (cdr liste)))
          (if (< element firstListElement)
              (cons element liste)
              (cons firstListElement (insert element restListe))
          )
        )
    )
  )
  
  (if (null? liste)
    '()
    (insert (car liste) (insert-sort (cdr liste)))
  )
)

#|
(insert-sort '(2 4 1 6 4))
(insert-sort '())
(insert-sort '(3 2 1))
|#


;; Aufgabe 2.1
(define (ableiten fkt k)
  (lambda(x)
     (/
      (- (fkt (+ x k))  (fkt (- x k)))
      (* 2 k)
     )
  )
)

#|
(define (sqr x) (* x x))
(define ablsqr (ableiten sqr 0.1))
ablsqr
(ablsqr 1)
(ablsqr 2)
(ablsqr 3)
|#