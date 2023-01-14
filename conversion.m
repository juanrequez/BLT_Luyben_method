function [K,T,tm]=conversion(modelo)
%% convierte la tabla de parametros "modelos" en K, T, tm, adecuados para cada modelo
% tabla contiene parámetros ordenados en forma de columna, en el orden
% k11
% T11
% tm11
% k12
% T12
% tm12
% K21
% T21
% tm21
% K22
% T22
% tm22
%cada columna representa a un modelo

[~,z]=size(modelo);
for modelnumber=1:z
    counter=1;
    for fila=1:2
        for columna=1:2
            K(fila,columna,modelnumber)=modelo(counter,modelnumber);
            T(fila,columna,modelnumber)=modelo(counter+1,modelnumber);
            tm(fila,columna,modelnumber)=modelo(counter+2,modelnumber);
            counter=counter+3;
        end
    end
end

        