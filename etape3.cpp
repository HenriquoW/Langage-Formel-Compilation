#include <iostream>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>

using namespace std;

/*
	Définition de la structure de définition des agents
*/
enum d_classe_attribut {INT, FLOAT, STRING, CHAR, BOOL};

struct d_type_attribut {
	d_classe_attribut c_attribut;
	bool interval;
	float min;
	float max;
};

struct d_attribut {
	string nom_attribut;
	d_type_attribut type;
};

struct d_type_agent {
	string nom_agent;
	int nb_attribut;
	d_attribut attr[100];
};

struct d_liste_type_agent {
	d_type_agent  l_agent[1000];
	int nb_agent=0;
};

d_liste_type_agent liste_type_agent;

/*
	Définition de la structure de stockage des agents
*/

struct a_attribut {
	string nom_attribut;
	union { int the_int, float the_float, string the_string, char the_char, bool the_bool};
	float min;
	float max;
};

struct a_agent {
	d_type_agent type_agent;
	a_attribut attribut[100];
};

struct a_liste_agent {
	a_agent liste[1000];
	int nb_agent = 0;
};

a_liste_agent liste_agent;
/*
	Fonction de gestion de la définition des agents
*/

bool insererTypeAgent(string nom);
bool verifierNomTypeAgent(string nomAgent);
bool insererAttribut(string nom, d_classe_attribut type);
bool verifierNomAttribut(string nomattribut);


bool insererTypeAgent(string nom) {
	if(verifierNomTypeAgent(nom)) {
		liste_type_agent.nb_agent++;
		liste_type_agent.l_agent[nb_agent].nom_agent = nom;
		liste_type_agent.l_agent[nb_agent].nb_attribut =0;
		return true;
	}
	return false;
}

bool verifierNomTypeAgent(string nomAgent){
	for (int i =0; i < liste_type_agent.nb_agent; i++) {
		if (nomAgent ==  liste_type_agent.l_agent[i].nom_agent) {
			return false;
		}
	}
	return true;
}

bool insererAttribut(string nom, d_classe_attribut type){
       d_agent a =  liste_type_agent.l_agent[liste_type_agent.nb_agent];
       if(verifierNomAttribut(nom)){
             a.nb_attribut++;
             d_attribut at;
             at.nom_attribut = nom;
             at.type.c_attribut = type;
             a.attr[a.nb_attribut]=at;
             return true;
       }
       return false;
}

bool verifierNomAttribut(string nomattribut){
       for(int i=0;i<liste_type_agent.l_agent[liste_type_agent.nb_agent].nb_attribut;i++){
             if(nomattribut==liste_type_agent.l_agent[liste_type_agent.nb_agent].attr[i].nom_attribut){
                   return false;
             }
       }
       return true;
}

/*
	Définition de la structure de stockage pour la creation,modification, suppression d'agent
*/
enum d_type_creation {RANDOM,MANUAL,TABLE};

struct s_modfication {
	string nom_attribut;
	int valeur;
};

struct s_liste_modfication {
	s_modfication liste_modfification[100];
};

struct s_valeur{
	union { int the_int, float the_float, string the_string, char the_char, bool the_bool};
}

struct s_manual{
	bool ensemble; //permet de savoir si on utilise le #
	s_valeur liste_val[100];
}

struct s_table{
	string nom_fichier;
}

struct s_donne{
	union { s_manual manual, s_table table};
}

struct s_critere{
	union { s_manual manual, s_table table};
}

/*
	Fonction de creation, modification, suppresion des agents
*/

int CreerAgent(d_type_agent typeA, int nb_agent, d_type_creation type_creation, s_donne donne = null){
	if(!verifierNomTypeAgent(typeA.nom_agent)){
		for(int i = 0 ;i<nb_agent;i++){
		
			a_agent newAgent;	
			newAgent.type_agent = typeA;
			
			switch(type_creation){
				case 0: // RANDOM
					newAgent.attribut = Random(typeA);
				break;
				
				case 1:	// MANUAL
					newAgent.attribut = Manual(typeA, donne.manual);
				break;
				
				case 2:	// TABLE
					newAgent.attribut = Table(typeA, donne.table);
				break;
			}
			liste_agent.nb_agent++;
			liste_agent.liste[liste_agent.nb_agent] = newAgent;
		}
		return 0;
	}else
		return 1;
}

a_attribut[100] Random(d_type_agent typeA){
	a_attribut liste[100];
	
	for(int i=0;i<typeA.nb_attribut;i++{
		d_attribut attribut = typeA.attr[i];
		
		a_attribut newAttribut;
		
		newAttribut.nom_attribut = attribut.nom_attribut;
		
		switch(attribut.type.c_attribut){
			case 0: // INT
				srand (time(NULL));
				if(attribut.type.interval){
					newAttribut.the_int = (int) (rand() % attribut.type.max + attribut.type.min);
				}else
					newAttribut.the_int = (int) (rand() % 100);
				
			break;
			
			case 1: // FLOAT
				srand (time(NULL));
				if(attribut.type.interval){
					
					newAttribut.the_float = ((attribut.type.max-attribut.type.min)*((float)rand()/RAND_MAX))+attribut.type.min;
				}else
					newAttribut.the_float = ((100.0)*((float)rand()/RAND_MAX));
			break;
			
			case 2: // STRING 
				srand (time(NULL)); 
				
				char* s;
				static const char alphanum[] =
					"0123456789"
					"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
					"abcdefghijklmnopqrstuvwxyz";

				for (int i = 0; i < 30; i++) {
					s[i] = alphanum[rand() % (sizeof(alphanum) - 1)];
				}

				s[30] = 0;
				newAttribut.the_string = str(s);
			break;
			
			case 3: // CHAR
				srand (time(NULL));
				
				int maj = rand() % 2;
				
				if(maj = 1){
					newAttribut.the_char = (char) (rand() % 90 + 65);
				}else
					newAttribut.the_char = (char) (rand() % 122 + 97);
				
			break;
			
			case 4: // BOOL
				srand (time(NULL));
			
				int val = rand() % 2;
				
				if(val = 1){
					newAttribut.the_bool = true;
				}else
					newAttribut.the_bool = false;
			break;
		
		}
		
		liste[i] = newAttribut;
	}
	
	return liste;
}

a_attribut[100] Manual(d_type_agent typeA, s_manual donne){
	
}

a_attribut[100] Table(d_type_agent typeA, s_table donne){
}


int ModifAgent(d_type_agent typeA, s_critere critere,s_liste_modification modifications){

} 

int SupprAgent(d_type_agent typeA, s_critere critere){

} 

int main(int, char*[]) {

	printf("%d\n",insererAgent("conducteur"));
	printf("%d\n",insererAgent("lePelo"));
	printf("%d\n",insererAgent("conducteur"));
	printf("%d\n",insererAgent("idk"));
	
}
