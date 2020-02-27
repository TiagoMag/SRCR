%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pertence : [H|T] X -> {V,F}

pertence([X|T],X).
pertence([H|T],X) :- pertence(T,X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado length : [H|T] X -> {V,F}

length1([],0).
length1([H|T],X) :- length1(T,N),X is 1+N.  

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado diferentes : [H|T]  -> {V,F}


igual(X,[],0).
igual(X,[H|T],Sum) :- X == H, igual(X,T,N), Sum is N + 1.
igual(X,[H|T],Sum) :- igual(X,T,Sum),X\=H.

diferentes([],0).
diferentes([H|T],Sum) :- igual(H,[H|T],ResIg), ResIg == 1, diferentes(T,ResDif), Sum is ResDif + 1.
diferentes([H|T],Sum) :- igual(H,[H|T],ResIg), ResIg > 1 , diferentes(T,ResDif), Sum is ResDif.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apaga1 : [H|T]  -> {V,F}


apaga(X,[],[]).
apaga(X,[X|T],T).
apaga(X,[H|T],[H|Res]) :- X\= H, apaga(X,T,Res).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagaT : [H|T]  -> {V,F}


apagaT(X,[],[]).
apagaT(X,[X|T],Res) :- apagaT(X,T,Res).
apagaT(X,[H|T],[H|Res]) :- X\= H, apagaT(X,T,Res).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado adiciona : [H|T]  -> {V,F}

adiciona(X, L, L) :- pertence(L,X),!.
adiciona(X, L, [X | L]).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado concatenar : [H|T]  -> {V,F}

concat([], List, List).
concat([Head|Tail], List, [Head|Rest]) :- concat(Tail, List, Rest).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado inverte : [H|T]  -> {V,F}

inverte([],[]) .  
inverte([X],[X]) . 
inverte([H|T],L) :- inverte(T,Res),concat(Res,[H],L) .    

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sublista : [H|T]  -> {V,F}     
             

sublista([],_).
sublista([H|T],[H|Xs]) :- sublista(T,Xs).
sublista([H|T],[H2|Xs]) :- sublista([H|T],Xs).
