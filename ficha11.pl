%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacão em logica 
% Resolução de problemas de pesquisa Não Informada (Ficha 11)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%---------------------------------  dados do problema ---------

% estado inicial
inicial(jarros(0, 0)).

% estados finais
final(jarros(4, _)).
final(jarros(_, 4)).

% transições possíveis transicao: Ei x Op x Ef

transicao(jarros(V1, V2), encher(1), jarros(8, V2)):- V1 < 8.
transicao(jarros(V1, V2), encher(2), jarros(V1, 5)):- V2 < 5.

transicao(jarros(V1, V2), encher(1, 2), jarros(NV1, NV2)):- 
	V1 > 0,
	NV1 is max(V1 - 5 + V2, 0), 
	NV1 < V1, 
	NV2 is V2 + V1 - NV1.
transicao(jarros(V1, V2), encher(2, 1), jarros(NV1, NV2)):- 
	V2 > 0,
	NV2 is max(V2 - 8 + V1, 0), 
	NV2 < V2, 
	NV1 is V1 + V2 - NV2.

transicao(jarros(V1, V2), vazio(1), jarros(0, V2)):- V1 > 0.
transicao(jarros(V1, V2), vazio(2), jarros(V1, 0)):- V2 > 0.

%---------------------------------  d) ---------
resolvedf(Solucao):-
	inicial(InicialEstado),
	resolvedf(InicialEstado, [InicialEstado], Solucao).

resolvedf(Estado, _, []):-
	final(Estado),!.

resolvedf(Estado, Historico, [Move |Solucao]):-
	transicao(Estado, Move, Estado1),
	nao(membro(Estado1, Historico)),
	resolvedf(Estado1, [Estado1|Historico], Solucao).	

%--------------------------------- Comparar d) e e) ---------


todos(L):-findall((S,C), (resolvedf(S), length(S,C)), L).

melhor(S, Custo):- findall((S,C), (resolvedf(S), length(S,C)), L), minimo(L,(S,Custo)).

escrever([]).
escrever([(X,Y)|L]):- write(X), write(' - '), write(Y), nl, escrever(L).

minimo([(P,X)],(P,X)).
minimo([(Px,X)|L],(Py,Y)):- minimo(L,(Py,Y)), X>Y. 
minimo([(Px,X)|L],(Px,X)):- minimo(L,(Py,Y)), X=<Y. 

minimo1([X],X).
minimo1([X|L], Y):- minimo1(L,Y), X>Y. 
minimo1([X|L], X):- minimo1(L,Y), X=<Y. 


%---------------------------------  e) ---------

resolvebf(Solucao):-
	inicial(InicialEstado),
	resolvebf([(InicialEstado, [])|Xs]-Xs, [], Solucao).

resolvebf([(Estado, Vs)|_]-_, _, Rs):-
	final(Estado),!, inverso(Vs, Rs).

resolvebf([(Estado, _)|Xs]-Ys, Historico, Solucao):-
	membro(Estado, Historico),!,
	resolvebf(Xs-Ys, Historico, Solucao).

resolvebf([(Estado, Vs)|Xs]-Ys, Historico, Solucao):-
	setof((Move, Estado1), transicao(Estado, Move, Estado1), Ls),
	atualizar(Ls, Vs, [Estado|Historico], Ys-Zs),
	resolvebf(Xs-Zs, [Estado|Historico], Solucao).


atualizar([], _, _, X-X).
atualizar([(_, Estado)|Ls], Vs, Historico, Xs-Ys):-
	membro(Estado, Historico),!,
	atualizar(Ls, Vs, Historico, Xs-Ys).

atualizar([(Move, Estado)|Ls], Vs, Historico, [(Estado, [Move|Vs])|Xs]-Ys):-
	atualizar(Ls, Vs, Historico, Xs-Ys).



%---------------------------------  predicados auxiliares ---------


membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).

membros([], _).
membros([X|Xs], Members):-
	membro(X, Members),
	membros(Xs, Members).


inverso(Xs, Ys):-
	inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).	

escrever([]).
escrever([X|L]):- write(X), nl, escrever(L). 

