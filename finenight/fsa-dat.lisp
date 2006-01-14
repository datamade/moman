(load "fsa.lisp")

(setf my-fsa (build-fsa 'a 
			'((a "b" b)
			  (a "c" c)
			  (a "d" d)
			  (a "d" d)
			  (b "c" c)
			  (b "�" c)
			  (c "d" d))
			'(d)))

(graphviz-export t 8.5 11 my-fsa)
	     