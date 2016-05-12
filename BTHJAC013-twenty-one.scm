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
;;	- there can be at most four aces in a hand, limited by the number of suits
;;	- there can be at most one ace worth eleven points, as having two aces
;;	  both worth eleven points would result in the player losing the game
;;	- the difference between the worth of a hand when an ace is worth one and 
;;	  when an ace is worth eleven is ten points
;;	- therefore initially calculate the total score when the ace is worth one
;;	  and see if by adding ten (i.e., making one of the aces worth eleven 
;;	  instead) the score is not yet greater than 21
;;	- if the result is in favour of eleven, return that result, otherwise
;;	  return the initial result

(define (best-hand hand)
   (if (<= (aces-eleven hand) 21) (aces-eleven hand) (min-val hand)))

(define (aces-eleven hand)
   (+ (min-val hand) 10))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Question 2.  "stop-at"
;; [add description and test -cases]


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

