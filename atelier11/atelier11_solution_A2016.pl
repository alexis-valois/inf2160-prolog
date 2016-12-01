aliment(pomme, fruit, sucre, rouge).
aliment(orange, fruit, sucre, orange).
aliment(cerise, fruit, sucre, rouge).
aliment(banane, fruit, sucre, jaune).
aliment(navet, legume, amer, blanc).
aliment(tomate, fruit, sucre, rouge).
aliment(carotte, legume, sucre, orange).
aliment(laitue, legume, amer, vert).
aliment(citron, fruit, acidule, jaune).
aliment(lime, fruit, acidule, vert).
aliment('chou de Bruxelles', legume, amer, vert).
aliment(ketchup, condiment, acidule, rouge).
aliment(relish, condiment, sucre, vert).

aliments([pomme, orange, cerise, banane, navet, tomate, carotte, laitue, citron, lime, 'chou de Bruxelles', ketchup, relish]).
aliments2([pomme, orange, pomme, cerise, banane, navet, tomate, carotte, laitue, citron, lime, 'chou de Bruxelles', ketchup, relish, pomme, navet, citron, pomme, navet, pomme, relish]).

conc([], L, L). 
conc([X|L1], L2, [X|L3]):- conc(L1, L2, L3).

member1(X, L) :- conc(_, [X|_], L). 

meme_type([X]).
meme_type([X,Y|L]) :- aliment(X,T,_,_), aliment(Y,T,_,_), meme_type([Y|L]).

/* Version 2 prédicat meme_type
meme_type([]).
meme_type([A1| Reste]) :- aliment(A1,Type,_,_), meme_type_donne(Type,Reste).

meme_type_donne(_,[]).
meme_type_donne(Type,[A2|Reste]) :- aliment(A2, Type,_,_), meme_type_donne(Type,Reste).
*/

% renvoi la liste d'aliments d'un certain goût
aliments_de_gout(G, L) :- aliments(L1), aliments_de_gout(G, L, L1), !.
aliments_de_gout(_, [], []).
aliments_de_gout(G, [T|Q], [T|Q1]) :- aliment(T, _, G, _), aliments_de_gout(G, Q, Q1).
aliments_de_gout(G, Q, [_|Q1]) :- aliments_de_gout(G, Q, Q1).

% renvoi un élément quand on lui donne une position et une liste
element_n(1, [X|L], X).
element_n(N, [_|L], E):- N>1, N1 is N-1, element_n(N1,L,E).

% union de deux ensembles
union2([], E, E).
union2([T|E1], E2, [T|Eu]) :- \+ member(T, E2), !, union2(E1, E2, Eu).
union2([_|E1], E2, Eu) :- union2(E1, E2, Eu).
/*union2([],E2,E2).
union2([X|E1], E2, U):- appartient(X,E2), !, union2(E1,E2,U).
union2([X|E1],E2,[X|U]) :- union2(E1,E2,U).

appartient(X,[X|_]).
appartient(X,[_|L]) :- appartient(X,L). */

% Intersection de deux ensembles
inter([],_,[]).
inter([X|E1], E2, [X|I]) :- member(X,E2),!, inter(E1,E2,I).
inter([_|E1],E2,I) :- inter(E1,E2,I).

% moyenne d'une liste
somme([],0).
somme([T|Q], S) :- somme(Q,S2), S is S2 + T.

nbElement([], 0).
nbElement([_|Q], N) :- nbElement(Q,N2), N is N2 + 1.

moyenne(L, M) :- somme(L, S), nbElement(L, N), M is S / N.
/* Autre solution
moyenne(L,N) :- moyenne(L,0,0,N).
moyenne([],Nb,Som,Moy) :- Moy is Som / Nb.
moyenne([T|Q],Nb,Som,Moy) :- N2 is Nb + 1, S2 is Som + T, moyenne(Q, N2, S2, Moy). */

% inverse d'une liste
inverse(L,I) :- inverse(L, [], I).
inverse([], I, I).
inverse([T|Q],I, R) :- inverse(Q,[T|I],R).
/* en utilisant conc(valide dans sicstus)
inverse([],[]).
inverse([T|Q],I) :- inverse(Q,I2), conc(I2,[T],I). */ 

% maximum d'une liste
max([],0) :- !.
max([T|L],M) :- max(L,T,M), !.
max([],M,M) :- !.
max([T|Q],Temp, M) :- T > Temp, max(Q, T, M).
max([_|Q],Temp, M) :- max(Q, Temp, M).

% Structures
acteur('Schawrznnegger Arnold',ma,1000,date(1978,4,1),arnold).
acteur('Streep Meryll',fe,1500,date(1984,9,1),merryl).
nombre_annees_experience2012(A,Na) :- acteur(_,_,_ ,date(Adebut,_,_),A), Na is 2012 - Adebut.