;; this is guile 3

                                        ; 1-1-2
(define pi 3.14159)
(define radius 10)

(* pi (* radius radius))
;; => 314.159

(define circumference (* 2 pi radius))

circumference
;; => 62.8318

                                        ; 1-1-4
(define (square x) (* x x))

(square (square 3))
;; => 81

(define (sum-of-squares a b)
  (+ (square a) (square b)))

(sum-of-squares 3 4)
;; => 25

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

(f 5)
;; => 136

                                        ; 1-1-5
;; Applicative Order
;; - "evaluate the arguments and then apply"

;; Normal Order
;; - "fully expand and then reduce"

                                        ; 1-1-6
(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))

(abs -1)
;; => 1
(abs 1)
;; => 1

;; *Exercise 1.2:* Translate the following expression into prefix
;; form.

;;      5 + 4 + (2 - (3 - (6 + 4/5)))
;;      -----------------------------
;;             3(6 - 2)(2 - 7)

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))
;; => -37/150


;; *Exercise 1.3:* Define a procedure that takes three numbers as
;; arguments and returns the sum of the squares of the two larger
;; numbers.

(define (f1.3 a b c)
  ;; get the two larger number out of a b c
  ;; all possibilities
  ;; a and b | b and c | a and c
  (cond ((and (> a c) (> b c)) (+ (* a a) (* b b)))
        ((and (> b a) (> c a)) (+ (* b b) (* c c)))
        (else (+ (* a a) (* c c))))
  )

(f1.3 1 2 3)
;; => 13
(f1.3 2 1 3)
;; => 13
(f1.3 2 3 1)
;; => 13


;; *Exercise 1.4:* Observe that our model of evaluation allows for
;; combinations whose operators are compound expressions.  Use this
;; observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(a-plus-abs-b 3 1)
;; => 4
(a-plus-abs-b 3 -1)
;; => 4

;; the procedure is evaluated first
;; (a-plus-abs-b 3 1)
;; ((if (> 1 0) + -) 3 1)
;; (+ 3 1)
;; 4
;; (a-plus-abs-b 3 -1)
;; ((if (> -1 0) + -) 3 -1)
;; (- 3 -1)
;; 4


;; *Exercise 1.5:* Ben Bitdiddle has invented a test to determine
;; whether the interpreter he is faced with is using
;; applicative-order evaluation or normal-order evaluation.  He
;; defines the following two procedures:

;; (define (p) (p))

;; (define (test x y)
;;   (if (= x 0)
;;       0
;;       y))

;; Normal Order will give 0
;; it will expand the predicate
;; then apply the arguments so:
;; - it will get 0 by evaluing the predicate with x and y

;; Applicative order will try to evaluate operands (arguments)
;; and thus will hang on ((p))? an infinite loop


;; P.S. mine just went infinite loop so i guess Guile is doing applicative order

                                        ; 1-1-7
;; Square Roots by Newton's Method

(define (improve guess x)
  ((λ (n1 n2) (/ (+ n1 n2) 2))
   guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(sqrt-iter 1.0 9)
;; => 3.00009155413138

;; *Example 1.6:*

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (new-sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (new-sqrt-iter (improve guess x)
                     x)))

;; Caution: do not evaluate
;; (new-sqrt-iter 1.0 9) ~ loop infinite

;; Explaination: due to the applicative order of evaluation
;; the arguments/operands are evaluated beforethe procedure,
;; but, since one of the arguments of new-if is the call to
;; the procedure new-sqrt-iter itself, it keeps evaluating the
;; new-sqrt-iter forever. NOTE: new-if a custom procedure not
;; a special-form, so it must be evaluated like a normal procedure
;; i.e., applicative order.


;; *Example 1.7:*

;; track that different in the guess and old guess

(define (good-enough2? guess last-guess)
  (< (abs (- guess last-guess)) 0.001))

(define (sqrt-iter2 guess last-guess x)
  (if (good-enough2? guess last-guess)
      guess
      (sqrt-iter2 (improve guess x) guess x)))

(sqrt-iter2 1.0 0.5 9)
;; => 3.000000001396984

(sqrt-iter 1.0 9)
;; => 3.00009155413138

;; comparing the guess delta with the same precision marker (0.001)
;; gives an order of multitudes more precise result

;; *Example 1.8:* Cube roots by Newton's method.

(define (good-enough-cbrt? guess x)
  (< (abs (- (* guess guess guess) x) ) 0.001))

(define (improve-cbrt guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (cube-iter guess x)
  (if (good-enough-cbrt? guess x)
      guess
      (cube-iter (improve-cbrt guess x) x)))


(cube-iter 1.0 27)
;; => 3.0000005410641766


                                        ; 1-1-8

;; using nested definitions "block structure"
;; to internalize auxillary procedures 
(define (sqrt-block x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (/ (+ guess (/ x guess)) 2))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))

(sqrt-block 9)
;; => 3.00009155413138
