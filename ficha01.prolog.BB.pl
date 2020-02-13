%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao genealogica.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F}

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}

pai( P,F ) :-
    filho( F,P ).

pai( paulo,filipe ).
pai( paulo,maria ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}

avo( A,N ) :- pai( A,P ),pai( P,N ).
avo( A,N ) :- descendente( N,A,2 ).

avo( antonio,nadia ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado neto: Neto,Avo -> {V,F}

neto( N,A ) :- avo( A,N ).

neto( nuno,ana ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisavo: Bisavo,Bisneto -> {V,F}

bisavo( BA,BS ) :- pai( BA,A ),avo( A,BN ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado trisavo: Trisavo,Trisneto -> {V,F}

trisavo( TA,TN ) :- avo( TA,A ),avo( A,TN ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado tetravo: Tetravo,Tetraneto -> {V,F}

tetravo( TA,TN ) :-  bisavo( TA,A ),avo( A,TN ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% Extensao do predicado descendente: Descendente,Ascendente -> {V,F}

descendente( D,A ) :- filho( D,A ).
descendente( D,A ) :- neto( D,A ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}

descendente( D,A,1 ) :- filho( D,A ).
descendente( D,A,2 ) :- neto( D,A ). 

% descedente ( D,A,G ) :- filho( D,X ),descendente( %,A,N ),
                                                           G is N+1.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado masculino: Masculino -> {V,F}

masculino( joao ).
masculino( jose ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado feminino: Feminino -> {V,F}

feminino( maria ).
feminino( joana ).
