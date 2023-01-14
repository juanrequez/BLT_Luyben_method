clear
close all
clc
% calcular los apareamientos según RGA
calcularapareamientos


[~,numbermodel]=size(modelos);


% reacomodar los modelos en función del apareamiento.
for i=1:numbermodel
    if apareamiento(i,1)==2
        K(:,:,i)=[K(2,:,i); K(1,:,i)];
        T(:,:,i)=[T(2,:,i); T(1,:,i)];
        tm(:,:,i)=[tm(2,:,i); tm(1,:,i)];
        i
    end
end


%calcular los controladores para los diez modelos usando liptak



for i=1:numbermodel
    for j=1:2
    [Kc(j,i),Ti(j,i)]=liptak(K(j,j,i),T(j,j,i),tm(j,j,i));
    end
end

Wmax=50*permute(max(max(1./T)),[1 3 2]);
F=1:0.1:6;


for i=1:numbermodel
    %hacer corrida para F
    for j=1:length(F)
        w=0:Wmax(i)/100:Wmax(i);
        for indice=1:length(w)
            L(indice)=bltfreq(w(indice),F(j),K(:,:,i),T(:,:,i),tm(:,:,i),Kc(1,i),Ti(1,i),Kc(2,i),Ti(2,i));
        end
        Lcurve(j)=max(L);
    end
    figure(i)
    plot(F,Lcurve)
    myfun=@(x) interp1(F,Lcurve-4,x,'spline','extrap');
    
    Fluyben(i)=fzero(myfun,[2 6]);
end

Tmax=10*permute(max(max(T)),[1 3 2]);
%comprobar en simulación
for i=1:numbermodel
    tiempo=Tmax(i);
    K11=K(1,1,i);
    K12=K(1,2,i);
    K21=K(2,1,i);
    K22=K(2,2,i);
    T11=T(1,1,i);
    T12=T(1,2,i);
    T21=T(2,1,i);
    T22=T(2,2,i);
    tm11=tm(1,1,i);
    tm12=tm(1,2,i);
    tm21=tm(2,1,i);
    tm22=tm(2,2,i);
    Kc11=Kc(1,i);
    Kc22=Kc(2,i);
    Ti11=Ti(1,i);
    Ti22=Ti(2,i);
    simout(i)=sim('variosmodelos','SrcWorkspace','current');
    Y=get(simout(i),'Y');
    Kc11=Kc11/Fluyben(i);
    Kc22=Kc22/Fluyben(i);
    Ti11=Ti11*Fluyben(i);
    Ti22=Ti11*Fluyben(i);
    figure(numbermodel+i)
    simoutluyben(i)=sim('variosmodelos','SrcWorkspace','current');
    Yluyben=get(simoutluyben(i),'Y');
    plot(Y.Time,Y.Data,Yluyben.Time,Yluyben.Data)
    titulo=sprintf('Respuesta comparada para modelo %i',i);
    title(titulo)
    legend('Y1 sin F','Y2 sin F','Y1 con F','Y2 con F')
    figure(numbermodel*2+i)
    plot(Yluyben.Time,Yluyben.Data)
    titulo=sprintf('Respuesta Luyben BLT para modelo %i',i);
    title(titulo)
end
   