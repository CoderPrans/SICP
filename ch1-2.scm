
                                        ;1-2-1
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(factorial 6)
;; => 720

;;           "linear recursive process"
;;           characterized by a chain of deferred operations

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

;;           "linear iterative process"


;;           (factorial 6)   -----.
;;           (fact-iter   1 1 6)  |
;;           (fact-iter   1 2 6)  |
;;           (fact-iter   2 3 6)  |
;;           (fact-iter   6 4 6)  |
;;           (fact-iter  24 5 6)  |
;;           (fact-iter 120 6 6)  |
;;           (fact-iter 720 7 6)  V
;;           720

;; *Example 1.9:*

(define (sum-a a b)
  (if (= a 0)
      b
      (1+ (sum-a (1- a) b))))


(sum-a 2 4)
;; => 6

(define (sum-b a b)
  (if (= a 0)
      b
      (sum-b (1- a) (1+ b))))

(sum-b 2 4)
;; => 6

;; sum-a

;; (1+ (sum-a (1- 2) 4)
;; (1+ (1+ (sum-a (1- 1) 4)))
;; (1+ (1+ 4))
;; (1+ 5)
;; 6

;; sum-b

;; (sum-b (1- 2) (1+ 4))
;; (sum-b (1- 1) (1+ 5))
;; (sum-b 0 6)
;; 6

;; 6

;; Hence upon observation,
;; sum-a is recursive processs
;; sum-b is iterative process
