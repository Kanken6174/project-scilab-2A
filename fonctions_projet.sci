clear;

//------------------------------------------ RANDOMISATION DU DECK (LENT)
function cards=SDLent(cardPile, nbCartes)
d = 1
while(d <= nbCartes)
    ran = grand(1,1,"uin",1,52);
    oldCard = (cardPile(d));
    cardPile(d) = cardPile(ran,1);
    cardPile(ran,1) = oldCard;
d = d+1;
end
cards = cardPile;
endfunction

//------------------------------------------ RANDOMISATION DU DECK (RAPIDE)
function cards=SDRapide(cardPile, nbCartes)
    cards = samwr(nbCartes,1,cardPile);   //on utilise le tirage aléatoire sans remise pour cette fonction
endfunction


//----------------------------------------- RANDOMISATION DU DECK (INJUSTE J1)
function cards=SDInjuste(cardPile, nbCartes)
    cards = gsort(cardPile);    //J1 aura toues les grandes cartes, pas de hasard
endfunction

//------------------------------------------ DISTRIBUION
function [jeu1,jeu2]=distribution(méthodeDistribution)
cardPile = 1:13;
cardPile = repmat(cardPile,4,1);    //on répète le contenu du tableay cardPile 4 fois (4x13 = 42)

cardPile = méthodeDistribution(cardPile, 52); //trie le tas de cartes (deck) selon la méthode de choix

jeu1 = cardPile(1:26);  //on sépare les cartes en 2 tas de 26 cartes
jeu2 = cardPile(27:52);
endfunction
//------------------------------------------ BATAILLE SIMPLIFEE

function [gagnantJ1, tour] = batailleSimple(jeu1,jeu2)
gagnantJ1 = 0;
tour  = 0;
graphJ1 = 0;
graphJ2 = 0;
nbBataille = 0;
nbBatailleGJ1 = 0;
nbBatailleGJ2 = 0;

while(length(jeu1) > 0 && length(jeu2) > 0)
    tour = tour + 1;
    graphJ1($+1) = jeu1(1);
    graphJ2($+1) = jeu2(1);

    if(length(jeu1) + length(jeu2) ~= 52) then
        printf("\n ERREUR PAS 52: %d\n", length(jeu1) + length(jeu2));
    end

    if(jeu1(1) > jeu2(1)) then  //la première carte du joueur 1 est meilleure
        jeu1($+1) = jeu1(1);    //Le joueur 1 récupère les 2 cartes
        jeu1($+1) = jeu2(1);
    elseif(jeu1(1) < jeu2(1)) then //la première carte du joueur 2 est meilleure
        jeu2($+1) = jeu2(1);    //Le joueur 2 récupère les 2 cartes
        jeu2($+1) = jeu1(1);
    else                        //égalité - bataille
        nbBataille = nbBataille +1;
        winner = rand();
        if(winner >= 0.5) then
            jeu1($+1) = jeu1(1);    //Le joueur 1 récupère les 2 cartes
            jeu1($+1) = jeu2(1);
            nbBatailleGJ1 = nbBatailleGJ1 +1;
        else
            jeu1($+1) = jeu1(1);    //Le joueur 2 récupère les 2 cartes
            jeu2($+1) = jeu1(1);
            nbBatailleGJ2 = nbBatailleGJ2 +1;
        end
    end
    jeu1 = jeu1(2:$);
    jeu2 = jeu2(2:$);
end

gagnantJ1 = (length(jeu1) > length(jeu2));
endfunction
//-----------------------------------------------------------BATAILLE COMPLEXE
function [gagnantJ1, tour] = batailleComplexe(jeu1,jeu2)
tour = 0;
gagnantJ1 = 0;
batailleDeck = [];

