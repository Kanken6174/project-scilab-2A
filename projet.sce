clc;
clear;

pgID = progressionbar('Initialisation de l''application...');
exec('fonctions_projet.sci',-1);

rotationModesString = ["batailleComplexeAleat" "batailleComplexe" "batailleSimple"] //noms de nos batailles
z = 1

[GUI] = makeGUIInit();
close(pgID);


//__________________________________________________________________________ETUDE GENERALE
nbTirages = 2000;
    [myBar] = makeLoadingbar(rotationModesString(z), z/10);
    [VJ1(z), VJ2(z), PFJ1(z), PFJ2(z), NBMT(z), NBMnT(z), NBMxT(z), J1H(:,z), J2H(:,z)]  = LanceBataille(nbTirages, batailleComplexeAleat, SDRapide);
    z = z+1;
    
    updateBar(myBar, z/10, rotationModesString(z));
    [VJ1(z), VJ2(z), PFJ1(z), PFJ2(z), NBMT(z), NBMnT(z), NBMxT(z), J1H(:,z), J2H(:,z)]  = LanceBataille(nbTirages, batailleComplexe, SDRapide);
    z = z+1;
    
    updateBar(myBar, z/10, rotationModesString(z));
    [VJ1(z), VJ2(z), PFJ1(z), PFJ2(z), NBMT(z), NBMnT(z), NBMxT(z), J1H(:,z), J2H(:,z)]  = LanceBataille(nbTirages, batailleSimple, SDRapide);
    z = z+1;
    donnees = [[nbTirages nbTirages nbTirages]', VJ1, VJ2, PFJ1, PFJ2, NBMT, NBMnT, NBMxT];
    legendesHaut = ["Type de bataille" "nb Tirages" "Victoires J1" "Victoires J2" "Parties Fav. J1" "Parties Fav. J2" "Nb Moyen tours" "Nb min tours" "Nb max tours"];
    typesBatailles = ["cmplx RA" "cmplx RS" "simplifiée"]';
    Xpos = 300; //position depuis la droite de la fenêtre
    Ypos = 400; //position depuis le bas de la fenêtre
    tooltip = "table des données de l''étude générale";
    makeGuiTable(GUI, typesBatailles, legendesHaut, donnees, Xpos, Ypos, tooltip);


//__________________________________________________________________________ETUDE INJUSTE
nbTirages = 10;
for i = 1:23
    updateBar(myBar, (i/230)+0.4, "Etude Injuste : batailleComplexeAleat, indice injuste " + string(i));
    [VJ1(i), VJ2(i)]  = LanceBatailleLite(nbTirages, batailleComplexeAleat, SDInjuste, i);
    VJ1(i) = mean(VJ1(i))
    VJ2(i) = mean(VJ2(i))
end
VJ1 = VJ1/nbTirages;
VJ2 = VJ2/nbTirages;
    subplot(4,4,1);
    plot([VJ1 VJ2]);

updateBar(myBar, 0.5, "Etude Injuste : batailleComplexe, indice injuste : 1-23");
    for i = 1:23
        disp("---------------",timer());
        [VJ1(i), VJ2(i), PFJ1(i), PFJ2(i), NBMT(i), NBMnT(i), NBMxT(i), J1H(:,i), J2H(:,i)]  = LanceBataille(nbTirages, batailleComplexe, SDInjuste, i);
        disp(timer());
        VJ1(i) = mean(VJ1(i))/nbTirages;
        VJ2(i) = mean(VJ2(i))/nbTirages;
    end

    subplot(4,4,2);
    plot([VJ1 VJ2]);

updateBar(myBar, 0.5, "Etude Injuste : batailleSimple, indice injuste : 1-23");
    for i = 1:23
        [VJ1(i), VJ2(i), PFJ1(i), PFJ2(i), NBMT(i), NBMnT(i), NBMxT(i), J1H(:,i), J2H(:,i)]  = LanceBataille(nbTirages, batailleSimple, SDInjuste, i);
        VJ1(i) = mean(VJ1(i))/nbTirages;
        VJ2(i) = mean(VJ2(i))/nbTirages;
    end
    subplot(4,4,3);
    plot([VJ1 VJ2]);
/*

//__________________________________________________________________________ETUDE CALCULATOIRE - fonction de distribution
/*
nbEssais = 10
nbCartes = nbEssais * 26;   //Par joueur, donc *26 et pas *52
proba1Carte = 1/13;
for i = 1:nbEssais
    [jeu1(i,:),jeu2(i,:)]=distribution(SDRapide);
end
jeu1 = tabul(jeu1);
Carte = [" " string([1:13])];
nbTire = [string(jeu1(:,2))];

nbTire = flipdim(nbTire,1); //il faut retourner sinon le tableau sera inversé à l'affichage [inversion du tableau]

Xpos = 500;
Ypos = 300;
donnees = nbTire;
legendeGauche = ["nb Cartes"]';
legendesHaut = Carte;
tooltip = "Données des tirages de carte J1";

makeGuiTable(GUI, legendeGauche, legendesHaut, donnees, Xpos, Ypos, tooltip);

/*
esperance = nbCartes * proba1Carte;
variance = root(nbCartes*proba1Carte*(1-proba1Carte));

p = binomial(proba1Carte, nbCartes);
p = p(1:600);
plot(p);
pc = cumsum(p);
plot(pc,"r");
*/
*/
//------------------------------------------------------------------ETUDE CALCULATOIRE - 
close(myBar);
*/