
;; Heron's square root algorithm
(define (root x)
  (define square (lambda (x) (* x x)))
  (define avg (lambda (x y) (/ (+ x y) 2)))
  (define good? (lambda (g) (< (abs (- (square g) x)) 0.001)))
  (define improv (lambda (g) (avg g (/ x g))))
  (define try (lambda (g) (if (good? g) g (try (improv g)))))
  (try 1))

(root 2)
(exact->inexact (root 2))
