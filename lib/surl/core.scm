(define-module surl.core
  (export 
    surl
    string-is-url?)  
  (use gauche.net)
  (use rfc.uri)
  (use rfc.http)
  (use srfi-11)
  )
(select-module surl.core)

(define (string-is-url? str)
  (or ( #/^https?:\/\// str)
    ( #/^http:\/\// str)))

(define (surl args)
  (let ((file (if (< 1 (length args)) (cadr args) #f))
        (uri  (car args)))
      (let-values (((scheme user-info hostname port-number path query fragment)
                    (uri-parse uri)))
        ;; returns html body
        (cond
          (file (call-with-output-file
                      file
                      (lambda (in)
                        (http-get hostname (or  path "/")
                                  :sink in
                                  :flusher (lambda _ #t)))))
          (else
            (values-ref (http-get hostname (or  path "/"))
              2))))) )
