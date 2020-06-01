%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Pesquisa Não Informada e Informada (Ficha 12 - Multi Estados)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

move(s, a, 2).
move(a, b, 2).
move(b, c, 2).
move(c, d, 3).
move(d, t, 3).
move(s, e, 2).
move(e, f, 5).
move(f, g, 2).
move(g, t, 2).


estima(a, 5).
estima(b, 4).
estima(c, 4).
estima(d, 3).
estima(e, 7).
estima(f, 4).
estima(g, 2).
estima(s, 10).
estima(t, 0).



goal(t).

%---------------------------------pesquisa em profundidade primeiro 



resolve_pp(Nodo, [Nodo|Caminho]) :-
	profundidadeprimeiro(Nodo, Caminho).

profundidadeprimeiro(Nodo, []) :-
	goal(Nodo).

profundidadeprimeiro(Nodo, [ProxNodo|Caminho]) :-
	adjacente(Nodo, ProxNodo),
        profundidadeprimeiro(ProxNodo, Caminho).

adjacente(Nodo, ProxNodo) :- 
	move(Nodo, ProxNodo, _).

%---------------------------------pesquisa em profundidade primeiro Multi_Estados

resolve_pp_h(Origem, Destino, Caminho) :-



             profundidade(Origem, Destino, [Origem], Caminho).

profundidade(Destino, Destino,H, D):- inverso(H,D).

profundidade(Origem, Destino, His, C):-
            adjacente_h(Origem, Prox),
            \+ member(Prox, His),
            profundidade(Prox, Destino,[Prox|His], C).

adjacente_h(Nodo, ProxNodo) :- 
	move(Nodo, ProxNodo, _).
adjacente_h(Nodo, ProxNodo) :- 
	move(ProxNodo,Nodo, _).

%---------------------------------pesquisa em profundidade primeiro com custo

resolve_pp_c(Nodo, [Nodo|Caminho], C) :-
	profundidadeprimeiro(Nodo, Caminho, C).

profundidadeprimeiro(Nodo, [], 0) :-
	goal(Nodo).

profundidadeprimeiro(Nodo, [ProxNodo|Caminho], C) :-
	adjacente(Nodo, ProxNodo, C1),
	profundidadeprimeiro(ProxNodo, Caminho, C2), C is C1 + C2.	

adjacente(Nodo, ProxNodo, C) :- 
	move(Nodo, ProxNodo, C).

melhor(Nodo, S, Custo) :- findall((SS, CC), resolve_pp_c(Nodo, SS, CC), L), minimo(L, (S, Custo)).

minimo([(P,X)],(P,X)).
minimo([(Px,X)|L],(Py,Y)):- minimo(L,(Py,Y)), X>Y. 
minimo([(Px,X)|L],(Px,X)):- minimo(L,(Py,Y)), X=<Y.


%---------------------------------pesquisa a estrela 

resolve_aestrela(Nodo, Caminho/Custo) :-
	estima(Nodo, Estima),
	aestrela([[Nodo]/0/Estima], InvCaminho/Custo/_),
	inverso(InvCaminho, Caminho).

aestrela(Caminhos, Caminho) :-
	obtem_melhor(Caminhos, Caminho),
	Caminho = [Nodo|_]/_/_,goal(Nodo).

aestrela(Caminhos, SolucaoCaminho) :-
	obtem_melhor(Caminhos, MelhorCaminho),
	seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
	expande_aestrela(MelhorCaminho, ExpCaminhos),
	append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
        aestrela(NovoCaminhos, SolucaoCaminho).		


obtem_melhor([Caminho], Caminho) :- !.

obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2, !,
	obtem_melhor([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho). 
	
obtem_melhor([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor(Caminhos, MelhorCaminho).

expande_aestrela(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacente(Caminho,NovoCaminho), ExpCaminhos).

adjacente([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est) :-
	move(Nodo, ProxNodo, PassoCusto),\+ member(ProxNodo, Caminho),
	NovoCusto is Custo + PassoCusto,
	estima(ProxNodo, Est).




%---------------------------------predicados auxiliares

inverso(Xs, Ys):-
	inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
	inverso(Xs, [X|Ys], Zs).

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).	

escrever([]).
escrever([X|L]):- write(X), nl, escrever(L).
