clear all

K = 4;                  %Amount of nodes
L = 10;                 %Amount of time slots
T = 1;                  %Total time (seconds)
t = T/L;                %Time per slot

%Distances
d1 = 1;
d2 = d1;

%Base Station
BS.M = 3;                %Antenna
BS.Pt = 0.5;             %Power

%User/Node
h = gen_h(BS.M,K,d1,d2); %CSI
unitw = gen_unitw(h);    %Unit precoding (size of each w = 1)
%U.h = h;
%U.unitw = unitw;

%Power
P.rho = 0.7;            %Power Splitting ratio
P.no = 0.002;           %Power of noise

%Energy
eta = 0.8;              %Energy conversion factor


%% Function

%Generate CSI
function h = gen_h(M,K,d1,d2)
    for i = 1:K
        x = (randn(M,1)+1i*randn(M,1))/sqrt(2)*(d1/d2);    %CSI (from M attennas)
        tmp(i) = norm(x);                          %Size of CSI
        h(:,i) = x;
    end
    
    [~,idx] = sort(tmp);            %Sort CSI
    h = h(:,idx);
end

%Generate unit precoding ( |w(i)|^2 = 1 )
function w = gen_unitw(h)
    [~,K] = size(h);
    for i = 1:K
        x = h(:,i);
        w(:,i) = conj(x)/norm(x);   %Precoding ; Size = 1
    end
end