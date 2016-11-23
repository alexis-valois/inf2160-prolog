aliment(pomme,fruit).
aliment(orange,fruit).
aliment(navet,legume).
aliment(carotte,legume).
aliment(cerise,fruit).
aliment(banane,fruit).

gout(orange,sucre).
gout(navet,amer).
gout(pomme,sucre).
gout(carotte,sucre).

couleur(pomme,rouge).
couleur(orange,orange).
couleur(carotte,orange).

% requete (a) Comment savoir si un navet est sucrÃ© = gout(navet,sucre).
% requete (b) Quel est la liste des lÃ©gumes ? = aliment(A,legume).
% requete (c) Quel est la couleur  d'une pomme ? = couleur(pomme,C).
% requete (d) Quels sont les fruits sucrÃ©s? = aliment(A,fruit),gout(A,sucre).
% requete (e) Quels aliments sont de couleur orange et de goÃ»t sucrÃ© ? = aliment(A,_),couleur(A,orange),gout(A,sucre).
% requete (f) Quels lÃ©gumes sont verts ? = aliment(A,legume),couleur(A,vert).