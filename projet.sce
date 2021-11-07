xdel(winsid()); //fermer les fenêtres inutilsiées
clc;    //effacer la console
clear;  //effacer la mémoire

confiance = 2,88 //On choisit l'intervalle de confiance 2,88 pour 98% de confiance.

pgID = progressionbar('Initialisation de l''application...');
exec('fonctions_projet.sci',-1);

rotationModesString = ["batailleComplexeAleat" "batailleComplexe" "batailleSimple"] //noms de nos batailles
z = 1

[GUI] = makeGUIInit();
close(pgID);


//__________________________________________________________________________ETUDE GENERALE
nbTirages = 1000;
    [myBar] = makeLoadingbar(rotationModesString(z), 0.1);

    [VJ1(z), VJ2(z), PFJ1(z), PFJ2(z), NBMT(z), NBMnT(z), NBMxT(z), J1H(:,z), J2H(:,z), TH]  = LanceBataille(nbTirages, batailleComplexeAleat, SDRapide);
    z = z+1;


    updateBar(myBar, z/10, rotationModesString(z));
    [VJ1(z), VJ2(z), PFJ1(z), PFJ2(z), NBMT(z), NBMnT(z), NBMxT(z), J1H(:,z), J2H(:,z), TH(:,z)]  = LanceBataille(nbTirages, batailleComplexe, SDRapide);
    z = z+1;
    
    updateBar(myBar, z/10, rotationModesString(z));
    [VJ1(z), VJ2(z), PFJ1(z), PFJ2(z), NBMT(z), NBMnT(z), NBMxT(z), J1H(:,z), J2H(:,z), TH(:,z)]  = LanceBataille(nbTirages, batailleSimple, SDRapide);
    z = z+1;

    donnees = [[nbTirages nbTirages nbTirages]', VJ1, VJ2, PFJ1, PFJ2, NBMT, NBMnT, NBMxT];
    legendesHaut = ["Type de bataille" "nb Tirages" "Victoires J1" "Victoires J2" "Parties Fav. J1" "Parties Fav. J2" "Nb Moyen tours" "Nb min tours" "Nb max tours"];
    typesBatailles = ["cmplx RA" "cmplx RS" "simplifiée"]';
    Xpos = 400; //position depuis la droite de la fenêtre
    Ypos = 400; //position depuis le bas de la fenêtre
    tooltip = "table des données de l''étude générale";
    sizefactor = 75;
    makeGuiTable(GUI, typesBatailles, legendesHaut, donnees, Xpos, Ypos, tooltip, sizefactor);


//__________________________________________________________________________ETUDE INJUSTE
nbTirages = 100;
for i = 1:23
    updateBar(myBar, (i/230)+0.4, "Etude Injuste : batailleComplexeAleat, indice injuste " + string(i));
    [VJ1(i), VJ2(i), ignoreA, ignoreB, ignoreC, ignoreD, ignoreE, ignoreD, ignoreF, ignoreG]  = LanceBataille(nbTirages, batailleComplexeAleat, SDInjuste, i);
    VJ1(i) = mean(VJ1(i))/nbTirages;
    VJ2(i) = mean(VJ2(i))/nbTirages;
end

subplot(4,4,1);
title('Etude injuste : batailleComplexeAleat','position',[1 1]);
plot([VJ1 VJ2]);


for i = 1:23
    updateBar(myBar, (i/230)+0.5, "Etude Injuste : batailleComplexe, indice injuste " + string(i));
    [VJ1(i), VJ2(i), ignoreA, ignoreB, ignoreC, ignoreD, ignoreE, ignoreD, ignoreF, ignoreG]  = LanceBataille(nbTirages, batailleComplexe, SDInjuste, i);
    VJ1(i) = mean(VJ1(i))/nbTirages;
    VJ2(i) = mean(VJ2(i))/nbTirages;
end

subplot(4,4,2);
title('Etude injuste : batailleComplexe','position',[1 1]);
plot([VJ1 VJ2]);


for i = 1:23
    updateBar(myBar, (i/230)+0.6, "Etude Injuste : batailleSimple, indice injuste " + string(i));
    [VJ1(i), VJ2(i), ignoreA, ignoreB, ignoreC, ignoreD, ignoreE, ignoreD, ignoreF, ignoreG]  = LanceBataille(nbTirages, batailleSimple, SDInjuste, i);
    VJ1(i) = mean(VJ1(i))/nbTirages;
    VJ2(i) = mean(VJ2(i))/nbTirages;
end

subplot(4,4,3);
title('Etude injuste : batailleSimplifiée','position',[1 1]);
plot([VJ1 VJ2]);



//__________________________________________________________________________ETUDE CALCULATOIRE - fonction de distribution

nbEssais = 200
nbCartes = nbEssais * 26;   //Par joueur, donc *26 et pas *52
proba1Carte = 1/13;
for i = 1:nbEssais
    updateBar(myBar, (i/(nbEssais*10))+0.7, "Etude distribution : batailleSimple, indice injuste " + string(i));
    [jeu1(i,:),jeu2(i,:)]=distribution(SDRapide);
end

jeu1 = tabul(jeu1);
Carte = [string([0:13])];
nbTire = [string(jeu1(:,2))];

nbTire = flipdim(nbTire,1); //il faut retourner sinon le tableau sera inversé à l'affichage [inversion du tableau]

Xpos = 500;
Ypos = 300;
donnees = [nbTire]';
legendeGauche = ["nb Cartes"]';
legendesHaut = Carte;
tooltip = "Données des tirages de carte J1";
sizefactor = 35;
makeGuiTable(GUI, legendeGauche, legendesHaut, donnees, Xpos, Ypos, tooltip, sizefactor);

esperance = nbCartes * proba1Carte;
temp = nbCartes*proba1Carte*(1-proba1Carte);
variance = sqrt(temp);
factD = variance*confiance

p = binomial(proba1Carte, nbCartes);
p = p(1:$/2);

subplot(4,4,5);
title('Etude Calculatoire: répartition de probabilités','position',[1 1]);
plot(p);
pc = cumsum(p);
subplot(4,4,8);
title('Etude Calculatoire: somme cumulée','position',[1 1]);
plot(pc,"r");


Xpos = 500;
Ypos = 250;
donnees = [esperance variance factD];
legendeGauche = ["valeurs"]';
legendesHaut = [" " "esperance" "variance" "d"];
tooltip = "Données des tirages de carte J1";
sizefactor = 65;
makeGuiTable(GUI, legendeGauche, legendesHaut, donnees, Xpos, Ypos, tooltip, sizefactor);

//------------------------------------------------------------------ETUDE CALCULATOIRE - 

close(myBar);