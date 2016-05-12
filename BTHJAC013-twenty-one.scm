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
;;
;; Test-cases: 
;;	- input: '((7 s) (A d) (3 h)) output: 21
;;	- input: '((7 s) (A d) (3 h) (5 s)) output: 16
;;	- input: '((3 c) (A d) (3 h) (A s)) output: 18
;;	- input: '((A c) (A d) (A h) (A s)) output: 14
;;
;; Algorithm:
;;	- Max 4 Aces in  hand. (ie one per suit)
;;	- Max one Ace = 11, as 2xAce==2x11=22 > 21. Meaning the player will lose.
;;	- Worth diff between base ace and 11 ace is 10.
;;	- Do base calculation with base Ace, add 10 afterwards to see if it wont be > 21.
;;	- If it's not >21 set Ace as 11.

(define (best-hand hand)
	(if(ace? hand)
		(if (<= (aces-eleven hand) 21)
			(aces-eleven hand) 
			(min-val hand)
		)
		;;there is no ace
		(min-val hand)
	)
)

(define (aces-eleven hand)
   (+ (min-val hand) 10))

(define (ace? hand)
	(if (equal? (length hand) 0) ;;checks if hand is empty
		;;no ace found
		#f
		;;if there are remaining cards, continue down this rabbit hole
		(if (equal? (car(car hand)) 'A)
			;;ace found
			#t
			;;no ace found, but there are still cards left in hand (ie....might be an ace left)
			(ace? (cdr hand))
		)
	)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Question 2.  "stop-at"
;; Card is taken only if the best total thus far is less than n
;;
;; Test-cases:
;;	- Input: ((stop-at 15) '((3 d) (A s)) '(5 d))			Output: #t
;;  - False: ((stop-at 15) '((5 d) (Q s)) '(5 d))			Output: #f
;; Algorithm:
;;	- get given a traget 'trgt'
;;	- take a card if the current hand value is below trgt
(define (stop-at trgt)
	(lambda(hand dealer-up-card)
		(if (< (best-hand hand) trgt)
			#t	;;best-hand is less than trgt
			#f	;;best-hand is larger than trgt
		)
	)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Question 3.  "repeat-game"
;; Plays n games with the strategy specified and returns the number 
;; of games won minus the number of games lost (draws don’t count either way).
;;
;; Test-cases:
;;	- Input: (stop-at 15) 100
;;  - Input: stop-at-17 10
;;	- Input: stupid 100
;; Algorithm:
;;	- Given a strategy
;;	- Given a value n
;;	- starts at 0, recursively goes through till end of iterations
;;	- returns score
(define (repeat-game strategy n)
	(count-win-loss strategy n 0 0)
)

(define (count-win-loss strategy n curr-n totScore)
	(if(equal? n curr-n)	;;Draw: dont count
		totScore
		(count-win-loss strategy n (+ 1 curr-n) (+ totScore (black-jack strategy)))
	)	
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Question 4.    clever
;; Takes into account both the player’s current total and what
;; the dealer’s up card is.
;;
;; Test-cases:
;;	- Input: black-jack clever
;;	- Input: repeat-game clever 500
;; Algorithm:
;;	- If the player has 11 or less you always take a hit.
;;	- If it is 17 or higher you always stand.
;;  - If the player has 12 you stand iff the dealer’s up card is 4, 5 or 6, otherwise hit.
;;	- If the player has ≥13 and ≤16 then take a hit iff the dealer has an ace or any card of value 7 or
;;	  higher showing, otherwise stand.

(define (clever hand dealer-up-card)
	(cond ((and (<= (best-hand hand) 16) 
				(>= (best-hand (list dealer-up-card)) 7)) #t)
        ((and (<= (best-hand hand) 11) 
              (and (<=(best-hand(list dealer-up-card)) 6) 
                   (>= (best-hand (list dealer-up-card)) 2)) ) #t)
        (else #f)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;      Question 5.                Majority
;; takes three strategies as arguments and produces a strategy as a
;; result. This resulting strategy decides whether or not to “hit” by checking the three argument
;; strategies, and going with the majority. That is, the result strategy should return #t if and only if at
;; least two of the three argument strategies return #t.
;;
;; Test-cases:
;; - Input: (majority stop-at-17 (stop-at 12) clever) 1000
;; Algorithm:
;; - Split the 3 funt
;; - Have them decide on hit/not
;; - Decide on the majority

(define (majority-function strategy hand dealer-card)
  (if (strategy hand dealer-card) 1 
      0))

(define (majority strat-1 strat-2 strat-3)
     (lambda (hand dealer-card) 
     (> (+ (majority-function strat-1 hand dealer-card)
           (majority-function strat-2 hand dealer-card)
           (majority-function strat-3 hand dealer-card)) 
        1)
		)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;        Question 6.              Get Stats
;; Gathers the statistics of several repeats of the game, in a list. Every data point represents a large number of
;; repeats of the game and there will be several such data points in the output list. So get‐stats
;; takes three arguments, a strategy, a repeat‐count for each data point and a count of how
;; many data‐points there should be in the list it creates.
;; Test-cases:
;;	- Input: clever 100 3	Output: (-18 8 -19)
;; 	- Input: get-stats (stop-at 18) 1000 10		Output: (-68 -151 -94 -109 -99 -112 -140 -133 -147 -113)
;;  - Input: clever 100 10		Output: (-18 8 -19 3 12 -7 -13 -6 -8 13)
;; Algorithm:
;;	- Repeats a strat 0 -> n times
;;	- If player wins +1	score
;;	- Loss -1 to score
;;	- Tie does nothing

(define (get-stats strategy repeat-count data-points)
	(get-stats-process strategy repeat-count data-points 0 '())
)

(define (get-stats-process strategy repeat-count data-points current-data-point current-list)
	(if (equal? data-points current-data-point)
		;;finished constructing the list
		current-list
		;;continue constructing the list
		(get-stats strategy repeat-count data-points (+ current-data-point 1) (cons (repeat-game strategy repeat-count) current-list))
	)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;   Question 8.   interactive 

(define (hit hand up-card) 
  (display "Players hand: ") (display hand) 
  (newline)
  (display "Player Hand Total: ") (display (best-hand mhand))
  (newline)
  (display "Dealers hand: ") (display up-card)
  (newline)
  (display "Would you like to hit? [y][n]")
  (newline)
  (hit-me?))
  
;; function to get the input returns #t if the user types y otherwise #f
(define (hit-me?)
  (eq? (read) 'y))