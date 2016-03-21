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

/*
%%
%start lis
lis : |ins li;
ins : DEFAGENT IDF '(' latt ')' {Gnbagent++; printf("agent %s défini\n", $2);};
latt : att | att ';' latt {};
att : IDF ':' nomtype {Gnbattrt++; table[nbagent].nbattr = Gnbattr; printf("le champ a pour nom : %s", $1); printf("Le type est \n", $3);};
nomtype : INT {printf("INT !"); $$ = THE_INT;}|FLOAT {printf("FLOAT !"); $$=THE_FLOAT}|STRING {$$ = THE_STRING};
*/

%%
%start lis
lis : |ins li;
ins : DEFAGENT PO IDENTIFIER PV latt PF PV {};
latt : att | att PV latt {};
att : IDENTIFIER DXPT nomtype {};
nomtype :  INT {printf("INT !"); $$ = THE_INT;}|FLOAT {printf("FLOAT !"); $$=THE_FLOAT}|STRING {$$ = THE_STRING}|BOOLEAN {printf("BOOLEAN !"); $$ = THE_BOOLEAN}|CHAR {printf("CHAR !"); $$=THE_CHAR;};
