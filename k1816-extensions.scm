;; Diese Scheme-Datei enthaelt Definitionen von Funktionen und Makros,
;; die im Kurs verwendet werden aber im aktuellen
;; Scheme-Sprachstandard nicht mehr definiert sind. Diese Datei kann
;; einfach mittels
;;
;; (load "k1816-extensions.scm")
;;
;; geladen werden.


;; Die Funktion 'error' ist im R5RS-Standard nicht mehr definiert. Diese
;; Implementierung bietet einen Workaround. Die Fehlermeldung zum
;; 'scheme-report-environment' beendet das Programm.

(define (error reason . args)
  (display "Error: ")
  (display reason)
  (for-each (lambda (arg) 
              (display " ")
              (write arg))
            args)
  (newline)
  (scheme-report-environment -1))


;; Die Praedikatfunktion 'atom?' ist im R5RS-Standard ebenfalls nicht
;; definiert.  Ein Atom ist eine Zahl, ein Symbol oder eine
;; Zeichenkette.

(define atom?
  (lambda (x)
    (or (boolean? x)
        (number? x)
        (symbol? x)
        (string? x))))


;; Definition der Stream-Funktionen.

(define the-empty-stream '())

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream x y)
     (cons x (delay y)))))

(define head car)
(define (tail s) (force (cdr s)))
(define empty-stream? null?) 
