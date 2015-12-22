atom_name("h", h , hydrogen).
atom_name("he", he , helium).
atom_name("li", li , lithium).
atom_name("be", be , beryllium).
atom_name("b", b , boron).
atom_name("c", c , carbon).
atom_name("n", n , nitrogen).
atom_name("o", o , oxygen).
atom_name("f", f , fluorine).
atom_name("ne", ne , neon).
atom_name("na", na , sodium).
atom_name("mg", mg , magnesium).
atom_name("al", al , aluminium).
atom_name("si", si , silicon).
atom_name("p", p , phosphorus).
atom_name("s", s , sulfur).
atom_name("cl", cl , chlorine).
atom_name("ar", ar , argon).
atom_name("k", k , potassium).
atom_name("ca", ca , calcium).
atom_name("sc", sc , scandium).
atom_name("ti", ti , titanium).
atom_name("v", v , vanadium).
atom_name("cr", cr , chromium).
atom_name("mn", mn , manganese).
atom_name("fe", fe , iron).
atom_name("co", co , cobalt).
atom_name("ni", ni , nickel).
atom_name("cu", cu , copper).
atom_name("zn", zn , zinc).
atom_name("ga", ga , gallium).
atom_name("ge", ge , germanium).
atom_name("as", as , arsenic).
atom_name("se", se , selenium).
atom_name("br", br , bromine).
atom_name("kr", kr , krypton).
atom_name("rb", rb , rubidium).
atom_name("sr", sr , strontium).
atom_name("y", y , yttrium).
atom_name("zr", zr , zirconium).
atom_name("nb", nb , niobium).
atom_name("mo", mo , molybdenum).
atom_name("tc", tc , technetium).
atom_name("ru", ru , ruthenium).
atom_name("rh", rh , rhodium).
atom_name("pd", pd , palladium).
atom_name("ag", ag , silver).
atom_name("cd", cd , cadmium).
atom_name("in", in , indium).
atom_name("sn", sn , tin).
atom_name("sb", sb , antimony).
atom_name("te", te , tellurium).
atom_name("i", i , iodine).
atom_name("xe", xe , xenon).
atom_name("cs", cs , cesium).
atom_name("ba", ba , barium).
atom_name("la", la , lanthanum).
atom_name("ce", ce , cerium).
atom_name("pr", pr , praseodymium).
atom_name("nd", nd , neodymium).
atom_name("pm", pm , promethium).
atom_name("sm", sm , samarium).
atom_name("eu", eu , europium).
atom_name("gd", gd , gadolinium).
atom_name("tb", tb , terbium).
atom_name("dy", dy , dysprosium).
atom_name("ho", ho , holmium).
atom_name("er", er , erbium).
atom_name("tm", tm , thulium).
atom_name("yb", yb , ytterbium).
atom_name("lu", lu , lutetium).
atom_name("hf", hf , hafnium).
atom_name("ta", ta , tantalum).
atom_name("w", w , tungsten).
atom_name("re", re , rhenium).
atom_name("os", os , osmium).
atom_name("ir", ir , iridium).
atom_name("pt", pt , platinum).
atom_name("au", au , gold).
atom_name("hg", hg , mercury).
atom_name("tl", tl , thallium).
atom_name("pb", pb , lead).
atom_name("bi", bi , bismuth).
atom_name("po", po , polonium).
atom_name("at", at , astatine).
atom_name("rn", rn , radon).
atom_name("fr", fr , francium).
atom_name("ra", ra , radium).
atom_name("ac", ac , actinium).
atom_name("th", th , thorium).
atom_name("pa", pa , protactinium).
atom_name("u", u , uranium).
atom_name("np", np , neptunium).
atom_name("pu", pu , plutonium).
atom_name("am", am , americium).
atom_name("cm", cm , curium).
atom_name("bk", bk , berkelium).
atom_name("cf", cf , californium).
atom_name("es", es , einsteinium).
atom_name("fm", fm , fermium).
atom_name("md", md , mendelevium).
atom_name("no", no , nobelium).
atom_name("lr", lr , lawrencium).
atom_name("rf", rf , rutherfordium).
atom_name("db", db , dubnium).
atom_name("sg", sg , seaborgium).
atom_name("bh", bh , bohrium).
atom_name("hs", hs , hassium).
atom_name("mt", mt , meitnerium).
atom_name("ds", ds , darmstadtium).
atom_name("rg", rg , roentgenium).
atom_name("cn", cn , copernicium).
atom_name("uut", uut , ununtrium).
atom_name("uuq", uuq , ununquadium).
atom_name("uup", uup , ununpentium).
atom_name("uuh", uuh , ununhexium).
atom_name("uus", uus , ununseptium).
atom_name("uuo", uuo , ununoctium ).

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