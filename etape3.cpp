#include <iostream>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

using namespace std;


enum classe_attribut {INT, FLOAT,STRING,CHAR,BOOL};

struct type_attribut {
	classe_attribut c_attribut;
	bool interval;
	float min;
	float max;
};

struct attribut {
	string nom_attribut;
	type_attribut type;
};

struct agent {
	string nom_agent;
	int nb_attribut;
	attribut attr[100];
};


agent liste_agent[1000];
int nbAgent=0;
bool insererTypeAgent(string nom);
bool verifierNomAgent(string nomAgent);
bool insererAttribut(string nom, classe_attribut type);
bool verifierNomAttribut(string nomAttribut);


bool insererTypeAgent(string nom) {
	if(verifierNomAgent(nom)) {
		liste_agent[nbAgent].nom_agent = nom;
		liste_agent[nbAgent].nb_attribut =0;
		nbAgent++;
		return true;
	}
	return false;
}

bool verifierNomAgent(string nomAgent){
	for (int i =0; i < nbAgent; i++) {
		if (nomAgent == liste_agent[i].nom_agent) {
			return false;
		}
	}
	return true;
}

bool insererAttribut(string nom, classe_attribut type){
       agent a = liste_agent[nbAgent];
       if(verifierNomAttribut(nom)){
             a.nb_attribut++;
             attribut at;
             at.nom_attribut = nom;
             at.type.c_attribut = type;
             a.attr[a.nb_attribut]=at;
             return true;
       }
       return false;
}

bool verifierNomAttribut(string nomAttribut){
       for(int i=0;i<liste_agent[nbAgent].nb_attribut;i++){
             if(nomAttribut==liste_agent[nbAgent].attr[i].nom_attribut){
                   return false;
             }
       }
       return true;
}

int main(int, char*[]) {

	printf("%d\n",insererAgent("conducteur"));
	printf("%d\n",insererAgent("lePelo"));
	printf("%d\n",insererAgent("conducteur"));
	printf("%d\n",insererAgent("idk"));
	
}
