(define-module surl.cli
  (export runner)
  (use gauche.parseopt)
  (use util.match)
  (use file.util)
  (use surl.core)
  )
(select-module surl.cli)

(define runner
  (lambda (args)
    (cond
      ((string-is-url? (cadr args))
       (if (< 2 (length args))
       (surl (cdr args))
       (print (surl (cdr args))))
       ))
    ))
