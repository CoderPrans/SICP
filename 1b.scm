
					; Peano Arithmetic Sum
(define (peano-sum x y)
  (define (dec x) (- x 1))
  (define (inc x) (+ x 1))
  (if (= x 0)
      y
      (peano-sum (dec x) (inc y))))

(peano-sum 22 11)


