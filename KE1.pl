% 3.1
is_list([]).
is_list([_|T]) :- is_list(T).

% 3.2
ue_member(Element, [Element|_]).
ue_member(Element, [H|R]) :- ue_member(Element, R).

% 3.3
% \+(T) :- call(T), !, fail.
% \+(_).

connect([], L2, L2).
connect([L1H|L1T], L2, [L1H|E]) :- connect(L1T, L2, E).

flatten([], []).
flatten([InHead|InTail], [InHead|Out]) :- flatten(InTail, Out), \+(is_list(InHead)).
flatten([InHead|InTail], Out) :- flatten(InHead, OutHead), flatten(InTail, OutTail), connect(OutHead, OutTail, Out).

% 3.4
ue_length([], 0).
ue_length([H|T], [Out]) :- ue_length(T, Out).

% 4
reverse_deep(List, Result) :- reverse_deep(List, [], Result).
reverse_deep([], Acc, Acc).
reverse_deep([LH|LT], Acc, Result) :- reverse_deep(LT, [LH|Acc], Result), \+(is_list(LH)).
reverse_deep([LH|LT], Acc, Result) :- reverse_deep(LH, [], ResultHead), reverse_deep(LT, [ResultHead|Acc], Result).

% 5
as_find_key([S,D], S, D).
as_find([LH|LT], S, D) :- as_find_key(LH, S, D).
as_find([LH|LT], S, D) :- as_find(LT, S, D).