function [Kc,Ti]=liptak(K,tau,tm)

Kc=0.95*tau/K/tm;
Ti=4*tm;

