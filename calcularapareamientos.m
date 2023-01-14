clear
clc
load('modelos_destilacion_10.mat')
[K,T,tm]=conversion(modelos);
[apareamiento,RGA]=aparear(K);
% apareamiento;