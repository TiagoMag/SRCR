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
% Extensao do predicado soma : X,Y -> {V,F}

soma1( X,Y ) :- G is X+Y,write(G).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma : X,Y,Z -> {V,F}

soma( X,Y,Z ) :- G is X+Y+Z,write(G).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma : [A|B],Sum -> {V,F}

soma([],0).
soma([H|T],Sum) :- soma(T,N),Sum is H+N.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado opart : X,Y,Op -> {V,F}

opart( X,Y,Op ) :- (Op=='+') -> G is X+Y,write(G).
opart( X,Y,Op ) :- (Op=='-') -> G is X-Y,write(G).
opart( X,Y,Op ) :- (Op=='*') -> G is X*Y,write(G).
opart( X,Y,Op ) :- (Op=='/') -> G is X/Y,write(G).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado opL : [A|B],Acc,Op -> {V,F}


opL([],1,'*').
opL([H|T],Acc,Op) :- (Op=='*') -> opL(T,N,Op), Acc is H*N.
%opL([H|T],Acc,Op) :- opL(T,N,Op), Acc is opart( H,N,Op ).
opL([H|T],Op) :- (Op=='+') -> soma([H|T],N).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior : X,Y ->  {V,F}

maior(X,Y):- X>Y -> write(X).
maior(X,Y):- Y>X -> write(Y).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maX : X,Y,Z ->  {V,F}

max(X,Y,Z) :- (X>Y,X>Z) -> write(X).
max(X,Y,Z) :- (Y>X,Y>Z) -> write(Y).
max(X,Y,Z) :- (Z>X,Z>Y) -> write(Z).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maxL : [A|B],Max ->  {V,F}

maxL([H],H).
maxL([H|T],Max) :- maxL(T,Max),Max >= H.
maxL([H|T],H) :- maxL(T,Max),H>Max.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado media : [A|B],Avg ->  {V,F}

average([H],H).
average([H|T],Avg) :- soma([H|T],Sum),length([H|T],L),Avg is Sum/L.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado isort : [A|B],S ->  {V,F}

insert(X,[],[X]).
insert(X,[H|T],[X,H|T]):- X=<H.
insert(X,[H|T],[H|L]):- insert(X,T,L).

isort([],[]).
isort([H|T],S):-sort(T,S1),insert(H,S1,S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado isortD : [A|B],S ->  {V,F}

insertD(X,[],[X]).
insertD(X,[H|T],[H,X|T]):- X>H.
insertD(X,[H|T],[H|L]):- insert(X,T,L).

isortD([],[]).
isortD([H|T],S):-isortD(T,S1),insert(H,S1,S).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado countEmpty : [A|B],Sum ->  {V,F}


countnEmpty([],0).
countnEmpty([H|L],Sum) :- nEmpty(L,Res), H == [], Sum is Res + 1.
countEmpty([H|L],Sum) :- nEmpty(L,Res), Sum is Res.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado negacao : Predicado ->  {V,F}

neg(X):- \+X.
