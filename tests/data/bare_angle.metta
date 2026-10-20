; Leading bare-angle symbols: previously the lexer silently dropped bare
; < and > characters via the flex default rule (echo to stdout + discard).
(--> A B)
(<-> A B)
(x > y)
(Similarity "text --> more" A)
(: A (-> B C))
