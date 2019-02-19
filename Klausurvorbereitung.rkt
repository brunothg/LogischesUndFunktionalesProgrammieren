(load "k1816-extensions.scm")
;; Übungsaufgaben aus den Kurseinheiten und den Klausurprotokollen

;; average - Berechnung des Durchschnitts zweier Zahlen
(define (average x y) (* (+ x y) 0.5))
;(average 3 7)

;; abs - Berechnung des Absolutbetrags einer Zahl
(define (abs x) (if (< x 0) (* x -1) x))
;(abs -123)

;; atom? - Testet, ob das ihr übergebene Argument ein Atom ist (mit cond)
(define (atom? x) (
     cond
      ((boolean? x) #t)
      ((number? x) #t)
      ((string? x) #t)
      ((symbol? x) #t)
      (else #f)
))
;(atom? 1) (atom? atom?) (atom? "abc") (atom? 'abc)

;; atom? - Variation mit OR
(define (atom? x) (
     if
      (or (boolean? x) (number? x) (string? x) (symbol? x))
      #t
      #f
))
;(atom? 1) (atom? atom?) (atom? "abc") (atom? 'abc)

;; ith - Liefert das i-te Element einer Liste zurück
(define (ith liste n)
  (if (> n 0)
      (ith (cdr liste) (- n 1))
      (car liste)
   )
)
;(ith '(a b c d e f g) 4)

;; length - Berechnet die Länge einer Liste
(define (length liste) 
    (define (length liste counter)(
            if (null? liste)
               counter
               (length (cdr liste) (+ counter 1))
     ))

    (length liste 0)
)
;(length '(1 2 3 4)) (length (list 1 2 3 4 5))

;; append - Listenkonkatenation
(define (append liste1 liste2)

  (cond
    ((null? liste1) liste2)
    ((null? liste2) liste1)
    (else (cons (car liste1) (append (cdr liste1) liste2)))
    )
  
  )
;(append '(a b c d) '(e f g h))

;; produkt - Gib das Produkt einer Liste von Zahlen zurück
(define (product liste)

  (define (product liste counter)
    (if (null? liste)
        counter
        (product (cdr liste) (* counter (car liste)))
     )
    )

  (product liste 1)
  )
;(product '(3 4 5))

;; sum-with - Eine Funktion (Summe von bis), die eine andere Funktion zurückgibt
(define (sum-with func)

  (define (sum-with von bis func counter)

    (if (> von bis)
        counter
        (sum-with (+ von 1) bis func (+ counter (func von)))
     )
    
    )
  
  (lambda (von bis) (sum-with von bis func 0))
  )
;(define sumsquare (sum-with (lambda (n) (* n n)))) (sumsquare 3 5)

;; dreimal - Gibt eine Funktion zurück, die die übergebene Funktion dreimal anwendet.
(define (dreimal f) (lambda (x) (f(f(f x)))))
;(define (p1 x) (+ x 1)) (let ((f (dreimal p1))) (f 5))

;; n-mal - eine Funktion, die eine Funktion n-mal ausführt
(define (n-mal n f) (
     if (> n 0)
        (begin
          (f)
          (n-mal (- n 1) f)
          )
))
;(n-mal 3 (lambda () (begin (display 1) (newline))))

;; filter - eine Funktion, die eine Liste und ein Prädikat als Eingabe erwartet und eine Liste der Elemente aus der Eingabeliste zurückgibt, die das Prädikat erfüllen
(define (filter liste check)

  (cond
    ((null? liste) '())
    ((check (car liste)) (cons (car liste) (filter (cdr liste) check)))
    (else (filter (cdr liste) check))
    )
  
  )
;(filter '(1 2 3 4 5 6 7 8 9) (lambda (x) (= 0 (modulo x 2))))

;; insert - Fügt ein Element sortiert in eine Liste ein
(define (insert liste ele)

  (if (null? liste)
      (cons ele '())
      (begin

        (if (<= ele (car liste))
            (cons ele liste)
            (cons (car liste) (insert (cdr liste) ele))
         )
        
        )
      )
  
  )
;(insert '(1 2 3 5 6) 4)

;; gerade? - Prüft, ob eine Zahl gerade ist
(define (gerade? x) (= (modulo x 2) 0))
;(gerade? 5) (gerade? 6)

;; member - Prüft, ob ein Element in einer Liste enthalten ist
(define (member liste ele)

  (cond
    ((null? liste) #f)
    ((eq? ele (car liste)) #t)
    (else (member (cdr liste) ele))
    )
  
  )
;(member '(a b c d e f) 'c) (member '(a b d e f) 'c)

;; last - Überprüft, ob ein Element das letzte Element einer Liste ist
(define (last liste ele)

  (cond
    ((null? liste) #f)
    ((and (eq? ele (car liste)) (null? (cdr liste))) #t)
    (else (last (cdr liste) ele))
    )
  
  )
;(last '(a b c) 'c) (last '(a b c d e f) 'c)

;; Definition der Stream-Funktionen.

(define the-empty-stream '())

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream x y)
     (cons x (delay y)))))

(define head car)
(define (tail s) (force (cdr s)))
(define empty-stream? null?) 
