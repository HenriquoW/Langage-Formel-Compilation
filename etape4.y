%{
// declaratio
//%union{int entier; float flottant; char* chaine; char caractere;bool booleen; char* nomFic;};

%}

%token  INT VRAI FAUX IDF CHAINE CARACTERE REEL ENTIER
%token FLOAT
%token IDENTIFIER
%token  CHAR
%token  BOOLEAN
%token  NOMFIC
%token PO
%token PF
%token VG
%token PV
%token DXPT
%token DIESE
%token INF
%token SUP
%token NON
%token AFFECT
%token PLUS
%token MOINS
%token MULTI
%token DIVIS
%token EXPO
%token EGAL
%token INEG
%token SUPEG
%token DIFF
%token ET
%token DEFAGENT
%token CREERAGENT
%token SUPPRAGENT
%token MODIFAGENT
%token STRING
%token MANUAL
%token RANDOM
%token OU
%token TABLE

%left PLUS MOINS 
%left FOIS DIVISE 
%right EXPO


%%
%start Input;

Input : 

| ins 
| lins {};

lins :
ins ins
| lins ins {};


typeAtt :
STRING
|INT
|FLOAT
|BOOLEAN
|CHAR
|INT PO INT VG INT PF
|FLOAT PO FLOAT VG FLOAT PF {};

latt : att | att PV latt {};

att : IDENTIFIER DXPT typeAtt {};

lval : val | val lval {/*Exemple (2,56,82)(2,56,82)(2,56,82)*/};   

val : PO INT VG INT VG INT PF {/*Exemple (2,56,82)*/};  

typeCreation : RANDOM
| MANUAL lval 
| MANUAL DIESE val 
| TABLE NOMFIC {};

critere : BOOLEAN {};

lmodif :
modifications
|modifications PV lmodif
{};

modifications : IDENTIFIER EGAL expr1 {};

expr1 :
expr1 PLUS expr2		
|expr1 MOINS expr2 
|expr2	
{};	

expr2 :
expr2 MULTI expr3 	
|expr2 DIVIS expr3 
|expr3
{};

expr3 :
expr3 EXPO expr4
|expr4	 	
{};

expr4 :
PO expr1 PF
|IDENTIFIER
|INT
|FLOAT	 
{};


ins : 
DEFAGENT PO IDENTIFIER PV latt PF PV 
| CREERAGENT PO IDENTIFIER PV INT PV typeCreation PF
| SUPPRAGENT PO IDENTIFIER PV critere PF
| MODIFAGENT PO IDENTIFIER PV critere PV lmodif PF
{};


%%
#include "lex.yy.c"
/*int yyerror() {
    printf("line : %s\n", yytext);
	return 0;
}*/

