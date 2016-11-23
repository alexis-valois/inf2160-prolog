%Partie 1: Gestion dâ€™un compteur
% cptInit/2
cptInit(Cpt,Val) :-
    killCpt(Cpt), integer(Val), recorda(Cpt,Val,_).
% killCpt /1
killCpt(Cpt) :- recorded(Cpt,_,Ref), erase(Ref). %fail
killCpt(_).

% cptFin /2
cptFin(Cpt) :- killCpt(Cpt).

% cptVal /2
cptVal(Cpt,Val) :- recorded(Cpt,Val,_).

% cptInc /2
cptInc(Cpt, Inc) :-
  integer(Inc), recorded(Cpt,Val,Ref), erase(Ref),
  V is Val + Inc, recorda(Cpt,V,_).

% alphabet /0  Remarque: utilisez put Ã  la place de put_code avec SWI_Prolog
alphabet :-
    cptInit(c ,97) ,
    repeat ,
     cptVal(c,V), put_code(V), put_code(32), cptInc(c ,1), 
     V =:= 122 , !,
     cptFin(c).

%Partie 2: ImplÃ©mentation de structures de contrÃ´le...

:- op(900 , fx ,si), op(850 , xfx , alors ), op(800 , xfx , sinon ).
:- op(900 , fx ,repeter ), op(850 , xfx , jusqua ).
:- op(900 , fx ,pour ), op(800 , xfx , faire ).
:- op(850 , xfx ,to), op(850 , xfx , downto ).
:- op(900 , fx ,selon ), op(850 , xfx , dans ), op(800 , xfx , autrement ).
:- op(750 , xfx ,:=) , op(750 , xfx ,:).

%question 1
/*
Expressions parenthÃ©sÃ©es
â€“	si P alors Q  => si (P alors Q)
â€“	si P alors Q sinon R => si (P alors (Q sinon R))
â€“	selon X dans [X1 :Q1, X2 :Q2,...,Xn :Qn] =>  selon (X dans [(X1 : Q1), (X2 : Q2), ... , (Xn : Qn)])
â€“	selon X dans [X1 :Q1, X2 :Q2,...,Xn :Qn autrement R] => selon (X dans [(((X1 : Q1), (X2 : Q2), ... , (Xn : Qn)) autrement R)])
â€“	repeter Q jusqua P => repeter (Q jusqua P)
â€“	pour Cpt := Min to Max faire Q => pour ((Cpt := Min) to (Max faire Q))
â€“	pour Cpt := Max downto Min faire Q => pour ((Cpt := Max) downto (Min faire Q))

*/

%question 2
% si /1
si P alors Q sinon _ :- call(P), !, call(Q).
si _ alors _ sinon R :- call(R), !.
si P alors Q :- call(P), !, call(Q).
si _ alors _.

% repeter /1
repeter Q jusqua P :-
repeat,
   call(Q),
   call(P), !.
   

% pour /1
pour i := Min to Max faire Q :- Min > Max , !.
pour i := Min to Max faire Q :- 
cptInit(i,Min), 
repeter 
     (call(Q),cptInc(i,1))
     jusqua(cptVal(i,Val), Val > Max).

pour i := Max downto Min faire Q :- Min > Max , !.
pour i := Max downto Min faire Q :- 
cptInit(i,Max), 
repeter 
     (call(Q),cptInc(i,-1))
     jusqua(cptVal(i,Val), Val < Min).
     
     
% selon /1   utilise les listes
selon X dans [Xi : Qi autrement R] :- !,
	si X = Xi alors call(Qi) sinon call(R).
selon X dans [Xi : Qi] :- !,
	si X = Xi alors call(Qi ).
selon X dans [Xi : Qi | XQ] :-
	si X = Xi alors call(Qi) sinon (selon X dans XQ ).
