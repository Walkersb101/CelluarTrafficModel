clear all;

length = 30;
noCars = 9;
vMax = 5;
startVelMin = 1;
startrange = length;
breakprob = 0.1;
iterations = 15;

dataIndex = zeros(iterations,length);
datavel = zeros(iterations,length);

roadIndex = zeros(1,length);
vel = zeros(1,length);

startPoints = randperm(startrange,noCars);
roadIndex(startPoints) = 1:noCars;
vel(startPoints) = randi([startVelMin, max(vMax)],1,noCars);


for i = 1:iterations
    dataIndex(i,:) = roadIndex;
    datavel(i,:) = vel;
    [roadIndex, vel] = update(roadIndex,vel,vMax,breakprob,1);
end

carpositions = cell(noCars);

tiledlayout(1,1);

ax1 = nexttile;
hold(ax1,'on')

for i = 1:noCars
    [row,~] = find(dataIndex'==i);
    carpositions{i} = row';
    row(abs(diff(row))>vMax) = NaN;
    plot(ax1,row',1:numel(row),'-k')
end
set(gca,'ydir','reverse')
title(ax1,'Car positions')
xlabel(ax1,'Road Position')
ylabel(ax1,'Iteration')
exportgraphics(ax1,'path.png','Resolution',300)

dataIndex = num2str(dataIndex);
dataIndex(dataIndex=='0') = '.';
disp(dataIndex)