(load "k1816-extensions.scm")

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
          (if (eq? elekey schluessel)
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



;; Aufgabe 3.2
(define (make-empty-as)

  (define (as-find schluessel liste)

    (if (null? liste)
        '()
        (let ((ele (car liste)) (rest (cdr liste)))
          (let ((elekey (car ele)) (elevalue (car(cdr ele))))
            (if (eq? elekey schluessel)
                (cons elevalue (as-find schluessel rest))
                (as-find schluessel rest)
                )
            )
          )
        )
    )

  (define (valid-data? data)
    (cond

      ((null? data) #f) ;; Leere Liste
      
      ((not (atom? (car data))) #f) ;; Key kein Atom

      ((null? (cdr data)) #f) ;; Keine Daten

      ((not (null? (cdr (cdr data)))) #f) ;; Zu viele Elemente
      
      (else #t)
    )
  )

  
  (define (asl liste)

    (define (dispatch msg arg)
      (cond
        ((eq? msg 'cons)
         (if (valid-data? arg) (asl (cons arg liste)) (error "Muss der Form (s d) entsprechen."))
        )

        ((eq? msg 'null?)
         (if (null? liste) #t #f)
        )

        ((eq? msg 'find)
         (as-find arg liste)
        )

        ((eq? msg 'car)
         (if (null? liste) '() (car liste))
        )

        ((eq? msg 'cdr)
         (if (null? liste) (asl '()) (asl (cdr liste)))
        )
      
        (else (error "Ich verstehe die Nachricht nicht:" msg))
      )
    )

    dispatch
  )

  (asl '())
)

(define a1 (make-empty-as))
(define a2 (a1 'cons '(b 2)))
(define a3 (a2 'cons '(d 4)))
(define a4 (a3 'cons '(c 5)))
(define a5 (a4 'cons '(a 6)))
(define a6 (a5 'cons '(c 4)))
(define a7 (a6 'cons '(b 7)))
(define a8 (a7 'cons '(a 1)))

#|
(a1 'null? 'dummy)
(a8 'null? 'dummy)
(a8 'find 'b)
(a8 'find 'a)
(a7 'find 'a)
(a1 'car 'dummy)
(a8 'car 'dummy)
((a8 'cdr 'dummy) 'find 'a)
|#


;; Aufgabe 3.3
(define (as-show asl)

  (define (build-list asl liste)
    (if (null? (asl 'car 'dummy))
        liste
        (cons (asl 'car 'dummy) (build-list (asl 'cdr 'dummy) liste))
    )
   )

  (build-list asl '())
)

#|
(as-show a1)
(as-show a2)
(as-show a8)
|#