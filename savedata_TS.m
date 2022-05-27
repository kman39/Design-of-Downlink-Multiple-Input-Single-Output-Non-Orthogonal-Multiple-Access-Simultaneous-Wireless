%%Save

U.K = K;
U.d1 = d1;
U.d2 = d2;
Time.L = allslot;
Time.T = T;
Time.t = ones(1,step)*T./allslot;
BS.Pt = Pt;

NoSlot.E = Emean_noslot;
NoSlot.R = Rmean_noslot;
NoSlot.SINR = SINRmean_noslot;
NoSlot.OP = OPnoslot;

Slot.E = Emean_slot;
Slot.R = Rmean_slot;
Slot.SINR = SINRmean_slot;
Slot.OP = OPslot;

save ('dataTS.mat','NoSlot','Slot','U','BS','Time','P','eta')