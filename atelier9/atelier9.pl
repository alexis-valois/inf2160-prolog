relie_a('Paris', 'Toronto', v31).
relie_a('Paris', 'Londres', v32).
relie_a('Paris', 'Madrid', v33).
relie_a('Londres', 'Bruxelles', v11).
relie_a('Londres', 'Montreal', v12).
relie_a('Madrid', 'Londres', v41).
relie_a('Madrid', 'Paris', v42).
relie_a('Toronto', 'Madrid', v51).
relie_a('Toronto', 'Paris', v52).
relie_a('Toronto', 'Bruxelles', v53).
relie_a('Montreal', 'Paris', v21).

liaison(Ville1, Ville2) :- relie_a(Ville1, Ville2, _).
liaison(Ville1, Ville2) :- relie_a(Ville1, Escale, _), liaison(Escale, Ville2).


pair2(X) :- 0 is mod(X,2).

pair(0).
pair(X) :- X>0, X2 is X-2, pair(X2).

somme(0,0).
somme(N,X):- N>0, N1 is N-1, somme(N1,X1), X is N+X1.

maximum1(X,Y,X):- X >= Y.
maximum1(X,Y,Y):- X<Y.

maximum2(X,Y,Z) :- X>=Y,!, Z=X.
maximum2(_,Y,Y).

factoriel(0,1).
factoriel(X,Y) :- X > 0, Z is X-1, factoriel(Z,Y1), Y is Y1 * X.

fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,X) :- N > 1, U is N - 1, V is N - 2, fibonacci(U,U1),fibonacci(V,V1),X is U1 + V1.

suite(0,2).
suite(X,Y) :- X>0, Z is X - 1, suite(Z,Y1), Y is (2 * Y1) + 3.

nombrePairs(0).
nombrePairs(X):- nombrePairs(X1), X is X1 + 2.

entier(0).
entier(N) :- entier(N1), N is N1+1.
racineCarree(N,R):- entier(X), X * X > N, !, R is X -1.

voyage(Depart, Escale, Arrivee) :- liaison(Depart,Escale), liaison(Escale,Arrivee),!.
voyage(Depart, Escale1,Escale2, Arrivee) :- liaison(Depart,Escale1), liaison(Escale1,Escale2), liaison(Escale2,Arrivee),!.

circuit(Ville1,Ville2) :- relie_a(Ville1,Ville2,_),relie_a(Ville2,Ville1,_).
circuit(Ville1,Ville2,Ville3) :- relie_a(Ville1,Ville2,_),relie_a(Ville2,Ville3,_),relie_a(Ville3,Ville1,_).
circuit(Ville1,Ville2,Ville3) :- relie_a(Ville1,Ville3,_),relie_a(Ville3,Ville2,_),relie_a(Ville2,Ville1,_).

vacances(Ville) :- aller_direct_retour_direct('Montreal',Ville),!, write('aller direct; '),write('retour direct; ').
vacances(Ville) :- aller_escale_retour_direct('Montreal',Ville),!, write('aller avec escale(s); '),write('retour direct; ').
vacances(Ville) :- aller_direct_retour_escale('Montreal',Ville),!, write('aller direct; '),write('retour avec escale(s); ').
vacances(Ville) :- aller_escale_retour_escale('Montreal',Ville),!, write('aller avec escale(s); '),write('retour avec escale(s); ').
vacances(_) :- write('Vacances impossibles'), !, fail.

aller_direct_retour_direct(Ville1,Ville2) :- relie_a(Ville1, Ville2, _), relie_a(Ville2, Ville1, _).
aller_escale_retour_direct(Ville1,Ville2) :- liaison(Ville1,Ville2), !, relie_a(Ville2, Ville1, _). %le cut sert ici Ã  ne considÃ©rer que la premiÃ¨re solution c-Ã -d la liaison entre Bruxelles et MontrÃ©el si une telle liaison existe.

aller_direct_retour_escale(Ville1,Ville2) :- relie_a(Ville1, Ville2, _), liaison(Ville2,Ville1).
aller_escale_retour_escale(Ville1,Ville2) :- liaison(Ville1,Ville2), !, liaison(Ville2,Ville1).











