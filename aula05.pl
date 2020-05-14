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

voa(X) :- ave(X),nao(excecao(voa(X))).

-voa(X) :- mamifero(X),nao(excecao(-voa(X))).
-voa(tweety).
-voa(X) :- excecao(voa(X)).

voa(X)  :- excecao(-voa(X)).

ave(pitigui).
ave(X) :- canario(X).
ave(X) :- periquito(X).

canario(piupiu).

mamifero(silvestre).

mamifero(X) :- cao(X).
mamifero(X) :- gato(X).

cao(bobby).

ave(X) :- avestruz(X).
excecao(voa(X)) :- avestruz(X).

ave(X) :- pinguim(X).
excecao(voa(X)) :- pinguim(X).

avestruz(trux).
pinguim(pingu).

mamifero(X) :- morcego(X).
excecao(-voa(X)) :- morcego(X).
morcego(batemene).

-ave(X) :- mamifero(X).

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
