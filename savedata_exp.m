%%Save

U.K = K;
U.d1 = d1;
U.d2 = d2;
Time.L = L;
Time.T = T;
Time.t = t;
BS.Pt = Pt;
b = allb;

NoSlot.E = Emean_noslot;
NoSlot.R = Rmean_noslot;
NoSlot.SINR = SINRmean_noslot;
NoSlot.OP = OPnoslot;

Slot.E = Emean_slot;
Slot.R = Rmean_slot;
Slot.SINR = SINRmean_slot;
Slot.OP = OPslot;

save ('dataexp.mat','NoSlot','Slot','U','BS','Time','P','eta','b')