;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;      CS 3 Scheme programming assignment               ;;;;
;;;;                 April 2016                            ;;;;
;;;;      Jacques Botha's solutions BTHJAC013              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  
;; This depends on "cs3-black-jack.scm"
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  Your code goes here                                    ;;;;
;;;;  Submit a file of code of everything you created below  ;;;;
;;;;  please do not submit the predefined code              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Question 1.  Code for "best-hand"
;; Check if current hand has the nearest value to 21 as possible, if it has an Ace in it hand, see if 
;; bieng a one or eleven produces a more desireable result.
;; Determine whether the hand thus far should consider its aces as ones or elevens
;; Test-cases: 
;;	- input: '((7 s) (A d) (3 h)) output: 21
;;	- input: '((7 s) (A d) (3 h) (5 s)) output: 16
;;	- input: '((3 c) (A d) (3 h) (A s)) output: 19
;;	- input: '((A c) (A d) (A h) (A s)) output: 14
;;
;; Algorithm:
;;	- Max 4 Aces in  hand. (ie one per suit)
;;	- Max one Ace = 11, as 2xAce==2x11=22 > 21. Meaning the player will lose.
;;	- Worth diff between base ace and 11 ace is 10.
;;	- Do base calculation with base Ace, add 10 afterwards to see if it wont be > 21.
;;	- If it's not >21 set Ace as 11.

(define (best-hand hand)
   (if (<= (aces-eleven hand) 21) (aces-eleven hand) (min-val hand)))

(define (aces-eleven hand)
   (+ (min-val hand) 10))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Question 2.  "stop-at"
;; Stops the specified hand count
;; Test-cases:
;;	- 
;; Algorithm:
;;	- get given a traget 'trgt'
;;	- take a card if the current hand value is below trgt
(define (stop-at trgt)
   (lambda (trgt)
	(lambda (customer-hand-so-far dealer-up-card)
		(< (best-hand customer-hand-so-far) trgt))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Question 3.  "repeat-game"
;; [add description and test -cases]





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Question 4.    clever
;; [add description and test -cases]




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;      Question 5.                Majority
;;;
;; [add description and test -cases]



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;        Question 6.              Get Stats
;;;
;; [add description and test -cases]



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;   Question 8.   interactive 
;; [add description and user insctructions]

; function to get the input returns #t if the user types y otherwise #f
(define (hit-me?)
  (eq? (read) 'y))

