
;; Piano Arithmetic Sum
(define (dec x)
  (- x 1))

(define (inc x)
  (+ x 1))

(define (piano-sum x y)
  (if (= x 0)
      y
      (piano-sum (dec x) (inc y))))

(piano-sum 22 11)


