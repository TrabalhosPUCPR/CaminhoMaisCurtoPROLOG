% GRUPO :
% Gabriel Sposito
% Leonardo Knight
% Pedro Amadeu
% Theo Cesar
% Thomas Frentzel

aresta(a,b).
aresta(b,e).
aresta(a,c).
aresta(c,d).
aresta(e,d).
aresta(d,f).
aresta(d,g).
aresta(f,g).
aresta(g,h).
aresta(f,h).
aresta(h,i).
aresta(i,j).
aresta(h,j).
aresta(j,k).
aresta(k,l).
aresta(l,n).
aresta(n,m).
aresta(m,t).
aresta(t,q).
aresta(q,z).

%path(X,Y) :- aresta(X,Y).
%path(X,Y) :- aresta(X,Z), path(Z,Y).

%A path from A to B is obtained if A and B are connected
conectado(X,Y) :- aresta(X,Y) ; aresta(Y,X).

%A path from A to B is obtained provided that A is connected to a 
%node C different from B that is not on the previously visited part of the path, 
%and one continues finding a path from C to B

paths(A, B, Path) :- caminho(A, B, [A], Q), reverse(Q,Path).

shortestpath(A, B, Path) :- 
    caminho(A, B, [A], Q), 
    reverse(Q,Path), 
    not(shorter(A, B, Path)), % se nao tiver nenhum outro caminho menor que este
    !.
    
shorter(A, B, Path) :- % procura e retorna verdadeiro o momento que encontra um caminho menor
    caminho(A, B, [A], Q), 
    reverse(Q,Path2), 
    compare(Path2, Path),
    !.
    
compare(Path, Path2) :- comprimento(Path, P), comprimento(Path2, P2), P < P2.

caminho(A,B,P,[B|P]) :- conectado(A,B).
caminho(A,B,Visited,Path) :-
       conectado(A,C), C \== B,
       not( member(C,Visited)),
       caminho(C,B,[C|Visited],Path). 

comprimento(List,Length) :- comprimento(List,0,Length).
comprimento([],Length,Length).
comprimento([_|Tail],Acumulator,Length) :-
             NewAc is Acumulator + 1, 
             comprimento(Tail,NewAc,Length).

/** <examples>
?- paths(a, f, X).
?- shortestpath(a, f, X).
?- paths(a, m, X).
?- shortestpath(a, m, X).
*/
