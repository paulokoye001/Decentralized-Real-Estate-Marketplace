(use-trait sip009-nft-trait 'SP2NFTSTND.token-nft.sip009-trait)

;; --------------------
;; Constants & Errors
;; --------------------
(define-constant ERR-NOT-OWNER (err u100))
(define-constant ERR-NOT-AUTHORIZED (err u101))
(define-constant ERR-NOT-AVAILABLE (err u102))
(define-constant ERR-INSUFFICIENT-FUNDS (err u103))

;; --------------------
;; Data Maps & Variables
;; --------------------
(define-map properties 
  {property-id: uint} 
  {owner: principal, price: uint, for-sale: bool, rent-price: (optional uint), escrow: (optional principal)})

(define-map fractional-ownership 
  {property-id: uint, investor: principal} 
  {shares: uint})

(define-map auctions
  {property-id: uint}
  {highest-bid: uint, highest-bidder: (optional principal), active: bool, end-block: uint})