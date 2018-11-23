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



#|
(define b (has-even-fib))
b
(tail b)
(tail (tail b))
(tail (tail (tail b)))
(tail (tail (tail (tail b))))
|#


;; Aufgabe 2

(define (ggT a b)
  (cond
    ((= a b) a) ;; a, falls a=b
    ((= a 0) b) ;; b, falls a=0
    ((= b 0) a) ;; a, falls b=0
    ((< a b) (ggT a (- b a))) ;; ggT(a,b-a), falls a<b
    (else (ggT b (- a b))) ;; ggT(b,a-b), falls b<a !else
  )
)


(define (brueche)
  (define m 1)
  (define n 2)

  (define (next-bruch)
    (let ((tM m)(tN n))
      (set! m (+ m 1))
      (if (= m n)
          (begin
            (set! m 1)
            (set! n (+ n 1))
          )
      )

      (cons-stream (cons tM tN) (next-bruch))
    )
  )

  (define (filterfunc x)
    (if (= (ggT (car x) (cdr x)) 1)
        #t
        #f
    )
  )

  (filter filterfunc (next-bruch))
)


#|
(define b (brueche))
b
(tail b)
(tail (tail b))
(tail (tail (tail b)))
(tail (tail (tail (tail b))))
(tail (tail (tail (tail (tail b)))))
|#



;; Aufgabe 3

(define (make-cd-control)
  (define cd-status 'leer) ;; leer oder cd
  (define titelzahl 0) ;; Anzahl der verfügbaren Titel der aktuellen CD oder 0
  (define titel 0) ;; Der aktuell selektierte Titel oder 0
  (define abspielstatus 'undefiniert) ;; abspielen, stop oder undefiniert

  (define (dispatch msg arg)
    (cond
      ((eq? msg 'einlegen)
       (if (eq? cd-status 'cd)
           'cd-fach-belegt
           (begin
             (set! cd-status 'cd)
             (set! titel 1)
             (set! abspielstatus 'stop)
             (set! titelzahl arg)
           )
       )
      )
      ((eq? msg 'auswerfen)
       (if (eq? cd-status 'leer)
           'ignore
           (begin
             (set! cd-status 'leer)
             (set! titel 0)
             (set! abspielstatus 'undefiniert)
             (set! titelzahl 0)
           )
       )
      )
      ((eq? msg 'abspielen)
       (if (eq? cd-status 'leer)
           'ignore
           (begin
             (set! abspielstatus 'abspielen)
           )
       )
      )
      ((eq? msg 'stop)
       (if (eq? cd-status 'leer)
           'ignore
           (begin
             (set! abspielstatus 'stop)
             (set! titel 1)
           )
       )
      )
      ((eq? msg 'vor)
       (if (or (eq? cd-status 'leer) (= titel titelzahl))
           'ignore
           (begin
             (set! titel (+ titel 1))
           )
       )
      )
      ((eq? msg 'zurueck)
       (if (or (eq? cd-status 'leer) (= titel 1))
           'ignore
           (begin
             (set! titel (1 titel 1))
           )
       )
      )
      ((eq? msg 'test) (list cd-status abspielstatus titelzahl titel))
      (else 'ignore)
    )
  )
  
  dispatch
)


#|
(define cd1 (make-cd-control))
(cd1 'einlegen 4)
(cd1 'vor 'dummy)
(cd1 'vor 'dummy)
(cd1 'abspielen 'dummy)
(cd1 'vor 'dummy)
(cd1 'vor 'dummy)
(cd1 'vor 'dummy)
(cd1 'test 'dummy)
(cd1 'einlegen 10)
(cd1 'auswerfen 'dummy)
(cd1 'test 'dummy)
|#