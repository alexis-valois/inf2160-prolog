% Alexis Valois-Adamowicz VALA10049105
:- dynamic article/6.
:- dynamic panier/1.


%vetement
article(vetement, v01, 130, gris, veste, 2).
article(vetement, v02, 85, rouge, robe, 1).
article(vetement, v03, 55, noir, pantalon, 6).
article(vetement, v04, 67, bleu, chemise, 5).
article(vetement, v05, 43, bleu, jupe, 1).

%electronique
article(electronique, e01a, 500, samsung, tablette,2).
article(electronique, e01b, 900, apple, tablette, 1).
article(electronique, e02a, 1600, apple, ordinateur, 0).
article(electronique, e03a, 1000, apple, telephone,10).
article(electronique, e03b, 660, sony, telephone, 3).
article(electronique, e03c, 350, nokia, telephone, 4).
article(electronique, e04, 550, samsung, televiseur,1).

%jeux
article(jeux, j01, 99, fIFa16, ps4, 5).
article(jeux, j03, 79, assassinsCreed, ps4, 1).
article(jeux, j04, 75, callDuty, ps4, 7).
article(jeux, j05, 67, mario, nintendo3Ds, 1).
article(jeux, j06, 85, callDuty, xboxOne, 1).
articles(L) :- findall(article(Ca,Cod,P,X,Y,Q), article(Ca,Cod,P,X,Y,Q), L). % Extraction de la liste de tous les articles de la BC (Banque de connaissances)

panier([]).

% Déclaration du menu
menu :- write('<== **********Bienvenue au centre d\'achat NTAA********** ==>'),nl, 
        write('Inscrivez le montant d\'argent que vous voulez depenser: '), read(Solde), nl, 
        write('Nous vous souhaitons un agreable magasinage !!'), nl, nl, menu(Solde).
menu(Solde) :- write('Solde courant: '), write(Solde), nl, 
                 write('1. Visualiser la liste des articles en stock'), nl, 
                 write('2. Visualiser les articles dans mon panier'), nl, 
                 write('3. Ajouter un article au panier'), nl, 
                 write('4. Supprimer un article du panier'), nl, 
                 write('5. Effectuer le paiement'),nl, 
                 write('0. Quitter :( '), nl, 
                 write('Option:'), read(X), nl,choix(X, Solde).
choix(0, _) :-     retract(panier(_)), assert(panier([])), write('Bye bye.'),nl,!.
choix(1, Solde) :- articles(L), afficherArticles(L),nl, menu(Solde), !.
choix(2, Solde) :- panier(L), traiterPanier(L),  menu(Solde),!.
choix(3, Solde) :- write('CodeBarre de l\'article a ajouter : '), nl, read(X), ajouterArticle(X, Solde, NouveauSolde), menu(NouveauSolde), !.
choix(4, Solde) :- write('CodeBarre de l\'article a retirer (1 seul article de ce type sera retire) : '), nl, read(X), enleverArticle(X, Solde, NouveauSolde), menu(NouveauSolde), !.
choix(5, Solde) :- traiterAchat(Solde), !.
choix(_, Solde) :- write('selection invalide.'),nl, menu(Solde), !.

/* 1- (1 pt) définissez le prédicat afficherArticles(L), qui affiche (chacun sur une ligne différente) chaque élément de la liste passée en argument.
 Voir dans l'énnoncé (Atelier12.pdf)comment l'affichage se fait .*/
afficherArticles([A|Reste]) :- write(A), nl, afficherArticles(Reste).

/* 2- le prédicat traiterPanier(L), affiche la liste d'objets passée en argument si elle n'est pas vide ou alors affiche 'Votre panier est vide' dans le cas contraire */
traiterPanier([]) :-  write('Votre panier est vide.'),nl.
traiterPanier(L) :- afficherArticles(L).

/* 3- (1.5 pt) définissez le prédicat ajouterArticle(Codebarre,Solde,NouveauSolde) qui ajoute l'article ayant comme codebarre Codebarre au panier. 
           Cas à envisager:
               - si l'article n'exite pas, afficher le message "cet article n\'existe pas !"
               - si la quantité en stock est inférieur à ou égale 0, afficher le message "cet article est fini en stock"
               - sinon, ajouter l'article au panier et mettez à jour le Solde du client ainsi que la quantité en stock de l'article
           Remarque: L'ajout se fait en tête de liste */

ajouterArticle(Codebarre,Solde,NouveauSolde) :- article(A,Codebarre,P,C,D,Q), NQ is Q - 1, retract(article(A,Codebarre,P,C,D,Q)), assert(article(A,Codebarre,P,C,D,NQ)), asserta(panier([article(A,Codebarre,P,C,D,NQ)])), NouveauSolde is Solde - P.  
ajouterArticle(Codebarre,Solde,NouveauSolde) :- article(_,Codebarre,_,_,_,Q), Q =< 0, write('cet article est fini en stock'),nl, NouveauSolde = Solde, !.
ajouterArticle(_,Solde,NouveauSolde) :- write('cet article n\'existe pas !'),nl, NouveauSolde = Solde.
           
/* 4- (1.5 pt) définissez le prédicat enleverArticle(Codebarre,Solde,NouveauSolde) qui enlève l'article ayant comme codebarre Codebarre au panier. 
           Cas à envisager:
               - si l'article n'exite pas, afficher le message "cet article n\'existe pas !"
               - si l'article ne se trouve pas dans le panier, "cet article ne se trouve pas dans votre panier"
               - sinon, supprimer la première occurence de l'article dans le  panier et mettez à jour le Solde du client ainsi que la quantité en stock de l'article
           Piste de solution:  l'instruction 'not(member(article(_,C,_,_,_,_), L))' retourne vrai si l'article au codebarre C n'exite pas dans L */           
/*
enleverArticle(Codebarre,Solde,NouveauSolde) :- article(_,Codebarre,P,_,_,Q), NQ is Q - 1, assert(article(_,Codebarre,_,_,_,NQ)), asserta(panier(article(_,Codebarre,_,_,_,_))), NouveauSolde is Solde - P.  
enleverArticle(Codebarre,Solde,NouveauSolde) :- article(_,Codebarre,_,_,_,Q), Q =:= 0, write('cet article est fini en stock'),nl, NouveauSolde = Solde, !.
enleverArticle(_,Solde,NouveauSolde) :- write('cet article n\'existe pas !'),nl, NouveauSolde = Solde.
*/   
/* 5- (1 pt) définissez le prédicat traiterAchat(Solde), qui:
               - Si le solde est négatif, affiche le solde courant, le message 'Vous devez retirer des articles car votre solde est negatif' et renvoit le client au menu principal 
               - Dans le cas contraire (Solde positif), affiche la liste des articles dans le panier, le solde courant et le message 'Merci d\'avoir magasiner chez nous' enfin appel le prédicat 'choix(0,2)' pour quitter. 
               */