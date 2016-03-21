%{
// declaration
#include "etape3.h"
%}

%union{Agent * agent;int entier; float flottant; char* chaine; char caractere;bool booleen; char* nomFic}

%token <entier> INT;
%token <flottant> FLOAT;
%token <chaine> IDENTIFIER;
%token <caractere> CHAR;
%token <booleen> BOOLEAN;
%token <nomFic> NOMFIC;

%token PO;
%token PF;
%token VG;
%token PV;
%token DXPT;
%token DIESE;
%token INF;
%token SUP;
%token NON;
%token AFFECT;
%token PLUS;
%token MOINS;
%token MULTI;
%token DIVIS;
%token EXPO;
%token EGAL;
%token INEG;
%token SUPEG;
%token DIFF;
%token ET;
%token OU;


%%
%start lis

lis : |ins li;

ins : 
DEFAGENT PO IDENTIFIER PV latt PF PV 
| CREERAGENT PO nomType PV INT PV typeCreation PF
| SUPPRAGENT PO nomType PV critere PF
| MODIFAGENT PO nomType PV critere PV IDENTIFIER PF
{};


latt : att | att PV latt {};

att : IDENTIFIER DXPT nomtype {};

lval : val | val lval {}; /Exemple (2,56,82)(2,56,82)(2,56,82)  

val : PO INT VG INT VG INT PF {}; //Exemple (2,56,82) 

nomType :  INT {printf("INT !"); $$ = THE_INT;}
|FLOAT {printf("FLOAT !");

typeCreation : RANDOM
| MANUAL lval 
| MANUAL DIESE val 
| TABLE NOMFIC {};

critere : BOOLEAN {};

modifications : IDENTIFIER EGAL expression

expression : 
IDENTIFIER PLUS INT
|

$$=THE_FLOAT}
|STRING {$$ = THE_STRING}
|BOOLEAN {printf("BOOLEAN !"); $$ = THE_BOOLEAN}
|CHAR {printf("CHAR !"); $$=THE_CHAR;};

void yyerror(char *s) {
    fprintf(stderr, "line %d: %s\n", yylineno, s);
}

main()
{
	yyparse();
}