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

:- op( 900,xfy,'::' ).
:- dynamic jogo/3.


%--------------------------------- - - - - - - - - - -  -  questão i
%normal
jogo(1,aa,500). 
   

%--------------------------------- - - - - - - - - - -  -  questão ii

%incerto
jogo(2,bb,xpto0123).
excecao(jogo(Jogo,Arbitro,Ajudas)) :-
    jogo(Jogo,Arbitro,xpto0123).


nuloimpreciso(xpto0123).

% iii) Indeterminado

execao(jogo(3,cc,500)).
execao(jogo(3,cc,2500)).


% iv) Indeterminado

execao(jogo(4,dd,Ajudas)) :- Ajudas >= 250, Ajudas =< 750. 
-jogo(4,dd,Ajudas) :- Ajudas < 250; Ajudas > 750.

% v)  interdito

jogo(5,ee,xpto3).
execao(jogo(I,A,C)) :-jogo(I,A,xpto3).

nuloindeterminado(xpto3).

% vi) Indeterminado

jogo(6,ff,250).

execao(jogo(6,ff,Ajudas)) :- Ajudas > 5000.

% vii) Incerto

-jogo(7,gg,2500).
execao(jogo(7,gg,Ajudas)) :- jogo(I,A,xpto).


%viii) Inderterminado
cerca(X,Sup,Inf) :-
    Sup is X * 1.25,
    Inf is X * 0.75.

excecao(jogo(8,hh,Ajudas)) :-
    cerca(1000,Csup,Cinf),
    Ajudas >= Cinf, Ajudas =< Csup.

% ix)
cerca2(X,Sup,Inf) :-
    Sup is X * 1.1,
    Inf is X * 0.9.

excepcao(jogo(9,ii,Ajudas)) :- cerca2(3000,Csup,Cinf),
    Ajudas >= Cinf, Ajudas =< Csup.

%x  Invariante referencial

+jogo(J,A,AJ) :: (solucoes((A),(jogo(J,A,AJ)),S),
                 comprimento(S,N),
                 N==1). 

%xi


+jogo(J,A,AJ) :: (solucoes((Js),(jogo(Js,A,AJ)),S),
                 comprimento(S,N),
                 N=<3). 



%xii
head([H|T],H).

consecutivo([H|T]) :- head(T,L), H == L-1.
consecutivo([H|T]) :- head(T,L), H \= L-1,consecutivo(T).

+jogo(J,A,AJ) :: (solucoes(Js,jogo(Js,Arbitro,_),S),
                 nao(consecutivo(S))).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado si: Questao,Resposta -> {V,F}
%                            Resposta = { verdadeiro,falso,desconhecido }
 
si(Questao,verdadeiro):-
    Questao.
si(Questao,falso):-
    -Questao.
si(Questao,desconhecido):-
    nao(Questao),
    nao(-Questao).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}
 
nao(Questao):-
    Questao, !, fail.
nao(Questao).


evolucao(Termo) :-
    solucoes(Invariante,+Termo::Invariante,Lista),
    insercao(Termo),
    teste(Lista).

involucao(Termo) :-
    solucoes(Invariante,-Termo::Invariante,Lista),
    remocao(Termo),
    teste(Lista).

comprimento(S,N):- length(S,N).

solucoes(X,Y,Z) :- findall(X,Y,Z).