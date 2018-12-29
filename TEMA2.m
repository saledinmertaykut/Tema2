close all
clear all
clc
N=50; %Numarul de coeficienti prestabilit
T=32; %Aici am modificat durata perioadei ca fiin de doua ori durata semnalului, acest lucru l-am observat din figurile din ultima pagina din pdf
f=1/T;
t=0:0.0032:2*T; %Voi reprezenta 2 perioade ale semnalului triunghiular dat
w=2*pi*f; %Definim pulsatia sau viteza unghiulara
s=abs(sawtooth(w*t,0.5));
for n= -N:N % n reprezinta indexul, iar acesta va lua valori intre [-N,N]
    C(n+N+1)=1/T * integral(@(t)(abs(sawtooth(w*t,0.5))).*exp(-1j*w*n*t),0,T);
    %Am scris formula coeficientiolor pentru Seria Fourrier Exponentiala,
    %iar integrala este pe o perioada, de aceea am pus '0,T'
    %De asemenea, am folosit C(n+N+1) deoarece coeficientii trebuie sa fie
    %pozitivi
end
%Voi defini semnalul reconstruit, pe care il initializez cu 0
sr=0;
%Incepem reconstruirea semnalului
for n= -N:N
    sr= sr+ C(n+N+1)*exp(1j*n*w*t);
end
figure(1);
%Ca si in titlu, figura(1) este figura cu semnalele initial si reconstruit
hold on %Cu ajutorul acestei functii vom adauga mai multe reprezentari in figura 1
plot(t,real(sr),':.b');
plot(t,imag(sr),':.r');
plot(t,s,'-.k');
grid ;
xlabel('Timpul [s]');
ylabel('Amplitudine');
title('Semnalul initial este cel cu linia solida (s=f(t)), iar semnalul reconstruit este cu linia punctata (sr)');
hold off
figure(2); %In aceasta figura vom reprezenta spectrul de amplitudini, spectrul fiind unul discret vom folosi functia stem
hold on
stem((-N:N)*w,2*abs(C)); %Folosim abs, deoarece sprectrul de amplitudini,pe langa ca este discret, are intotdeauna valori pozitive pe axa y
xlabel('Pulsatia sau viteza unghiulara w');
ylabel('Amplitudinile Ak');
title('Spectrul de amplitudini');
hold off
%Se observa ca seria Fourrier, la un numar mare de trunchieri, este o buna
%aproximare a semnalului initial.

