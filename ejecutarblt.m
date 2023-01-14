%Ejecutar este script para obtener el diagrama del método BLT
%ANTES DE EJECUTAR ESTE PROGRAMA, ASEGURESE QUE bltfrecuencia.m haya sido
%modificado para que contenga las funciones de transferencia con las que
%se desea trabajar. 

%limpiar la pantalla y limpiar el workspace
clear
clc

%%%%%%%%%%%%%%%%%%%SECCIÓN MODIFICABLE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Definir los parámetros de diseño de de los controladores
K1=-3.738;
T1=4;
K2=5.708;
T2=1.4;

%elegir un valor para F
F=2.5; %hacer suposicion del valor de F

%elegir el rango de W
Wmin=0; %valor mínimo de W, debe ser 0
Wmax=7.1; %Valor máximo de W, se recomienda que sea por lo menos 50 veces mayor que 
%la frecuencia mayor del sistema, 1/Tau
%%%%%%%%%%%%%%%FIN DE LA SECCIÓN MODIFICABLE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%resolución del cálculo, corresponde al incremento de los valores de W
Winc=(Wmax-Wmin)/1000; 
%frecuencias de cálculo
w=Wmin:Winc:Wmax; 

%calcular L para cada valor de w
%iniciar L
L=zeros(size(w))
for indice=1:length(w)
    L(indice)=bltfrecuencia(w(indice),F,K1,T1,K2,T2);
end

%ubicar el máximo valor de L
[maxL,I]=max(L);

%graficar el resultado de BLT
plot(w,L)
xlabel('frecuencia w (rad/s)');
ylabel('L(w)');
titulo=sprintf('factor de desacoplamiento F=%.2f',F);
title(titulo)
etiqueta=sprintf('%.4f',maxL);
text(w(I),L(I),['\leftarrow ' etiqueta]);













