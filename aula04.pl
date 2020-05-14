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

par(X) :- X mod 2 =:= 0.

mypar(0).
mypar(X):- Z is X-2,Z>=0,mypar(Z).

impar(1).
impar(X):- Z is X-2,Z>=1,impar(Z).

natural(1).
natural(X) :- Z is X-1,Z>=1,natural(Z).

inteiros(0).
inteiros(X) :- Z is X-1,Z>=0,inteiros(Z).
inteiros(X) :- Z is X+1,Z=<0,inteiros(Z).

divisivel(0,_).
divisivel(X,Y) :- Z is X-Y,Z>=0,divisivel(Z,Y).

divisores(X,[1,X]).
divisores(N,[H|T]) :- .        



