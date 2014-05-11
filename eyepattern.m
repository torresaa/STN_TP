function [] = eyepattern(y_t,T,F,taille_visu,begin_offset,end_offset)
%EYEPATTERN Affiche le diagramme de l'oeil.
%
% y_t : signal re�u (sur�chantillonn�).
% T : dur�e d'un symbole [s].
% F : facteur de sur�chantillonnage.
% taille_visu : nombre de symboles � visualiser.
% begin_offset : nombre d'�chantillons � �carter en d�but de signal.
% end_offset : nombre d'�chantillons � �carter en fin de signal.

% Cr�ation du vecteur temps
tvisu=0:T/F:taille_visu*T-T/F;

% Troncature du signal � visualiser
y_t=y_t(begin_offset:end-end_offset);

% Visualisation sur un nombre entier de trajectoires
nb_trajectoires=floor(length(y_t)/length(tvisu));

% Remise en forme du signal pour diagramme de l'?il
y_t_mat=reshape(y_t(1:nb_trajectoires*taille_visu*F),taille_visu*F,nb_trajectoires);

% Affichage du diagramme de l'oeil
figure;
plot(tvisu,y_t_mat);
title('Diagramme de l''oeil du signal recu');
xlabel('Temps [s]');
ylabel('Amplitude [V]');
end

