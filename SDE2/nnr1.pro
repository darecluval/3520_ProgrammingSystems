/* SDE2
 * Clare DuVal
 * CPSC 3520
 */

/* Helper Functions */
/* prepend Function */
prepend(Tail, Head, [Head| Tail]).

/* least Function */
least([Head|Tail], Min) :-
    least(Tail, Head, Min).

least([], Min, Min).

least([Head|Tail], Min0, Min) :-
    Min1 is min(Head, Min0),
    least(Tail, Min1, Min).

/* find Function: Find the index of an list */
find([Element|_], Element, 0):- !.

find([_|Tail], Element, Index):-
  find(Tail, Element, Index1),
  !,
  Index is Index1+1.

/* getIDX Function: Find the elem at an index */
/* Built in: nth0(Num, List, Elem) */

/* Required Functions */
/* 1: printList Function */
/* printList(+H) */
printList([Head]):-
  write(Head),
  nl,
	!.

printList([Head|Tail]):-
  write(Head),
  nl,
  printList(Tail).

/* 2: theClass Function */
/* theClass(+Avect, -C) */
theClass([Elem],Class):-
	Class is Elem,
	!.

theClass([_|Tail],Class):-
  theClass(Tail,Class).

/* 3: distanceR2 Function */
/* distanceR2(+H1, +H2, -DistSq) */
distanceR2([_],[_],DistSq):-
	DistSq = 0,
	!.

distanceR2([Head1|Tail1],[Head2|Tail2],DistSq):-
	distanceR2(Tail1, Tail2,Elem),
	DistSq is float(Elem + (Head2-Head1)^2).

/* 4: distanceAllVectors2 Function */
/* distanceAllVectors2(+H, +Vset, -Dist) */
distanceAllVectors2(_,[],DistSq):-
	DistSq = [],!.

distanceAllVectors2(List,[Head2|Tail2],DistSq):-
	distanceR2(List,Head2,Elem),
	distanceAllVectors2(List,Tail2,RetList),
	prepend(RetList,Elem,DistSq).

/* 5: nnr1 Function */
/* nnr1(+Test, +H, -Class) */
nnr1(L1, LOL, NNClass):-
	distanceAllVectors2(L1,LOL,DAV1),
	least(DAV1,Least),
	find(DAV1,Least,Idx),
	nth0(Idx, LOL, ElemList),
	theClass(ElemList,Class),
	NNClass is Class.
