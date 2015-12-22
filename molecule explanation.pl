consult(molecule).

%molecule(Molecule_string,[Atom1,Atom2,...,AtomN]): Atom1 through AtomN are atoms and their abbreviations are concatenated into Molecule_string
molecule(M,[An|T]):-atom_name(A,An,_),append(A,M2,M),molecule(M2,T).
molecule([],[]).

%molecule_errors(M,L,N): same as molecule, but N characters are not valid atoms. They are denoted by X.
molecule_errors(M,ListOfAtoms,0):-molecule(M,ListOfAtoms).
molecule_errors(M,[An|T],NumberOfErrors):- NumberOfErrors > 0, atom_name(A,An,_) ,append(A,M2,M), molecule_errors(M2,T,NumberOfErrors).
molecule_errors([_|M],[x|T],NumberOfErrors):-NumberOfErrors>0, NewErrors is NumberOfErrors-1, molecule_errors(M,T,NewErrors).

%molecule_min_errors(M,L,N): only if molecule_errors(M,L,N) and there are no solutions for smaller N
molecule_min_errors(M,L,N):-molecule_min_max_errors(M,L,N,0).

%molecule_min_max_errors(M,L,-N_correct,+N_attempt): helper function.
molecule_min_max_errors(M,L,N_correct,N):-( molecule_errors(M,L,N) -> N_correct = N; N1 is N+1, molecule_min_max_errors(M,L,N_correct,N1)).

%fullnames(Labb,Lname): Labb is a list of abbreviations of chemical elements and Lname is a list of the corresponding English names.
fullnames([Habb|Tabb],[Hname|Tname]):-atom_name(_,Habb,Hname),fullnames(Tabb,Tname).
fullnames([x|Tabb],[mystery_element|Tname]):-fullnames(Tabb,Tname).
fullnames([],[]).