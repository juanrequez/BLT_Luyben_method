function L=bltfreq(w,F,K,T,tm,K1,T1,K2,T2)
%IMPORTANTE: No cambiar el nombre de esta funci�n, ni sus par�metros
%No cambiar el nombre del archivo. Si alguna de estas cosas se cambia,
%puede afectar completamente el desempe�o y funcionamiento de esta funci�n.

%Argumentos:
% w: corresponde al rango de la frencuencia en la que se har� el an�lisis
% F: corresponde al factor de desacoplamiento de BLT
% K1: corresponde a la ganancia proporcional del controlador 11 (estructura ideal)
% T1: correspondel al tiempo integral del controlador 11 (estructura ideal)
% K2: corresponde a la ganancia proporcional del controlador 22 (estructura ideal)
% T2: correspondel al tiempo integral del controlador 22 (estructura ideal)


% Se empieza por definir el par�metro de Laplace en funci�n de la
% frecuencia
s=1i*w;

%%%%%%%%%%%SECCION MODIFICABLE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Modificar esta secci�n para que refleje las necesidades de su problema
%Cada funci�n de transferencia debe ser escrita en esta secci�n de forma
%que los elementos de ella correspondan a la matriz 
%G = [G11 G12
%     G21 G22]
%todas las funciones debes depender de s
%Tenga mucho cuidado con los par�ntesis y operaciones necesarias

G11=( K(1,1)/(T(1,1)*s+1) )*exp(-tm(1,1)*s);
G12=( K(1,2)/(T(1,2)*s+1) )*exp(-tm(1,2)*s);
G21=( K(2,1)/(T(2,1)*s+1) )*exp(-tm(2,1)*s);
G22=( K(2,2)/(T(2,2)*s+1) )*exp(-tm(2,2)*s);
%%%%%%%%%%%FIN DE LA SECCION MODIFICABLE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%El controlador diagonal corresponde a la estructura siguiente
GC=[K1/F*(1+1/T1/F/s)                    0                       
    0                    K2/F*(1+1/T2/F/s) ];
%La planta Corresponde a la estructura siguiente
GM=[G11 G12
    G21 G22];
%Calcular la funci�n W (ecuaci�n 2 de la lectura esencial)
W=-1+det(eye(2)+GM*GC);
%Calcular L (ecuaci�n 3 de la lectura esencial)
L=20*log10(abs(W/(1+W)));

