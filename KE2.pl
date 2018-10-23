%1
insertsort([], []).
insertsort([Head|Tail], Result) :- insertsort(Tail, PartialResult), einfuegens(Head, PartialResult, Result).

einfuegens(Element, [], [Element]).
einfuegens(Element, [HeadP|TailP], [Element, HeadP|TailP]) :- Element =< HeadP.
einfuegens(Element, [HeadP|TailP], [HeadP|TailR]) :- Element > HeadP, einfuegens(Element, TailP, TailR).

%2.1
repeat.
repeat :- repeat.

connect([], L2, L2).
connect([L1H|L1T], L2, [L1H|E]) :- connect(L1T, L2, E).

as_find_key([Key, Value], Key, Value).

list_as_find(AList, Key, Result) :- list_as_find(AList, Key, [], Result), !.
list_as_find([], _, Acc, Acc).
list_as_find([Head|Tail], Key, Acc, Result) :- as_find_key(Head, Key, FValue), connect(Acc, [FValue], Acc_FValue), list_as_find(Tail, Key, Acc_FValue, Result).
list_as_find([Head|Tail], Key, Acc, Result) :- list_as_find(Tail, Key, Acc, Result).

as_search(Liste) :- repeat, read(Key), as_search(Liste, Key), Key=genug, !.
as_search(Liste, Key) :- Key=genug.
as_search(Liste, Key) :- list_as_find(Liste, Key, Result), write(Result), nl.


%2.2
% Meine erste Lösung hat bei der gegebenen Anfrage nicht terminiert (Das fehlende "!" im Prädikat as_search/1).
% Die Begründung hierfür ist, dass ein "genug." zwar rein logisch das Programm beenden müsste, aber ein angehängtes fail dazu führt, das nicht aus der Schleife gesprungen wird, sondern ein erneuter repeat ausgeführt wird.
% Damit nach einem "genug." das Programm as_search zuverlässig beendet wird, egal, was danach folgt, muss das repeat mit dem "!" unterbrochen werden.
% Nur auf diese Weise kann ein wohl definiertes Ende erreicht werden.


%3 - Variante ein - Kann überprüfen, läuft aber in eine Schleife beim Backtracking
%ue_length([], 0).
%ue_length([H|T], [Out]) :- ue_length(T, Out).

%ue_member(Element, [Element|_]).
%ue_member(Element, [H|R]) :- ue_member(Element, R).

%list_contains_only([], [_]).
%list_contains_only([], [_|_]).
%list_contains_only([Head|Tail], Values) :- list_contains_only(Tail, Values), ue_member(Head, Values).

%list_no_double_entries([]).
%list_no_double_entries([Head|Tail]) :- list_no_double_entries(Tail), \+ue_member(Head, Tail).

%gen_perm(Permutation) :- ue_length(Permutation, [[[[[[[[[[0]]]]]]]]]]), gen_perm_vals(Permutation).
%gen_perm_vals(Permutation) :- list_contains_only(Permutation, [0,1,2,3,4,5,6,7,8,9]), list_no_double_entries(Permutation).

%3 - Variante 2
% Entferne Element aus Liste
takeout(Element, [Element|Tail], Tail).  
takeout(Element, [Head|TailV], [Head|TailR]) :- takeout(Element, TailV, TailR).

% Berechne Permutation mit gegebener Symbolliste
perm([HeadV|TailV], Permutation) :- perm(TailV, Partial), takeout(HeadV, Permutation, Partial).  
perm([],[]).

% Permutation für Aufgabenbezogene Symbole
gen_perm(Permutation) :- perm([0,1,2,3,4,5,6,7,8,9], Permutation).