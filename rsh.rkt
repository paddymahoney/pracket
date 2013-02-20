#lang racket
(require racket/file
         "user.rkt")

(require (for-syntax syntax/parse))

(provide home-dir cd cwd pwd chdir mkdir make-dir with-cwd with-cwd* create-temp-file 
         (all-from-out "user.rkt"))

(define create-temp-file make-temporary-file)

(define (home-dir)
  (find-system-path 'home-dir))

(define cwd current-directory)
(define pwd current-directory)

(define (chdir path)
  (current-directory path))

(define cd chdir)

(define mkdir make-directory)
(define make-dir make-directory)

(define (with-cwd* path thunk)
  (parameterize ([current-directory path])
    (thunk)))

(define-syntax (with-cwd sntx)
  (syntax-parse sntx
    [(with-cwd path body ...)
     #'(with-cwd* path 
                  (lambda () body ...))]))

