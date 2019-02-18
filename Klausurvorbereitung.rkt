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

;; produkt - Gib das Produkt einer Liste von Zahlen zurück

;; sum-with - Eine Funktion (Summe von bis), die eine andere Funktion zurückgibt

;; dreimal - Gibt eine Funktion zurück, die die übergebene Funktion dreimal anwendet.
(define (dreimal f) (lambda (x) (f(f(f x)))))
;(define (p1 x) (+ x 1)) (let ((f (dreimal p1))) (f 5))

;; compose - ein Programm, dass die Komposition zweier Funktionen darstellt

;; n-mal - eine Funktion, die eine Funktion n-mal ausführt
(define (n-mal n f) (
     if (> n 0)
        (begin
          (f)
          (n-mal (- n 1) f)
          )
))
;;(n-mal 3 (lambda () (begin (display 1) (newline))))

;; filter - eine Funktion, die eine Liste und ein Prädikat als Eingabe erwartet und eine Liste der Elemente aus der Eingabeliste zurückgibt, die das Prädikat erfüllen

;; insert - Fügt ein Element sortiert in eine Liste ein

;; gerade? - Prüft, ob eine Zahl gerade ist
(define (gerade? x) (= (modulo x 2) 0))
;(gerade? 5) (gerade? 6)

;; member - Prüft, ob ein Element in einer Liste enthalten ist

;; last - Überprüft, ob ein Element das letzte Element einer Liste ist

;; right reduce Funktion für Listenkonkatenation

;; sum-stream - Berechnet die Summe aller Elemente eines Stroms von Zahlen