%% plot
figure(1)
plot([citys(Shortest_Route,1);citys(Shortest_Route(1),1)],...
     [citys(Shortest_Route,2);citys(Shortest_Route(1),2)],'o-');
grid on
for i = 1:size(citys,1)
    text(citys(i,1),citys(i,2),['   ' num2str(i)]);
end
text(citys(Shortest_Route(1),1),citys(Shortest_Route(1),2),'       start');
text(citys(Shortest_Route(end),1),citys(Shortest_Route(end),2),'       end');
xlabel('x-coordinate')
ylabel('y-coordinate')
title(['Shortest Path by ACO (Shortest Length:' num2str(Shortest_Length) ')'])
figure(2)
plot(1:iter_max,Length_best,'b',1:iter_max,Length_ave,'r:')
legend('Shortest','Average')
xlabel('iterations')
ylabel('length')
title('comparion between shortest length and average length')
