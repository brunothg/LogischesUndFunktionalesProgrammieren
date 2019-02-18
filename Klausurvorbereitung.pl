% Übungsaufgaben aus den Kurseinheiten und den Klausurprotokollen

% member/2 - Prüfe, ob ein Element in einer Liste enthalten ist
ue_member([E|_], E).
ue_member([_|R], E) :- ue_member(R, E).

% last/2 - Prüfe, ob ein Element das letzte Element einer Liste ist
ue_last([E], E).
ue_last([_|R], E) :- ue_last(R, E).

% is_list/1 - Prüfe ob ein Element eine Liste ist
ue_is_list([]).
ue_is_list([_|R]) :- ue_is_list(R).

% reverse/2 - Invertiere eine gegebene Liste

% sortiert/1 - Prüfe, ob eine Liste sortiert ist

% append/3 - Verbinde erste beiden Listen zu dritter

% member/2 - Variation mit append/3

% last/2 - Variation mit append/3

% ith/3 - Prüft, ob das erste Argument an der Stelle von N in der Liste L steht
ue_ith(E, 1, [E|_]).
ue_ith(E, N, [_|R]) :- ue_ith(E, N1, R), N is N1 + 1.

% if-then-else mit Cut-Operator
ite(I, T, E) :- call(I), T, !, true.
ite(I, T, E) :- call(E).

% length/2 Länge einer Liste
ue_length([], 1).
ue_length([_|R], N) :- ue_length(R, N1), N is N1 + 1.

% alternative Darstellung für \+ (NOT)
not(X) :- call(X), !, fail.
not(X) :- true.