while(length(jeu1) > 0 && length(jeu2) > 0) // tant que les joueurs ont assez de cartes
    tour = tour + 1;    //on incrémente le tour
    if(jeu1(1) > jeu2(1)) then  //la première carte du joueur 1 est meilleure
        if(~isempty(batailleDeck)) then //Il y a déjà eu une bataille au dernier tour, deckbataille non vide
            jeu1 = [jeu1;batailleDeck];
            batailleDeck = [];
        end
            jeu1 = [jeu1(1:$);jeu1(1);jeu2(1)];    //Le joueur 1 récupère les 2 cartes

    elseif(jeu1(1) < jeu2(1)) then //la première carte du joueur 2 est meilleure
        if(~isempty(batailleDeck)) then //Il y a déjà eu une bataille au dernier tour, deckbataille non vide
            jeu2 = [jeu2;batailleDeck];
            batailleDeck = [];
        end
            jeu2 = [jeu2(1:$);jeu2(1);jeu1(1)]; //Le joueur 2 récupère les 2 cartes

    
    elseif(jeu1(1) == jeu2(1))//égalité ---- bataille
            if(length(jeu1) < 6 || length(jeu2) < 6) then
                gagnantJ1 = length(jeu1) > length(jeu2) ;//gagne au nb de cartes
                return;
            end
            if(isempty(batailleDeck)) then
                batailleDeck(1:4) = [jeu1(1:2);jeu2(1:2)]; //on initialise le deck de bataille
            else
                batailleDeck = [batailleDeck;jeu1(1:2);jeu2(1:2)]; //on ajoute les 4 cartes au deck de la bataille
            end
    else
        return; //cas impossible
    end

    if(~isempty(batailleDeck) && length(jeu1) > 3 && length(jeu2) > 3) then //bataille en cours
        jeu1 = jeu1(3:$);//on récupère tout sauf les 4 cartes mises en bataille
        jeu2 = jeu2(3:$);//-/^^^
     else   //jeu normal
        jeu1 = jeu1(2:$);//on récupère tout sauf les 2 cartes traitée
        jeu2 = jeu2(2:$);
    end
end
gagnantJ1 = (length(jeu1) > length(jeu2));
err = 0;
endfunction

//----------------------------------------------------------BATAILLE COMPLEXE AVEC REMISE ALEATOIRE
function [gagnantJ1, tour] = batailleComplexeAleat(jeu1,jeu2)
    tour = 0;
    gagnantJ1 = 0;
    batailleDeck = [];
    
    while(length(jeu1) > 0 && length(jeu2) > 0) // tant que les joueurs ont assez de cartes
        tour = tour + 1;    //on incrémente le tour
        if(jeu1(1) > jeu2(1)) then  //la première carte du joueur 1 est meilleure
            if(~isempty(batailleDeck)) then //Il y a déjà eu une bataille au dernier tour, deckbataille non vide
                batailleDeck = SDRapide(batailleDeck, length(batailleDeck));
                jeu1 = [jeu1;batailleDeck];
                batailleDeck = [];
            end
                jeu1 = [jeu1(1:$);jeu1(1);jeu2(1)];    //Le joueur 1 récupère les 2 cartes
    
        elseif(jeu1(1) < jeu2(1)) then //la première carte du joueur 2 est meilleure
            if(~isempty(batailleDeck)) then //Il y a déjà eu une bataille au dernier tour, deckbataille non vide
                batailleDeck = SDRapide(batailleDeck, length(batailleDeck));
                jeu2 = [jeu2;batailleDeck];
                batailleDeck = [];
            end
                jeu2 = [jeu2(1:$);jeu2(1);jeu1(1)]; //Le joueur 2 récupère les 2 cartes

        
        elseif(jeu1(1) == jeu2(1))//égalité ---- bataille
                if(length(jeu1) < 6 || length(jeu2) < 6) then
                    gagnantJ1 = length(jeu1) > length(jeu2) ;//gagne au nb de cartes
                    return;
                end
                if(isempty(batailleDeck)) then
                    batailleDeck(1:4) = [jeu1(1:2);jeu2(1:2)]; //on initialise le deck de bataille
                else
                    batailleDeck = [batailleDeck;jeu1(1:2);jeu2(1:2)]; //on ajoute les 4 cartes au deck de la bataille
                end
        else
            printf("\nErreur majeure\n");
            return; //cas impossible
        end
    
        if(~isempty(batailleDeck) && length(jeu1) > 3 && length(jeu2) > 3) then //bataille en cours
            jeu1 = jeu1(3:$);//on récupère tout sauf les 4 cartes mises en bataille
            jeu2 = jeu2(3:$);//-/^^^
         else   //jeu normal
            jeu1 = jeu1(2:$);//on récupère tout sauf les 2 cartes traitée
            jeu2 = jeu2(2:$);
        end
    end
    gagnantJ1 = (length(jeu1) > length(jeu2));
    err = 0;
    endfunction
