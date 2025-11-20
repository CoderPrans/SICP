
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


;; *Example 1.10:*

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))


(A 1 10)
;; => 1024

;; (A (- 1 1) (A 1 (- 10 1)))
;; (A 0 (A (- 1 1) (A 1 (- 9 1))))
;; (A 0 (A 0 (A (- 1 1) (A 1 (- 8 1)))))
;; (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 7 1))))))
;; (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 6 1)))))))
;; (A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 5 1))))))))
;; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 4 1)))))))))
;; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 3 1))))))))))
;; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 2 1)))))))))))
;; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
;; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
;; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
;; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
;; (A 0 (A 0 (A 0 (A 0 (A 0 32)))))
;; (A 0 (A 0 (A 0 (A 0 64))))
;; (A 0 (A 0 (A 0 128)))
;; (A 0 (A 0 256))
;; (A 0 512)
;; 1024

(expt 2 10)
;; => 1024
;; (A 1 10) => 2^10

(define (f n) (A 0 n))

(f 4)
;; => 8
;; (A 0 4)
;; (* 2 4)
;; 8
;; (f n) => (* 2 n) => 2n

(define (g n) (A 1 n))

(g 4)
;; => 16
;; (A 1 4)
;; (A (- 1 1) (A 1 (- 4 1)))
;; (A 0 (A (- 1 1) (A 1 (- 3 1))))
;; (A 0 (A 0 (A (- 1 1) (A 1 (- 2 1)))))
;; (A 0 (A 0 (A 0 2))))
;; (A 0 (A 0 4))
;; (A 0 8)
;; 16
;; (g n) => (expt 2 n) => 2^n

(define (h n) (A 2 n))

(h 3)
;; => 16
;; (A 2 3)
;; (A (- 2 1) (A 2 (- 3 1)))
;; (A 1 (A (- 2 1) (A 2 (- 2 1))))
;; (A 1 (A 1 2))
;; (A 1 4)
;; 16

(h 4)
;; => 65536
;; (A 2 4)
;; (A 1 (A 2 3))
;; (A 1 (A 1 (A 2 2)))
;; (A 1 (A 1 (A 1 (A 2 1))))
;; (A 1 (A 1 (A 1 2)))
;; (A 1 (A 1 4))
;; (A 1 16)

;; (A 1 (A 1 (A 1 2)))
;; (expt 2 (expt 2 (expt 2 2)))
;; => 65536

;; 2^2^2^2...(n-1 times)


