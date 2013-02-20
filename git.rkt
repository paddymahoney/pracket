#lang racket
(require "rsh.rkt")
(require "racket-ext.rkt")

(provide master clone fetch merge push remote remote-add branch checkout init add commit pull)

(define master "master")

(define (remote)
  (system "git remote -v"))

(define (remote-add name url (list? #f))
  (system (string-append "git remote add " name " " name url)))

(define (clone repo)
  (system (string-append "git clone " repo)))

(define (fetch repository)
  (system (str "git fetch " repository)))

(define (merge head)
  (system (str "git merge " head)))

(define (push destination)
  (system (str "git push " destination)))

(define branch
  (case-lambda
    [() (system "git branch")]
    [(name) (system (str "git branch name"))]))

(define checkout
  (case-lambda 
    [() (system "git checkout")]
    [(branch-name) (system (str "git checkout " branch-name))]))

(define (add)
  (system (str "git add .")))

(define (init)
  (system (str "git init")))

(define (commit message)
  (system (str "git commit -m \"" message "\"")))
         
(define (pull repository)
  (system (str "git pull " repository)))






