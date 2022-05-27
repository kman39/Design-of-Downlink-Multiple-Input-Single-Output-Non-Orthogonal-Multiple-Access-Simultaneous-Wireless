% Plot

load ('dataexp.mat')

Eno  = NoSlot.E;
Eslot = Slot.E;
OPno  = NoSlot.OP;
OPslot = Slot.OP;
allb = b;

figure

ax1 = subplot(1,1,1);
hold on
% yyaxis left
grid on
lineE1 = plot(allb,Eno,'r-+','LineWidth',2);
lineE2 = plot(allb,Eslot,'b-','LineWidth',2);
hold off
set(gca,'xscale','log')
set(gca, 'FontSize', 12)

%title('Harvested Energy')
xlabel('b')
ylabel('Accumulated Energy (J)')
legend([lineE1 lineE2],'Without timeslot','With timeslot','Location','best')




figure

ax2 = subplot(1,1,1);
hold on
grid on
lineOP1 = semilogy(allb,OPno,'r-+','LineWidth',2);
lineOP2 = semilogy(allb,OPslot,'b-','LineWidth',2);
hold off
set(gca,'xscale','log')
set(gca, 'FontSize', 12)

%title('SINR')
xlabel('b')
ylabel('Outage Probability (OP)')
legend([lineOP1 lineOP2],'Without timeslot','With timeslot','Location','southeast')

