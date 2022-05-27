%% Plot

load ('dataTS.mat')

Eno  = NoSlot.E;
Eslot = Slot.E;
OPno  = NoSlot.OP;
OPslot = Slot.OP;
allTS = Time.L;


figure

ax1 = subplot(1,1,1);
hold on
% yyaxis left
grid on
axis([0 100 0 0.32])
lineE1 = plot(allTS,ones(1,50)*Eno(1),'r-+','LineWidth',2);
lineE2 = plot(allTS,Eslot,'b-','LineWidth',2);
hold off
set(gca, 'FontSize', 12)

%title('Harvested Energy')
xlabel('Number of Time Slots')
ylabel('Accumulated Energy (J)')
legend([lineE1 lineE2],'Without time slot','With time slot','Location','best')



figure

ax2 = subplot(1,1,1);
hold on
grid on
lineOP1 = semilogy(allTS,ones(1,50)*OPno(1),'r-+','LineWidth',2);
lineOP2 = semilogy(allTS,OPslot,'b-','LineWidth',2);
hold off
set(gca,'yscale','log')
set(gca, 'FontSize', 12)

%title('SINR')
xlabel('Number of Time Slots')
ylabel('Outage Probability')
legend([lineOP1 lineOP2],'Without time slot','With time slot','Location','southeast')


