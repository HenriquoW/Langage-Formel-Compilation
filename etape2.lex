%{
	#include <string.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <assert.h>
	
	//On initialise la liste des champs lexicaux
	enum KindToken {DEFAGENT, PO, IDF, PV, DXPT, INT, FLOAT, BOOLEAN, STRING, CHAR, ENTIER, REEL, VG, PF, CREERAGENT, RANDOM, MANUAL, TABLE, DIESE, NOMFIC, CARACTERE, CHAINE, SUPPRAGENT, INF, SUP, EGAL, INFEG, SUPEG, DIFF, ET, OU, NON, VRAI, FAUX, MODIFAGENT, AFFECT, PLUS, MOINS, MULTI, DIVIS, EXPO, UNKNOW};
	
	//On crée la structure qui vas permettre de stocké un mot et le champ lexical associé
	struct Token { 
		KindToken kind;
		union {int the_int; float the_float; char the_char; char* the_string; bool the_bool;} Value;
	};
	int nblex = 0;
	Token lexemes[1000];
%}
digit [0-9]
lettre [a-zA-Z]
doubleQ "
simpleQ '
%%
	
	" "|\t|\n {;}//Espace, tabulation, retour à la ligne => ne rien faire
	"DEFAGENT" {
		lexemes[nblex].kind = DEFAGENT;
		nblex++;
	}
	"CREERAGENT" {
		lexemes[nblex].kind = CREERAGENT;
		nblex++;
	}
	"RANDOM" {
		lexemes[nblex].kind = RANDOM;
		nblex++;
	}
	"MANUAL" {
		lexemes[nblex].kind = MANUAL;
		nblex++;
	}
	"TABLE" {
		lexemes[nblex].kind = TABLE;
		nblex++;
	}
	"SUPPRAGENT" {
		lexemes[nblex].kind = SUPPRAGENT;
		nblex++;
	}
	"MODIFAGENT" {
		lexemes[nblex].kind = MODIFAGENT;
		nblex++;
	}
	"INT" {
		lexemes[nblex].kind = INT;
		nblex++;
	}
	"FLOAT" {
		lexemes[nblex].kind = FLOAT;
		nblex++;
	}
	"BOOLEAN" {
		lexemes[nblex].kind = BOOLEAN;
		nblex++;
	}
	"STRING" {
		lexemes[nblex].kind = STRING;
		nblex++;
	}
	"CHAR" {
		lexemes[nblex].kind = CHAR;
		nblex++;
	}
	[t|T][r|R][u|U][e|E] {
		lexemes[nblex].kind = VRAI;
		nblex++;
	}
	[f|F][a|A][l|L][s|S][e|E] {
		lexemes[nblex].kind = FAUX;
		nblex++;
	}
	//string
	/* probleme de gestion des doubles quote dans la string */
	{doubleQ}{.}*{doubleQ}  {
		lexemes[nblex].kind = CHAINE;
		int l = yylen + 1;
		char* copy = new char[l];
		strcpy(copy, yytext);
		lexemes[nblex].Value.the_string=copy;
		nblex++;
	}
	//char
	{simpleQ}{.}{simpleQ} {
		lexemes[nblex].kind = CARACTERE
		lexemes[nblex].Value.the_char = yytext;
		nblex++;
	}
	//non fichier
	/* comment dire tout les caractères sauf \ / : * ? " < > | */
	//entier
	{digit}+ {
		lexemes[nblex].kind = ENTIER;
		lexemes[nblex].Value.the_int = atoi(yytext);
		nblex++;
	}
	//reel
	/* regex a vérifier */ 
	{digit}+{\.{digit}+}? {
		lexemes[nblex].kind = REEL;
		lexemes[nblex].Value.the_float = atof(yytext);
		nblex++;
	}
	"(" { 
		lexemes[nblex].kind = PO;
		nblex++;
	}
	":" {
		lexemes[nblex].kind = DXPT;
		nblex++;
	}
	"," {
		lexemes[nblex].kind = VG;
		nblex++;
	}
	")" {
		lexemes[nblex].kind = PF;
		nblex++;
	}
	"#" {
		lexemes[nblex].kind = DIESE;
		nblex++;
	}
	"<" {
		lexemes[nblex].kind = INF;
		nblex++;
	}
	">" {
		lexemes[nblex].kind = SUP;
		nblex++;
	}
	"==" {
		lexemes[nblex].kind = EGAL;
		nblex++;
	}
	"<=" {
		lexemes[nblex].kind = INFEG;
		nblex++;
	}
	">=" {
		lexemes[nblex].kind = SUPEG;
		nblex++;
	}
	"!=" {
		lexemes[nblex].kind = DIFF;
		nblex++;
	}
	"&&" {
		lexemes[nblex].kind = ET;
		nblex++;
	}
	"||" {
		lexemes[nblex].kind = OU;
		nblex++;
	}
	"!" {
		lexemes[nblex].kind = NON;
		nblex++;
	}
	"=" {
		lexemes[nblex].kind = AFFECT;
		nblex++;
	}
	"+" {
		lexemes[nblex].kind = PLUS;
		nblex++;
	}
	"\-" {
		lexemes[nblex].kind = MOINS;
		nblex++;
	}
	"*" {
		lexemes[nblex].kind = MULTI;
		nblex++;
	}
	"\/" {
		lexemes[nblex].kind = DIVIS;
		nblex++;
	}
	"^" {
		lexemes[nblex].kind = EXPO;
		nblex++;
	}
	; {
		lexemes[nblex].kind = PV;
		nblex++;
	}
	. {
		lexemes[nblex].kind = UNKNOW;
		lexemes[nblex].Value.the_char = yytext;
		nblex++;
	}
