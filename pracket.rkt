#lang racket
(require "rsh.rkt")
(require (prefix-in git: "git.rkt"))

(define workspace "workspace")
(define workspace-path (build-path (home-dir) workspace))

(define pracket "pracket")
(define pracket-path (build-path workspace-path pracket))
(define origin "git@github.com:paddymahoney/pracket.git")

(define (remote-add-origin-pracket)
  (with-cwd pracket-path
            (git:remote-add "origin" origin)))

(define (update-pracket)
  (with-cwd pracket-path
            (git:add)
            (git:push origin)))



