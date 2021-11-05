clc
/*exec('fonctions_projet.sci',-1);
printf("\n\tEtude statistique du jeu de bataille standard, 52 cartes réparties aléatoirement (26/26)\n");
nbTirages = 1000;
LanceBataille(nbTirages, batailleComplexeAleat, SDRapide);
clear;

exec('fonctions_projet.sci',-1);
printf("\nVersion sans remise aléatoire:\n");
nbTirages = 1000;
LanceBataille(nbTirages, batailleComplexe, SDRapide);
clear;*/

exec('fonctions_projet.sci',-1);
printf("\nVersion simplifiée:\n");
nbTirages = 1;
LanceBataille(nbTirages, batailleSimple, SDRapide);