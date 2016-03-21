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
%token DEFAGENT;
%token CREERAGENT;
%token SUPPRAGENT;
%token MODIFAGENT;
%token STRING;
%token MANUAL
%token RANDOM
%token TABLE

%left PLUS MOINS 
%left FOIS DIVISE 
%right EXPO


%%
%start Input;

Input : 

| ins {};

nomType :  
INT {printf("INT !"); $$ = THE_INT;}
|FLOAT {printf("FLOAT !")};

typeAtt :
|STRING
|INT
|FLOAT
|BOOLEAN
|CHAR
|INT PO INT VG INT PF
|FLOAT PO FLOAT VG FLOAT PF {};

latt : att | att PV latt {};

att : IDENTIFIER DXPT typeAtt {};

lval : val | val lval {}; //Exemple (2,56,82)(2,56,82)(2,56,82)  

val : PO INT VG INT VG INT PF {}; //Exemple (2,56,82) 

typeCreation : RANDOM
| MANUAL lval 
| MANUAL DIESE val 
| TABLE NOMFIC {};

critere : BOOLEAN {};

modifications : IDENTIFIER EGAL expr

expr :
INT {$$ = $1;}
|IDENTIFIER {$$ = $1;}
|expr PLUS expr		{$$ = $1 + $3;}
|expr MOINS expr 	{$$ = $1 - $3;}
|expr MULTI expr 	{$$ = $1 * $2;}
|expr DIVIS expr 	{$$ = $1 / $2;}
|expr EXPO expr 	{$$ = $1 ^ $2;}
|PO expr PF 		{$$ =  $2 ;}

ins : 
DEFAGENT PO IDENTIFIER PV latt PF PV 
| CREERAGENT PO nomType PV INT PV typeCreation PF
| SUPPRAGENT PO nomType PV critere PF
| MODIFAGENT PO nomType PV critere PV IDENTIFIER PF
{};

/*$$=THE_FLOAT}
|STRING {$$ = THE_STRING}
|BOOLEAN {printf("BOOLEAN !"); $$ = THE_BOOLEAN}
|CHAR {printf("CHAR !"); $$=THE_CHAR;};
*/
%%

void yyerror(char *s) {
    fprintf(stderr, "line %d: %s\n", yylineno, s);
}

main()
{
	yyparse();
}