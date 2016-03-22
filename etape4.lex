%%
INT		{return INT ;}
FLOAT		{return FLOAT ;}
BOOLEAN		{return BOOLEAN ;}
STRING		{return STRING ;}
CHAR		{return CHAR ;}
CREERAGENT	{return CREERAGENT ;}
RANDOM		{return RANDOM ;}
MANUAL		{return MANUAL ;}
TABLE		{return TABLE ;}
SUPPRAGENT	{return SUPPRAGENT ;}
MODIFAGENT	{return MODIFAGENT ;}

[tT][rR][uU][eE]	{return VRAI ;}
[fF][aA][lL][sS][eE]	{return FAUX ;}

[a-zA-Z][a-zA-Z0-9_]*	{return IDF;  
			/* affichage de l'unité lexicale et de l'identifiant */ }

[a-zA-Z][a-zA-Z0-9_]*\.[a-zA-Z0-9]{1,4}	{return NOMFIC; 
			/* affichage de l'unité lexicale et du nom de fichier */}

\"([^"]|\"\")*\"	{char chaine[256]=""; 
				if (strlen(yytext)>2) strncpy(chaine,yytext+1,strlen(yytext)-2) ; 
				return CHAINE;
			/* affichage de l'unité lexicale et de la chaîne sans les guillemets
				(non demandé mais utile pour la suite) */}

\'.\'			{char caractere[2]=""; strncpy(caractere,yytext+1,1);
				return CARACTERE ;
			/* affichage de l'unité lexicale et du caractère sans les apostrophes
				(non demandé mais utile pour la suite) */}

[0-9]+\.[0-9]+	{return REEL;
			/* affichage de l'unité lexicale et du réel */}

[0-9]+		{return ENTIER ;
			/* affichage de l'unité lexicale et de l'entier */}

\(		{return PO ;}
\)		{return PF ;}
\,		{return VG ;}
\;		{return PV ;}
\:		{return DXPT ;}
\#		{return DIESE ;}
\<		{return INF ;}
\>		{return SUP ;}
\!		{return NON ;}
\=		{return AFFECT ;}
\+		{return PLUS ;}
\-		{return MOINS ;}
\*		{return MULTI ;}
\/		{return DIVIS ;}
\^		{return EXPO ;}

\=\=		{return EGAL ;}
\<\=		{return INEG ;}
\>\=		{return SUPEG ;}
\!\=		{return DIFF ;}
\&\&		{return ET ;}
\|\|		{return OU ;}

[ \t\r\n]	{;}
.		{printf("Symbole inconnu %s \n",yytext);
			/* affichage du message d'erreur et du symbole non reconnu */}
%%

int yywrap()
{
	printf("Fin de l'analyse lexicale \n");
return 0;
}