//----------------------------------------------------------ETUDE_STATISTIQUE
function [gagnant] = etudeDeForce(jeu1, jeu2)
    gagnant = (sum(jeu1) - sum(jeu2)) > 0;
endfunction
//1) Durée moyenne d'une partie

//----------------------------------------------------------TESTS
function [] = LanceBataille(nbParties, typeBataille, typeDistribution)
    resultat = 0;   //1 si J1 a gagné, 0 si J2 a gagné
    nbTours = 0;
    moyTours = 0;
    maxTours = 0;
    minTours = 999999;
    jeu1Historique = zeros(nbParties*26);   //on pré-initialise les vecteurs d'historique pour optimiser les actions type cat
    jeu2Historique = zeros(nbParties*26);
    i = 1;
    ForceJeu = 0;
    tJeuTot = 0;
    tJeuNb = nbParties;


    while i <= nbParties
        tickIndex = (i*26);
        tJeuTot = timer()+tJeuTot;
        [jeu1,jeu2] = distribution(typeDistribution);  //distribution des cartes, qui va utiliser le type de distribution passé en argument
        ForceJeu(i) = etudeDeForce(jeu1, jeu2);

        for(c = tickIndex+1:tickIndex+26)   //une action type cat (optimisé), on rècupère l'historique de chaque tirage (les cartes au début)
            jeu1Historique(c) = jeu1(c-tickIndex);
            jeu2Historique(c) = jeu2(c-tickIndex);
        end;

        [J1gagnant, nbTours(i)] = typeBataille(jeu1,jeu2);  //execution du jeu bataille
        resultat(i) = J1gagnant;

        if(nbTours(i) > maxTours)
            maxTours = nbTours(i);
        end

        if(nbTours(i) < minTours)
            minTours = nbTours(i);
        end

        moyTours = moyTours + nbTours(i);//on ajoute le nombre total de tours pour ce tirage au nb total pour tous
        i = i +1;   //incrémentation du nb de batailles effectuées
    end
    
    printf("\nTemps d execution total : %f",tJeuTot);
    printf("\nTemps d execution moyen : %f",tJeuTot/tJeuNb);

    moyTours = moyTours/nbParties;
    resultat = tabul(resultat);
    ForceJeu = tabul(ForceJeu);
    FJ1 = ForceJeu(1,2);
    FJ2 = ForceJeu(2,2);
    disp(resultat);
    disp(length(resultat));
    disp(resultat(1));
    if(length(resultat) ~= 4) then  //J1 ou J2 n'a eu aucune victoire, le tableau sera incomplet et cela causera une erreur d'indice
      if(resultat(1) == 1) then
        resultat(2,1) = 2;  //on complète la 2 ème ligne
        resultat(2,2) = 0;  // 2. 0
      else
        temp = resultat(1,2);   //on va compléter la 1ère ligne, on récupère la valeur de la future deuxième ligne car elle n'est pas au bon endroit
        resultat(1,1) = 1;
        resultat(1,2) = 0;      //tableau reconstruit sous le modèle:
        resultat(2,1) = 2;      //1. 0
        resultat(2,2) = temp;   //2. temp
      end
    end
    disp(resultat);
    printf("\n\tJ1 a gagné %d fois\n\tJ2 a gagné %d fois\n",resultat(1,2), resultat(2,2));
    printf("\n\t Les parties favorables à J1 étaient de %d\n\t et les parties favorables à J2 étaients de %d\n",FJ1,FJ2);
    printf("\n\tLa moyenne du nombre de tours est de %d tours.\n",moyTours);
    printf("\n\tLe nombre minimal de tours est de %d tours",minTours);
    printf("\n\tLe nombre maximal de tours est de %d tours",maxTours);

    nbTours = gsort(nbTours);   //pour rendre le graphe plus lisible
    bar(nbTours);

    figure;

    J1H = tabul(jeu1Historique);
    J1H = J1H(1:$-1,:);
    J2H = tabul(jeu2Historique);
    J2H = J2H(1:$-1,:);
    y=J1H(:,2);
    y(:,2) = J2H(:,2);
    x = [1:13];
    bar(x,y,'grouped');

endfunction

//____________________________________________________________________________________________________________________________