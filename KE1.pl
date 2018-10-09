% 3.1
is_list([]).
is_list([_|T]) :- is_list(T).

% 3.2
ue_member(Element, [Element|_]).
ue_member(Element, [H|R]) :- ue_member(Element, R).

% 3.3
flatten([], []).

% 3.4
ue_length([], 0).
ue_length([H|T], [Out]) :- ue_length(T, Out).

% 4


% 5