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
