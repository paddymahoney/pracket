#lang racket
(require "racket-ext.rkt")
(require "rsh.rkt")
(require (prefix-in git: "git.rkt"))


(define workspace "workspace")
(define workspace-path (build-path (home-dir) workspace))

(define pracket "pracket")
(define pracket-path (build-path workspace-path pracket))

(define repository "racket")

(define origin "git@github.com:paddymahoney/racket.git")
(define upstream "git@github.com:plt/racket.git")
(define username "paddymahoney")
(define work-branch "eopl-to-racket")

(define hub-pracket "git@github.com:paddymahoney/pracket.git")

(define repository-path (build-path workspace-path repository))

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
                     
(define (remote-add-origin-pracket)
  (with-cwd pracket-path
            (git:remote-add "origin" hub-pracket)))

(define (remote-add-upstream)
  (git:remote-add "upstream" upstream))

(define (start-over) 
  (with-cwd (home-dir)
            (make-dir workspace)
            (with-cwd workspace
                      (git:clone origin)
                      (with-cwd repository
                                (remote-add-upstream)
                                (update-dev-repository)))))

(define (update-dev-repository)
  (with-cwd repository-path
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
  (with-cwd repository-path
            (git:branch work-branch)))

(define (checkout-branch)
  (with-cwd repository-path
            (git:checkout work-branch)))