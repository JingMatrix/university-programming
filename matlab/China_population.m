clc;
clear;

% The population of China from 1949 to 2015.
p = 1e4*[
    54167 55196 56300 57482 58796 60266 61465 62828 64653 65994 ...
    67207 66207 65859 67295 69172 70499 72538 74542 76368 78534 ...
    80671 82992 85229 87177 89211 90859 92420 93717 94974 96259 ...
    97542 98705 100072 101654 103008 104357 105851 107507 109300 111026 ...
    112704 114333 115823 117171 118517 119850 121121 122389 123626 124810 ...
    125786 126743 127627 128453 129227 129988 130756 131448 132129 132802 ...
    133450 134091 134735 135404 136072 136782 137462
    ]';
%the accuracy of the data can be verified from the website of National Bureau of Statistics of China
h=7;%h是多项式最高项次数
A=zeros(67,h);
for i=1:h
    for j=1:67
        A(j,i)=(1948+j)^(h-i);
    end
end
coefficient=ls_QR(A,p);
x = (1945: 0.2 :2020)';
y=(1949:1:2015)';%year
plot(y,p,'ro','MarkerSize',5);
hold on
ll=plot(x,polyval(coefficient,x),'-b');
hold off
xlabel('year');
ylabel('population');
title(['多项式最高项次数=' num2str(h)]);