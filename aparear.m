function [apareamiento,RGA]=aparear(K)
%calcula el arreglo de la ganancia relativa para cada modelo
%cada matriz de ganancia de ss está dada en forma matricial
% y cada capa de la entrada representa a un modelo

[~,~,capas]=size(K);

RGA=zeros(2,2,capas);
for modelnumber=1:capas
    %conseguir el RGA de todos los modelos
    RGA(:,:,modelnumber)=K(:,:,modelnumber).*(inv( K(:,:,modelnumber) )');
end

[~,indices]=max(RGA);

apareamiento=ones(capas,2);
for modelnumber=1:capas
    %conseguir el apareamiento adecuado basado en el RGA
    apareamiento(modelnumber,1)=indices(1,1,modelnumber);
end
    
