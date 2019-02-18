(load "k1816-extensions.scm")
;; Übungsaufgaben aus den Kurseinheiten und den Klausurprotokollen

;; average - Berechnung des Durchschnitts zweier Zahlen
(define (average x y) (* (+ x y) 0.5))
;(average 3 7)

;; abs - Berechnung des Absolutbetrags einer Zahl
(define (abs x) (if (< x 0) (* x -1) x))
;(abs -123)

;; atom? - Testet, ob das ihr übergebene Argument ein Atom ist (mit cond)

;; atom? - Variation mit OR

;; ith - Liefert das i-te Element einer Liste zurück

;; length - Berechnet die Länge einer Liste

;; append - Listenkonkatenation

;; produkt - Gib das Produkt einer Liste von Zahlen zurück

;; sum-with - Eine Funktion (Summe von bis), die eine andere Funktion zurückgibt

;; dreimal - Gibt eine Funktion zurück, die die übergebene Funktion dreimal anwendet.

;; compose - ein Programm, dass die Komposition zweier Funktionen darstellt

;; n-mal - eine Funktion, die eine Funktion n-mal ausführt

;; filter - eine Funktion, die eine Liste und ein Prädikat als Eingabe erwartet und eine Liste der Elemente aus der Eingabeliste zurückgibt, die das Prädikat erfüllen

;; insert - Fügt ein Element sortiert in eine Liste ein

;; gerade? - Prüft, ob ein Element in einer Liste enthalten ist

;; last - Überprüft, ob ein Element das letzte Element einer Liste ist

;; right reduce Funktion für Listenkonkatenation

;; sum-stream - Berechnet die Summe aller Elemente eines Stroms von Zahlen