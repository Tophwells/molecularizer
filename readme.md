Moleculariser
=============

This library converts lower-case text strings to lists of atomic symbols (H, He, Li, etc.).

Example usage:

    ?- molecule("timothy",L).
	L = [ti, mo, th, y] ;
	false.
	
	?- molecule("nosc",L).
	L = [n, o, s, c] ;
	L = [n, o, sc] ;
	L = [n, os, c] ;
	L = [no, s, c] ;
	L = [no, sc] ;
	false.
	
	?- molecule("susan",L).
	false.
	
	?- molecule_errors("susan",L).
	L = [s, u, s, x, n] ;
	false.
	
	?- molecule_errors("susan",L), fullnames(L,M).
	L = [s, u, s, x, n],
	M = [sulfur, uranium, sulfur, ###, nitrogen] ;
	false.