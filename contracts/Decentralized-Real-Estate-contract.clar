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

  (define-data-var dao-governance-address principal 'SPDAO-GOVERNANCE)

;; --------------------
;; NFT Property Minting
;; --------------------
(define-public (mint-property (property-id uint) (price uint))
  (begin
    (asserts! (is-eq tx-sender (contract-owner)) ERR-NOT-AUTHORIZED)
    (map-set properties {property-id: property-id} {owner: tx-sender, price: price, for-sale: true, rent-price: none, escrow: none})
    (ok property-id)))

;; --------------------
;; Buying Property via Escrow
;; --------------------
(define-public (buy-property (property-id uint) (buyer principal) (offer uint))
  (let ((property (unwrap! (map-get? properties {property-id: property-id}) ERR-NOT-AVAILABLE)))
    (asserts! (is-eq (get for-sale property) true) ERR-NOT-AVAILABLE)
    (asserts! (>= offer (get price property)) ERR-INSUFFICIENT-FUNDS)
    (map-set properties {property-id: property-id} (merge property {escrow: (some buyer)}))
    (ok true)))

(define-public (finalize-purchase (property-id uint))
  (let ((property (unwrap! (map-get? properties {property-id: property-id}) ERR-NOT-AVAILABLE)))
    (asserts! (is-some (get escrow property)) ERR-NOT-AUTHORIZED)
    (map-set properties {property-id: property-id} (merge property {owner: (unwrap! (get escrow property) ERR-NOT-AUTHORIZED), escrow: none, for-sale: false}))
    (ok true)))
;; --------------------
;; Fractional Ownership
;; --------------------
(define-public (buy-shares (property-id uint) (investor principal) (amount uint))
  (begin
    (asserts! (> amount u0) ERR-INSUFFICIENT-FUNDS)
    (map-set fractional-ownership {property-id: property-id, investor: investor} {shares: amount})
    (ok amount)))

;; --------------------
;; Renting System
;; --------------------
(define-public (set-rent (property-id uint) (rent-price uint))
  (let ((property (unwrap! (map-get? properties {property-id: property-id}) ERR-NOT-AVAILABLE)))
    (asserts! (is-eq tx-sender (get owner property)) ERR-NOT-OWNER)
    (map-set properties {property-id: property-id} (merge property {rent-price: (some rent-price)}))
    (ok rent-price)))

(define-public (pay-rent (property-id uint))
  (let ((property (unwrap! (map-get? properties {property-id: property-id}) ERR-NOT-AVAILABLE)))
    (asserts! (is-some (get rent-price property)) ERR-NOT-AVAILABLE)
    (ok "Rent paid successfully")))