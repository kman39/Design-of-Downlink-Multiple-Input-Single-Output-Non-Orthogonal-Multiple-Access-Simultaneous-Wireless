%% Plot

load ('dataPt.mat')

Eno  = NoSlot.E;
Eslot = Slot.E;
OPno  = NoSlot.OP;
OPslot = Slot.OP;
allPt = P.allPt;


figure

ax1 = subplot(1,1,1);
hold on
% yyaxis left
grid on
lineE1 = plot(allPt,Eno,'r-+','LineWidth',2);
lineE2 = plot(allPt,Eslot,'b-','LineWidth',2);
hold off
set(ax1.YAxis, 'Color', 'k')
set(gca, 'FontSize', 12)



%title('Harvested Energy')
xlabel('Total Transmitted Power (W)')
ylabel('Accumulated Energy (J)')
legend([lineE1 lineE2],'Without time slot','With time slot','Location','northwest')


figure

ax2 = subplot(1,1,1);
hold on
grid on
lineOP1 = semilogy(allPt,OPno,'r-+','LineWidth',2);
lineOP2 = semilogy(allPt,OPslot,'b-','LineWidth',2);
hold off
set(gca,'yscale','log')
set(gca, 'FontSize', 12)

%title('SINR')
xlabel('Total Transmitted Power (W)')
ylabel('Outage Probability')
legend([lineOP1 lineOP2],'Without time slot','With time slot','Location','best')


