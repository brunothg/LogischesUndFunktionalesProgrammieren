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


% 2
biersekt(Loesung) :- 
	% Shortcut
	Loesung = [B,I,E,R,S,K,T,A,U,F]

	% Domain
	,domain(Loesung, 0, 9)

	% Bedingungen
	,biersekt_constrains(Loesung)	
	
	% Werte generieren
	, biersekt_labeling(Loesung).
	
biersekt_labeling([]).
biersekt_labeling([Head|Tail]) :-
	indomain(Head)
	, biersekt_labeling(Tail).
	
biersekt_constrains([B,I,E,R,S,K,T,A,U,F]) :-
	
	% Unterschiedliche Ziffern
	  B#\=I, B#\=E, B#\=R, B#\=S, B#\=K, B#\=T, B#\=A, B#\=U, B#\=F
	, I#\=E, I#\=R, I#\=S, I#\=K, I#\=T, I#\=A, I#\=U, I#\=F
	, E#\=R, E#\=S, E#\=K, E#\=T, E#\=A, E#\=U, E#\=F
	, R#\=S, R#\=K, R#\=T, R#\=A, R#\=U, R#\=F
	, S#\=K, S#\=T, S#\=A, S#\=U, S#\=F
	, K#\=T, K#\=A, K#\=U, K#\=F
	, T#\=A, T#\=U, T#\=F
	, A#\=U, A#\=F
	, U#\=F

	% Fuehrende Nullen ausschließen
	,B#>=1, S#>=1, T#>=1 ,K#>=1, E#>=1
	
	% Rechnung
	, (R + 10*E + 100*I + 1000*B) * (T + 10*K + 100*E + 1000*S) #= R + 10*E + 100*F + 1000*U + 10000*E + 100000*A + 1000000*S
	
	% Zwischenergebnisse
	, (R + 10*E + 100*I + 1000*B) * T #= (R + 10*K + 100*I + 1000*T)
	, (R + 10*E + 100*I + 1000*B) * K #= (R + 10*K + 100*B + 1000*K)
	, (R + 10*E + 100*I + 1000*B) * E #= (I + 10*R + 100*I + 1000*E)
	, (R + 10*E + 100*I + 1000*B) * S #= (I + 10*R + 100*B + 1000*S)
	
	% Summierte Zwischenergebnisse mit Uebertraegen Ue_i
	, Ue1 #= (K + R) / 10, E #= (K + R) mod 10
	, Ue2 #= (I + K + I + Ue1) / 10, F #= (I + K + I + Ue1) mod 10
	, Ue3 #= (T + B + R + I + Ue2) / 10, U #= (T + B + R + I + Ue2) mod 10
	, Ue4 #= (K + I + R + Ue3) / 10, E #= (K + I + R + Ue3) mod 10
	, Ue5 #= (E + B + Ue4) / 10, A #= (E + B + Ue4) mod 10
	, S + Ue5 #= S.