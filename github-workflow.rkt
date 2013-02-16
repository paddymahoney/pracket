#lang racket
(require "racket-ext.rkt")
(require "rsh.rkt")
(require (prefix-in git: "git.rkt"))

(define workspace "workspace")
(define workspace-path (build-path (home-dir) workspace))

(define racket "racket")
(define racket-path (build-path workspace-path racket))

(define origin "git@github.com:paddymahoney/racket.git")
(define upstream "git@github.com:plt/racket.git")
(define username "paddymahoney")
(define work-branch "eopl-to-racket")

(define (make-workspace-directory)
  (with-cwd (home-dir)
            (make-directory workspace-path)))

(define (make-racket-github-project name github-url)
  (with-cwd workspace-path
            (mkdir name)
            (with-cwd name
                      (git:remote-add "origin" github-url)
                      (git:init)
                      (git:add))))
                     
(define (remote-add-upstream)
  (git:remote-add "upstream" upstream))

#;(define (start-over) 
  (with-cwd (home-dir)
            (make-dir workspace)
            (with-cwd workspace
                      (git:clone origin)
                      (with-cwd repository
                                (remote-add-upstream)
                                (update-dev-repository)))))

(define (update-racket)
  (with-cwd racket-path
            (fetch-upstream)
            (merge-upstream-master)
            (push-to-origin)))

(define (merge-upstream-master)
  (git:merge "upstream/master"))

(define (fetch-upstream) 
  (git:fetch upstream))

(define (push-to-origin)
  (git:push origin))

(define (make-branch)
  (with-cwd racket-path
            (git:branch work-branch)))

(define (checkout-branch)
  (with-cwd racket-path
            (git:checkout work-branch)))