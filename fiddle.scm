
                                        ; some playin'
;; C-c \ to insert λ
(define even? (λ (n) (= 0 (modulo n 2))))

((λ (n) (+ 5 n)) 14)
;; => 19

;; C-u C-x C-e inserts the result in buffer
;; control the prefix by setting var 'geiser-mode-eval-to-buffer-prefix
(even? 14)
;; => #t
(even? 15)
;; => #f

(define (fibonacci x)
  (cond ((<= 1 x 2) 1)
        ((= x 0) 0)
        (else (+ (fibonacci (- x 1))
                 (fibonacci (- x 2))))
      ))

(fibonacci 15)
;; => 610

(define (range n acc)
  (if (= n 0)
      acc
      ; (cons n (range (1- n) acc))
      (append (range (1- n) acc) (list n))))

(range 8 '())
;; => (1 2 3 4 5 6 7 8)

(map fibonacci (range 11 '()))
;; => (1 1 2 3 5 8 13 21 34 55 89)

;; in "block structure"
(define (fibo-seq n)
  (define (fibonacci x)
    (cond ((<= 1 x 2) 1)
          ((= x 0) 0)
          (else (+ (fibonacci (- x 1))
                   (fibonacci (- x 2))))))
  (define (range n acc)
    (if (= n 0)
        acc
        (append (range (1- n) acc) (list n))))
  (map fibonacci (range n '()))
  )

(fibo-seq 11)
;; => (1 1 2 3 5 8 13 21 34 55 89)

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(factorial 6)
;; => 720


(define (sum l)
  (cond ((equal? l '()) 0)
	((null? (cdr l)) (car l))
	(else (sum (cons
		    (+ (car l) (car (cdr l)))
		    (cdr (cdr l))
		    ))))
  )

(sum '())
;; => 0

(sum '(1 2 3 4))
;; => 10
