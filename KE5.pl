:- use_module(library(clpfd)).

% 1
fib(0, 0).
fib(1, 1).
fib(N,F) :- N #> 1,
			N1 #= N-1,
			N2 #= N-2,
			fib(N1,F1),
			fib(N2,F2),
			F #= F1+F2.
