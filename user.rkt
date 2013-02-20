#lang racket

(provide (struct-out user) get-users uid->user name->user)
(provide user-id->user user-name->user)

(define passwd-file "/etc/passwd")

(define (get-users)
  (for/list ([passwd-line (in-lines (open-input-file passwd-file))])
    (define user-info-list (string-split passwd-line ":"))
    (match user-info-list
      [(list name _ uid gid description home-dir shell) (user name (string->number uid) (string->number gid) description (build-path home-dir) (build-path shell))])))

(struct user
  (name uid gid description home-dir shell) #:transparent)

(define (uid->user uid)
  (define user-list (get-users))
  (for/first ([user (in-list user-list)] 
              #:when (= uid (user-uid user)))
    user))
(define user-id->user uid->user)

(define (name->user name)
  (define user-list (get-users))
  (for/first ([user (in-list user-list)] 
              #:when (equal? name (user-name user)))
    user))

(define user-name->user name->user)
