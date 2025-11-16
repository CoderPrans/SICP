
                                        ;1-2-1
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(factorial 6)
;; => 720


;;           (factorial 6)        ------------------------.
;;           (* 6 (factorial 5))                          |
;;           (* 6 (* 5 (factorial 4)))                    |
;;           (* 6 (* 5 (* 4 (factorial 3))))              |
;;           (* 6 (* 5 (* 4 (* 3 (factorial 2)))))        |
;;           (* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))  |
;;           (* 6 (* 5 (* 4 (* 3 (* 2 1)))))              |
;;           (* 6 (* 5 (* 4 (* 3 2))))                    |
;;           (* 6 (* 5 (* 4 6)))                          |
;;           (* 6 (* 5 24))                               |
;;           (* 6 120)                                    |
;;           720          <-------------------------------'


(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
		 (+ 1 counter)
		 max-count)))

(define (factorial2 n)
  (fact-iter 1 1 n))


(factorial2 6)
;; => 720


;;           (factorial 6)   -----.
;;           (fact-iter   1 1 6)  |
;;           (fact-iter   1 2 6)  |
;;           (fact-iter   2 3 6)  |
;;           (fact-iter   6 4 6)  |
;;           (fact-iter  24 5 6)  |
;;           (fact-iter 120 6 6)  |
;;           (fact-iter 720 7 6)  V
;;           720

