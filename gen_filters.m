function y = gen_filters(type,t,T,F,L,alpha)
%GEN_FILTERS Retourne la r�ponse impulsionnelle de diff�rents filtres de
%mise en forme.
%
% type : 'nrz' pour une porte de dur�e T
%        'rz' pour une porte de dur�e T/2
%        'srrc' pour un filtre en racine de cosinus sur�lev�
% t : vecteur temps [s]
% T : dur�e symbole [s]
% F : facteur de sur�chantillonnage
% L : dur�e de la r�ponse impulsionnelle du filtre [T*s]
% alpha : coefficient d'exc�s de bande (pour filtre srrc)
%
% Par Damien ROQUE <damien.roque@grenoble-inp.fr>

switch type
    case{'nrz'}
        % Cr�ation de l'impulsion rectangulaire NRZ (non-centr�e)
        y=1/sqrt(F)*[ones(1,F) zeros(1,length(t)-F)];
    case{'rz'}
        if mod(F,2)
            error('Le facteur de sur�chantillonnage doit �tre un multiple de deux');
        end
        y=1/sqrt(0.5*F)*[ones(1,F/2) zeros(1,length(t)-F/2)];
    case{'srrc'}
        % D�calage pour obtenir une r�ponse causale
        t=t-T*L/2;
        % Construction du vecteur de sortie dans le cas g�n�ral (abs(t) != T/(4*alpha))
        y=(1/sqrt(F))*(1./(1-(4*alpha.*t/T).^2)).*((1-alpha)*sinc((t/T)*(1-alpha))+(4*alpha/pi).*cos((pi*t/T)*(1+alpha)));
        % Correction des �ventuelles valeurs non-d�finies (t=0 et abs(t) = T/(4*alpha))
        for indice=1:length(t)
            %if t(indice)==0
            if abs(t(indice)) < 10^(-10)
                y(indice)=(1/sqrt(F))*(1-alpha+4*(alpha/pi));
            end
            %if abs(t(indice))==T/(4*alpha)
            if abs(abs(t(indice)) - T/(4*alpha)) < 10^(-10)
                y(indice)=(alpha/sqrt(2*F))*((1+2/pi)*sin(pi/(4*alpha)) + (1-2/pi)*cos(pi/(4*alpha)));
            end
        end
end