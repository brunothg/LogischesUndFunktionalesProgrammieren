(load "k1816-extensions.scm")

;; Grundfunktionen
#|
(define (force x) (x))
(define the-empty-stream '())
(define empty-stream? null?)
(define-syntax cons-stream (syntax-rules () ((cons-stream x y) (cons x (delay y)))))
(define head car)
(define (tail s) (force (cdr s)))
|#

;; Aufgabe 1.1

(define (fib-stream)
  (define a 0)
  (define b 1)
  
  (define (fib n)
    (cond
      ((= 0 n) (cons-stream (cons n (cons a '())) (fib (+ n 1)))) ;; Erster Schritt
      ((= 1 n) (cons-stream (cons n (cons b '())) (fib (+ n 1)))) ;; Zweiter Schritt
      (else (let ((c (+ a b)))
              (set! a b)
              (set! b c)
              (cons-stream (cons n (cons c '())) (fib (+ n 1)))
      )) ;; Alle weiteren Schritte
    )
  )

 
  (fib 0)
)


(define a (fib-stream))
a
(tail a)
(tail (tail a))
(tail (tail (tail a)))
(tail (tail (tail (tail a))))
(tail (tail (tail (tail (tail a)))))
