#include <iostream>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

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

struct d_liste_agent {
	d_type_agent  l_agent[1000];
	int nb_agent=0;
};

d_liste_agent liste_type_agent;

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
	string type_agent;
	string nom_agent;
	a_attribut attribut[100];
};

struct a_liste_agent {
	a_agent liste[1000];
};

a_liste_agent liste_agent;
/*
	Fonction de gestion de la définition des agents
*/

bool insererTypeAgent(string nom);
bool verifierNomAgent(string nomAgent);
bool insererAttribut(string nom, d_classe_attribut type);
bool verifierNomAttribut(string nomattribut);


bool insererTypeAgent(string nom) {
	if(verifierNomAgent(nom)) {
		liste_type_agent.l_agent[nb_agent].nom_agent = nom;
		liste_type_agent.l_agent[nb_agent].nb_attribut =0;
		liste_type_agent.nb_agent++;
		return true;
	}
	return false;
}

bool verifierNomAgent(string nomAgent){
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
