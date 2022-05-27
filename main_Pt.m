n = 100000;             %epochs
step = 20;              %step of transmitted power
allPt = 0.05*(1:step);  %Transmitted Power
gamma = 1;              %Acheivable Rate Threshold

for a = 1:step

    Pt = allPt(a);      %Transmitted Power in this loop
    Esum_noslot = 0;    %Minimum Accumulated Energy (average)
    Rsum_noslot = 0;    %Minimum Achievable Rate (average)
    SINR_noslot = 0;    %Minimum SINR (average)
    OP_noslot   = 0;    %Outage probabily
    Esum_slot = 0;
    Rsum_slot = 0;
    SINR_slot = 0;
    OP_slot   = 0;

for b = 1:n
%%Generate CSI
    h = gen_h(BS.M,K,d1,d2);      %CSI
    unitw = gen_unitw(h);   %Unit precoding (size of each w = 1)
    
    
    
    
%% No Time slot
clear w allw SINR

for j = 1:L
    idx = 1:K;
    w = beamexp(unitw,idx);
    [w,allw] = adjpower(w,Pt);       %Adjust transmitted power = BS.Pt

    Power = powersignal(h,allw);
    Ptotal = (Power + P.no) .* P.rho;   %Total Power for harvest

    %Harvest Energy
    if j == 1
        Enoslot(j,:) = harvest(Power,eta,t);
    else
        x = harvest(Power,eta,t);
        Enoslot(j,:) = Enoslot(j-1,:) + x';
    end
    
    %Acheived rate
    for i = 1:K
        Power = powersignal(h(:,i),w);      %All signal power at Ui
        SINR(j,i) = sinr(Power,i,P.no);
        Rnoslot(j,i) = rate(SINR(j,i));
    end
end

Esum_noslot = Esum_noslot + min(Enoslot(L,:));
Rsum_noslot = Rsum_noslot + min(mean(Rnoslot));
SINR_noslot = SINR_noslot + min(mean(SINR));
if min(mean(Rnoslot)) < gamma
    OP_noslot = OP_noslot + 1;
end


%% Time slot
clear w allw SINR

for j = 1:L
    if j == 1
        idx = 1:K;
        w = beamexp(unitw,idx);
    else
        [~,idx] = sort(Eslot(j-1,:));
        w = beamexp(unitw,idx);
    end
    [w,allw] = adjpower(w,Pt);       %Adjust transmitted power = BS.Pt

    Power = powersignal(h,allw);
    Ptotal = (Power + P.no) .* P.rho;   %Total Power for harvest

    %Harvest Energy
    if j == 1
        Eslot(j,:) = harvest(Power,eta,t);
    else
        x = harvest(Power,eta,t);
        Eslot(j,:) = Eslot(j-1,:) + x';
    end
    
    %Acheived rate
    for i = 1:K
        Power = powersignal(h(:,i),w);      %All signal power at Ui
        SINR(j,i) = sinr(Power,i,P.no);
        Rslot(j,i) = rate(SINR(j,i));
    end
end

Esum_slot = Esum_slot + min(Eslot(L,:));
Rsum_slot = Rsum_slot + min(mean(Rslot));
SINR_slot = SINR_slot + min(mean(SINR));
if min(mean(Rslot)) < gamma
    OP_slot = OP_slot + 1;
end


end
a = a

Emean_noslot(a)    = Esum_noslot/n;
Emean_slot(a)      = Esum_slot/n;
Rmean_noslot(a)    = Rsum_noslot/n;
Rmean_slot(a)      = Rsum_slot/n;
SINRmean_noslot(a) = SINR_noslot/n;
SINRmean_slot(a)   = SINR_slot/n;
OPnoslot(a)        = OP_noslot/n;
OPslot(a)          = OP_slot/n;

end


savedata_Pt

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

function w = beamexp(unitw,idx)
    [M,K] = size(unitw);
    idx = exp(-idx);            %Power allocation exponential
    idx = repmat(idx,M,1);
    w = unitw.*idx;
end

function w = beamnormal(unitw,idx)
    [M,K] = size(unitw);
    idx = fliplr(idx);          %Power allocation simple NOMA
    idx = repmat(idx,M,1);
    w = unitw.*idx;
end

function [w,allw] = adjpower(w,Pt)
    allw = sum(w,2);
    factor = sqrt(Pt)/norm(allw);
    allw = allw*factor;             %Adjust transmitted power = BS.Pt
    w = w*factor;
end

function Power = powersignal(h,w)
    Power = abs(h.'*w).^2;
end

function E = harvest(Power,eta,T)
    E = Power*eta*T;
end

function R = rate(SINR)
    R = log2(1 + SINR);
end

function SINR = sinr(Power,i,noise)
    PowerInterference = 0;
    [~,K] = size(Power);
    for n = 1:K
        if Power(n) < Power(i)
            PowerInterference = PowerInterference + Power(n);
        end
    end
    SINR = Power(i) / (PowerInterference + noise);
end