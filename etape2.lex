%{
	#include <string.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <assert.h>
	
%}
digit [0-9]
lettre [a-zA-Z]
%%
[ \t\n] {;}	

DEFAGENT {
	printf("DEFAGENT\n");
}
CREERAGENT {
	printf("CREERAGENT\n");
}
RANDOM {
	printf("RANDOM\n");
}
MANUAL {
	printf("MANUAL\n");
}
TABLE {
	printf("TABLE\n");
}
SUPPRAGENT {
	printf("SUPPRAGENT\n");
}
MODIFAGENT {
	printf("MODIFAGENT\n");
}
INT {
	printf("INT\n");
}
FLOAT {
	printf("FLOAT\n");
}
BOOLEAN {
	printf("BOOLEAN\n");
}
STRING {
	printf("STRING\n");
}
CHAR {
	printf("CHAR\n");
}
[tT]&[rR]&[uU]&[eE] {
	printf("VRAI\n");
}
[fF]&[aA]&[lL]&[sS]&[eE] {
		printf("FAUX\n");
}
'"'[.]*'"' {
	printf("CHAINE %s\n",yytext);
}
"'"[.]"'" {
	printf("CHAR %s\n",yytext);
}
{digit}+ {
		printf("ENTIER %s\n",yytext);
	}
{digit}+[\.{digit}+]? {
	printf("REEL %s\n",yytext);
}
"(" { 
	printf("PO\n");
}
":" {
	printf("DXPT\n");
}
"," {
	printf("VG\n");
}
")" {
	printf("PF\n");
}
"#" {
	printf("DIESE\n");
}
"<" {
	printf("INF\n");
}
">" {
	printf("SUP\n");
}
"==" {
	printf("EGAL\n");
}
"<=" {
	printf("INFEG\n");
}
">=" {
	printf("SUPEG\n");
}
"!=" {
	printf("DIFF\n");
}
"&&" {
	printf("ET\n");
}
"||" {
	printf("OU\n");		
}
"!" {
	printf("NON\n");
}
"=" {
	printf("AFFECT\n");
}
"+" {
	printf("PLUS\n");
}
"\-" {
	printf("MOINS\n");
}
"*" {
	printf("MULTI\n");
}
"\/" {
	printf("DIVIS\n");
}
"^" {
	printf("EXPO\n");
}
; {
	printf("PV\n");
}
{lettre}({lettre}|{digit}_)*\.(({lettre}{lettre}{lettre})|({lettre}{lettre})|({lettre})) {
	printf("NOMFIC %s\n",yytext);
}
{lettre}({lettre}|{digit}|_)* {
	printf("IDF %s\n",yytext);
}
. {
	printf("Symbole non reconnu : (%s)\n",yytext);
}
%%

main(int argc, char *argv[])
{          
	if (argc > 1)
	{
		FILE *file;
		file = fopen(argv[1], "r");
		if (!file)
		{
			fprintf(stderr, "Could not open %s\n", argv[1]);
			exit(1);
		}
		yyin = file;
		yylex();
		printf("Analyse lexical terminée\n");
	}
	return 0;
}
