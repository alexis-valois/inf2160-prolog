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

meme_gout(A1,A2) :- aliment(A1,_,G,_), aliment(A2,_,G,_).
similaires(A1,A2,T) :- aliment(A1, T, _, _), aliment(A2, T, _, _).
similaires(A1,A2,G) :- aliment(A1, _, G, _), aliment(A2, _, G, _).
similaires(A1,A2,C) :- aliment(A1, _, _, C), aliment(A2, _, _, C).
/*
ou
similaires(A1, A2, S) :- aliment(A1, S, _, _), aliment(A2, S, _, _);
        aliment(A1, _, S, _), aliment(A2, _, S, _);
        aliment(A1, _, _, S), aliment(A2, _, _, S).
*/
aliment_non_fruit(A) :- aliment(A, T, _, _), \+ T = fruit.
% ou aliment_non_fruit(A) :- aliment(A, _, _, _), \+ aliment(A, fruit, _, _).

non_fruit_de_gout(A, G) :- aliment_non_fruit(A), aliment(A, _, G, _).
% ou non_fruit_de_gout(A,G) :- aliment(A, T, G, _), T \= fruit.