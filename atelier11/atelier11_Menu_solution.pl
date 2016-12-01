% On déclare qu'aliment est dynamique pour pouvoir faire des assert et des retract. 
:- dynamic aliment/4.

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

% Déclaration du menu
menu :- write('<== Menu de gestion des aliments ==>'),nl, write('1. Visualiser un aliment'), nl, write('2. Ajouter un aliment'), nl, write('3. Retirer un aliment'), nl, write('4. Lister les aliments'), nl, write('5. Lister les aliments d\'un certain gout'),nl, write('0. Quitter'), nl, write('Entrez un choix:'), nl, read(X), choix(X).
choix(0) :- write('Bye bye.'),nl.
choix(1) :- write('Nom de l\'aliment a visualiser: '),nl, read(X), visualiser(X), menu.
choix(2) :- write('Nom du nouvel aliment: '),nl, read(X), ajouter(X), menu.
choix(3) :- write('Entre le nom de l\'aliment a enlever : '),nl, read(X), enlever(X), menu.
choix(4) :- aliments(L), write(L),nl, menu.
choix(5) :- write('Entrez un gout :'),nl, read(X), choixDeGout(X), menu.
choix(_) :- write('Sélection invalide.'),nl, menu.

aliments(L) :- findall(X, aliment(X,_,_,_), L).

aliments_de_gout(G, L) :- aliments(L1), aliments_de_gout(G, L, L1), !.
aliments_de_gout(_, [], []).
aliments_de_gout(G, [T|Q], [T|Q1]) :- aliment(T, _, G, _), aliments_de_gout(G, Q, Q1).
aliments_de_gout(G, Q, [_|Q1]) :- aliments_de_gout(G, Q, Q1).


% prédicat de visualisation
visualiser(X) :- aliment(X, T, G, C), !, write('Type : '), write(T), nl, write('Gout : '), write(G), nl, write('Couleur : '), write(C),nl.
visualiser(_) :- write('Aliment inexistant'),nl.

% prédicat d'ajout
ajouter(X) :- aliment(X,_,_,_), !, writeln('Cet aliment existe deja. Choix invalide.').
ajouter(X) :- write('Type : '), read(T), write('Gout : '), read(G), write('Couleur : '), read(C), assert(aliment(X,T,G,C)), write('Aliment ajoute.'),nl.

enlever(X) :- aliment(X,_,_,_), !, visualiser(X), write('Retirer cet aliment? (o/n)'),nl, read(R), retirer(R, X).
enlever(_) :- write('Aliment inexistant.'),nl.

retirer('o', X) :- write('Aliment retire.'), nl, retract(aliment(X,_,_,_)).
retirer('n', _) :- write('L\'aliment n\'a pas été retiré.'),nl.
retirer(_, X) :- write('Caractere invalide. '), write('Retirer cet aliment? (o/n)'), nl, read(R), retirer(R, X).

choixDeGout(X) :- aliment(_,_,X,_), !, aliments_de_gout(X, L), write(L),nl.
choixDeGout(_) :- write('Gout non existant'),nl.