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


#|
(define a (fib-stream))
a
(tail a)
(tail (tail a))
(tail (tail (tail a)))
(tail (tail (tail (tail a))))
(tail (tail (tail (tail (tail a)))))
|#


;; Aufgabe 1.2
#|
(define (right-reduce combine initial s)
  (if (empty-stream? s)
      initial
      (combine (head s)
                (right-reduce combine initial (tail s)))))

(define (singleton-stream e) (cons-stream e the-empty-stream))

(define (append-streams s1 s2)
  (if (empty-stream? s1)
      s2
      (cons-stream (head s1) (append-streams (tail s1) s2))))
|#

(define (map f s)
  (if (empty-stream? s)
      the-empty-stream
      (cons-stream (f (head s)) (map f(tail s)))))

(define (filter p s)
  (if (empty-stream? s)
      the-empty-stream
      (let((x (head s)))
        (if (p x)
            (cons-stream x (filter p (tail s)))
            (filter p (tail s))))))



(define (has-even-fib)
  (define (even-fib? x)
    (even? (cadr x))
  )

  (define (getn x)
    (car x)
  )
  
  (map getn (filter even-fib? (fib-stream)))
)



(define b (has-even-fib))
b
(tail b)
(tail (tail b))
(tail (tail (tail b)))
(tail (tail (tail (tail b))))
