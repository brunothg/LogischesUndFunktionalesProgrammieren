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




;; Aufgabe 2.2
(define (abs x) (if (< x 0) (* -1 x) x))

(define (make-nstf f)
  (define fabl (ableiten f 1e-06))

  (define (schritt x)
    (define xnpe (- x (/ (f x) (fabl x))))
    
    (if (< (abs (- (f x) (f xnpe))) 0.0001)
        xnpe
        (schritt xnpe)
    )
  )
  
  (lambda(x)
    (schritt x)
  )
)

#|
(define (myfunc x) (- (* 3 x x) 2))
(define nstf (make-nstf myfunc))
(nstf 2)
(nstf -2)
|#



;; Aufgabe 3.1
(define (as-find schluessel liste)

  (if (null? liste)
      '()
      (let ((ele (car liste)) (rest (cdr liste)))
        (let ((elekey (car ele)) (elevalue (car(cdr ele))))
          (if (equal? elekey schluessel)
              (cons elevalue (as-find schluessel rest))
              (as-find schluessel rest)
              )
          )
        )
  )
)

#|
(as-find 'b '((a 1) (b 7) (c 4) (a 6) (c 5) (d 4) (b 2)))
(as-find 'a '((a 1) (b 7) (c 4) (a 6) (c 5) (d 4) (b 2)))
(as-find 'e '((a 1) (b 7) (c 4) (a 6) (c 5) (d 4) (b 2)))
|#