clc;
clear;
printf("=-------------------");
exec('fonctions_projet.sci',-1);
z = 1;
nbTirages = 15;
[VJ1(z), VJ2(z), PFJ1(z), PFJ2(z), NBMT(z), NBMnT(z), NBMxT(z), J1H(:,z), J2H(:,z)]  = LanceBataille(nbTirages, batailleComplexeAleat, SDRapide);

clc;
z = z+1;
printf("=======-------------");
[VJ1(z), VJ2(z), PFJ1(z), PFJ2(z), NBMT(z), NBMnT(z), NBMxT(z), J1H(:,z), J2H(:,z)] = LanceBataille(nbTirages, batailleComplexe, SDRapide);

clc;
z = z+1;
printf("===============-----");
[VJ1(z), VJ2(z), PFJ1(z), PFJ2(z), NBMT(z), NBMnT(z), NBMxT(z), J1H(:,z), J2H(:,z)] = LanceBataille(nbTirages, batailleSimple, SDRapide);
clc;
printf("====================");

[GUI] = makeGuiResults(VJ1, VJ2, PFJ1, PFJ2, NBMT, NBMnT, NBMxT);