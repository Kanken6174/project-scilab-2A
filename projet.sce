clc;
clear;
exec('fonctions_projet.sci',-1);
rotationModesString = ["batailleComplexeAleat" "batailleComplexe" "batailleSimple"] //noms de nos batailles
z = 1
//__________________________________________________________________________ETUDE GENERALE
/*
nbTirages = 100;
    printf("\nEn cours: %s\n--------------------", rotationModesString(z));
    [VJ1(z), VJ2(z), PFJ1(z), PFJ2(z), NBMT(z), NBMnT(z), NBMxT(z), J1H(:,z), J2H(:,z)]  = LanceBataille(nbTirages, batailleComplexeAleat, SDRapide);
    z = z+1;
    printf("\nEn cours: %s\n--------------------", rotationModesString(z));
    [VJ1(z), VJ2(z), PFJ1(z), PFJ2(z), NBMT(z), NBMnT(z), NBMxT(z), J1H(:,z), J2H(:,z)]  = LanceBataille(nbTirages, batailleComplexe, SDRapide);
    z = z+1;
    printf("\nEn cours: %s\n--------------------", rotationModesString(z));
    [VJ1(z), VJ2(z), PFJ1(z), PFJ2(z), NBMT(z), NBMnT(z), NBMxT(z), J1H(:,z), J2H(:,z)]  = LanceBataille(nbTirages, batailleSimple, SDRapide);
    z = z+1;

    [GUI] = makeGuiResults(VJ1, VJ2, PFJ1, PFJ2, NBMT, NBMnT, NBMxT);
//__________________________________________________________________________ETUDE INJUSTE
nbTirages = 10;
    printf("\nEn cours: %s\n--------------------", rotationModesString(z));
    for i = 1:23
        disp(i)
        [VJ1(i), VJ2(i), PFJ1(i), PFJ2(i), NBMT(i), NBMnT(i), NBMxT(i), J1H(:,i), J2H(:,i)]  = LanceBataille(nbTirages, batailleComplexeAleat, SDInjuste, i);
        VJ1(i) = mean(VJ1(i))/nbTirages;
        VJ2(i) = mean(VJ2(i))/nbTirages;
    end
    plot([VJ1 VJ2]);
    figure();
    for i = 1:23
        [VJ1(i), VJ2(i), PFJ1(i), PFJ2(i), NBMT(i), NBMnT(i), NBMxT(i), J1H(:,i), J2H(:,i)]  = LanceBataille(nbTirages, batailleComplexe, SDInjuste, i);
        VJ1(i) = mean(VJ1(i))/nbTirages;
        VJ2(i) = mean(VJ2(i))/nbTirages;
    end
    plot([VJ1 VJ2]);
    figure();
    for i = 1:23
        [VJ1(i), VJ2(i), PFJ1(i), PFJ2(i), NBMT(i), NBMnT(i), NBMxT(i), J1H(:,i), J2H(:,i)]  = LanceBataille(nbTirages, batailleSimple, SDInjuste, i);
        VJ1(i) = mean(VJ1(i))/nbTirages;
        VJ2(i) = mean(VJ2(i))/nbTirages;
    end
    plot([VJ1 VJ2]);

*/
//__________________________________________________________________________ETUDE CALCULATOIRE
nbEssais = 200
nbCartes = nbEssais * 26;   //Par joueur, donc *26 et pas *52
proba1Carte = 1/13;
for i = 1:nbEssais
    [jeu1(i,:),jeu2(i,:)]=distribution(SDRapide);
end
jeu1 = tabul(jeu1);
Carte = [" " "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13"];
nbTire = [string(jeu1(:,2))];

nbTire = flipdim(nbTire,1); //il faut retourner sinon le tableau sera inversé à l'affichage

disp(length(nbTire));
legende = ["nb Cartes"]';

table = [Carte ; [ legende nbTire(1) nbTire(2) nbTire(3) nbTire(4) nbTire(5) nbTire(6) nbTire(7) nbTire(8) nbTire(9) nbTire(10) nbTire(11) nbTire(12) nbTire(13)]];//scilab refuse nbTire seul...

GUI = figure('position', [200, 200, 750, 460]);
GUI = gcf();
as = get(GUI, "axes_size");
disp("prob ici");

ut = uicontrol(GUI, "style", "table",..
                "string", table,..
                "position", [50 (as(2) - 200) 750 40],..
                "tooltipstring", "Données des tirages de carte J1");

esperance = nbCartes * proba1Carte;
variance = root(nbCartes*proba1Carte*(1-proba1Carte));

Mean = 0;
Std = 1;
x = -6:6;
[P,Q]=cdfnor("PQ",x,Mean*ones(x),Std*ones(x));
[x' P' Q']