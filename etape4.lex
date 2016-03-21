NT		{printf("INT \n");}
FLOAT		{printf("FLOAT \n");}
BOOLEAN		{printf("BOOLEAN \n");}
STRING		{printf("STRING \n");}
CHAR		{printf("CHAR \n");}
CREERAGENT	{printf("CREERAGENT \n");}
RANDOM		{printf("RANDOM \n");}
MANUAL		{printf("MANUAL \n");}
TABLE		{printf("TABLE \n");}
SUPPRAGENT	{printf("SUPPRAGENT \n");}
MODIFAGENT	{printf("MODIFAGENT \n");}

[tT][rR][uU][eE]	{printf("VRAI \n");}
[fF][aA][lL][sS][eE]	{printf("FAUX \n");}

[a-zA-Z][a-zA-Z0-9_]*	{printf("IDF %s \n",yytext); 
			/* affichage de l'unité lexicale et de l'identifiant */}

[a-zA-Z][a-zA-Z0-9_]*\.[a-zA-Z0-9]{1,4}	{printf("NOMFIC %s \n",yytext);
			/* affichage de l'unité lexicale et du nom de fichier */}

\"([^"]|\"\")*\"	{char chaine[256]=""; 
				if (strlen(yytext)>2) strncpy(chaine,yytext+1,strlen(yytext)-2) ; 
				printf("CHAINE %s \n",chaine);
			/* affichage de l'unité lexicale et de la chaîne sans les guillemets
				(non demandé mais utile pour la suite) */}

\'.\'			{char caractere[2]=""; strncpy(caractere,yytext+1,1);
				printf("CARACTERE %s \n",caractere);
			/* affichage de l'unité lexicale et du caractère sans les apostrophes
				(non demandé mais utile pour la suite) */}

[0-9]+\.[0-9]+	{printf("REEL %s \n",yytext);
			/* affichage de l'unité lexicale et du réel */}

[0-9]+		{printf("ENTIER %s \n",yytext);
			/* affichage de l'unité lexicale et de l'entier */}

\(		{printf("PO \n");}
\)		{printf("PF \n");}
\,		{printf("VG \n");}
\;		{printf("PV \n");}
\:		{printf("DXPT \n");}
\#		{printf("DIESE \n");}
\<		{printf("INF \n");}
\>		{printf("SUP \n");}
\!		{printf("NON \n");}
\=		{printf("AFFECT \n");}
\+		{printf("PLUS \n");}
\-		{printf("MOINS \n");}
\*		{printf("MULTI \n");}
\/		{printf("DIVIS \n");}
\^		{printf("EXPO \n");}

\=\=		{printf("EGAL \n");}
\<\=		{printf("INEG \n");}
\>\=		{printf("SUPEG \n");}
\!\=		{printf("DIFF \n");}
\&\&		{printf("ET \n");}
\|\|		{printf("OU \n");}

[ \t\r\n]	;
.		{printf("Symbole inconnu %s \n",yytext);
			/* affichage du message d'erreur et du symbole non reconnu */}
%%

int yywrap()
{
	printf("Fin de l'analyse lexicale \n");
}