%%

main(void)
{
	yylex();
	for (int i = 0; i < nblex; i++)
		switch(lexemes[i].kind){
			case CHAINE:
				printf("CHAINE %s\n",lexemes[i].Value.the_string);
				break;
			case ENTIER:
				printf("ENTIER %d\n",lexemes[i].Value.the_int);
				break;
			case REEL:
				printf("REEL %f\n",lexemes[i].Value.the_float);
				break;
			case CHAR:
				printf("CHAR %c\n",lexemes[i].Value.the_char);
				break;
			case STRING:
				printf("STRING\n");
				break;
			case INT:
				printf("INT\n");
				break;
			case FLOAT:
				printf("FLOAT\n");
				break;
			case BOOLEAN:
				printf("BOOLEAN\n");
			case VRAI:
				printf("VRAI\n");
				break;
			case FAUX:
				printf("FAUX\n");
				break;
			case PO:
				printf("PO\n");
				break;
			case IDF:
				printf("IDF\n");
				break;
			case PV:
				printf("PV\n");
				break;
			case DXPT:
				printf("DXPT\n");
				break;
			case VG:
				printf("VG\n");
				break;
			case PF:
				printf("PF\n");
				break;
			case DIESE:
				printf("DIESE\n");
				break;
			case INF:
				printf("INF\n");
				break;
			case SUP:
				printf("SUP\n");
				break;
			case EGAL:
				printf("EGAL\n");
				break;
			case INFEG:
				printf("INFEG\n");
				break;
			case SUPEG:
				printf("SUPEG\n");
				break;
			case DIFF:
				printf("DIFF\n");
				break;
			case ET:
				printf("ET\n");
				break;
			case OU:
				printf("OU\n");
				break;
			case NON:
				printf("NON\n");
				break;
			case AFFECT:
				printf("AFFECT\n");
				break;
			case PLUS:
				printf("PLUS\n");
				break;
			case MOINS:
				printf("MOINS\n");
				break;
			case MULTI:
				printf("MULTI\n");
				break;
			case DIVIS:
				printf("DIVIS\n");
				break;
			case EXPO:
				printf("EXPO\n");
				break;
			case DEFAGENT:
				printf("DEFAGENT\n");
				break;
			case CREERAGENT:
				printf("CREERAGENT\n");
				break;
			case RANDOM:
				printf("RANDOM\n");
				break;
			case MANUAL:
				printf("MANUAL\n");
				break;
			case TABLE:
				printf("TABLE\n");
				break;
			case NOMFIC:
				printf("NOMFIC\n");
				break;
			case CARACTERE:
				printf("CARACTERE\n");
				break;
			case SUPPRAGENT:
				printf("SUPPRAGENT\n");
				break;
			case MODIFAGENT:
				printf("MODIFAGENT\n");
				break;
			case UNKNOW:
				printf("Symbole non reconnu : %c",lexemes[i].Value.the_char);
		}
	return 0;
}