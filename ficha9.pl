%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
% Representacao de conhecimento imperfeito

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais



%--------------------------------- - - - - - - - - - -  -  nao
nao(Q) :- Q,!,fail.
nao(Q).

%--------------------------------- - - - - - - - - - -  -  solver
solver(Q,verdadeiro) :- Q.
solver(Q,falso) :- -Q.
solver(Q,desconhecido) :- nao(Q),nao(-Q).

%--------------------------------- - - - - - - - - - -  -  soluções
solucoes( X,Y,Z ) :- findall( X,Y,Z ).

%--------------------------------- - - - - - - - - - -  -  comprimento
comprimento( S,N ) :- length( S,N ).


g(grafo([a,b,c,d,e,f,g],[aresta(a,b),aresta(c,d),aresta(c,f),aresta(d,f),aresta(f,g)])).

adjacente(X,Y,grafo(_,ES)) :- member(aresta(X,Y),ES).

adjacente(X,Y,grafo(_,ES)) :- member(aresta(Y,X),ES).



nao( Questao ) :-
    Questao, !, fail.
nao( _ ).


caminho(Grafo,X,Y,P):-
    caminhoAux(Grafo,X,[Y],P).

caminhoAux(_,X,[X|T],[X|T]).
caminhoAux(G,X,[Y|T],P) :-
    adjacente(Prox_nodo,Y,G), nao(member(Prox_nodo,[Y|T])), caminhoAux(G,X,[Prox_nodo,Y|T],P).


ciclo(G,X,P) :- adjacente(Prox_nodo,X,G), caminho(G,Prox_nodo,X,NP),length(P1,L)>2,append([X],NP,P).

aresta(huelva, sevilla, a49, 94).



ciclo(G,A,P) :- 
    adjacente(Nodo_final,A,G), %encontrar um nodo que ligue a A 
     caminho(G,A,Nodo_final,Ciclo_incompleto), % verificar se existe e guardar o caminho de A ao nodo que existe antes dele em P1
     length(Ciclo_incompleto,S1), %verificar o tamanho desse caminho
     S1 > 2, % Se o tamanho do caminho for 2 não serve porque na verdade é logo o A que está ligado ao nodo anterior
     append(Ciclo_incompleto,[A],P). % termina o ciclo 



append( [], X, X).                               
append( [X | Y], Z, [X | W]) :- append( Y, Z, W).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}
%                            Resposta = { verdadeiro,falso,desconhecido }

demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).


getDistanciaAndEstrada(X,Y,D,E,grafo(_,ES)) :- member(aresta(X,Y,E,D), ES).
getDistanciaAndEstrada(X,Y,D,E,grafo(_,ES)) :- member(aresta(Y,X,E,D), ES).

caminho(G,X,Y,P,KM,EST) :- caminhoA(G,X,[Y],P,KM,EST).

caminhoA(G,X,[X|T],[X|T],0,[]).

caminhoA(G,X,[Y|T],P,DIST,ListaEstradas) :- getDistanciaAndEstrada(Prox_nodo,Y,DISTANCIA,RUA,G), nao(member(Prox_nodo,[Y|T])), caminhoA(G,X,[Prox_nodo,Y|T],P,KM, ESTRADAS), append(ESTRADAS,[RUA], ListaEstradas), DIST is KM + DISTANCIA.



caminhoAuxb(_,X,[X|T],P,0,[]).
caminhoAuxb(G,X,[Y|T],P,K1,[E|ES]) :-
             ajacente(Prox_nodo,Y,Ki,E,G,nao(member(Prox_nodo,[Y|T])),caminhoAuxb(G,X,[Prox_nodo,Y|T],P,K,ES),K1 is K+Ki.