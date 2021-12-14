clear all;

length = 2000;
noCars = 1200;
vMax = 5;
startVelMin = 1;
startrange = length;
breakprob = 0.5;
iterations = 1000;

dataIndex = zeros(iterations,length);
datavel = zeros(iterations,length);

roadIndex = zeros(1,length);
vel= zeros(1,length);

startPoints = randperm(startrange,noCars);
roadIndex(startPoints) = 1:noCars;
vel(startPoints) = randi([startVelMin, vMax],1,noCars);

for i = 1:iterations
    dataIndex(i,:) = roadIndex;
    datavel(i,:) = vel;
    [roadIndex, vel] = update(roadIndex,vel,vMax,breakprob,1);
end

carpositions = cell(noCars);

tiledlayout(1,1);

% ax1 = nexttile;
% hold(ax1,'on')
% 
% for i = 1:noCars
%     [row,~] = find(dataIndex'==i);
%     carpositions{i} = row';
%     row(abs(diff(row))>vMax+1) = NaN;
%     plot(ax1,row',1:numel(row),'-')
% end
% set(gca,'ydir','reverse')
% exportgraphics(ax1,'path.png','Resolution',300)

ax2 = nexttile;

slices = 100;
slicesize = length/slices;
dencity = zeros(iterations,slices);
for i = 1:iterations
   for j = 1:slices
       dencity(i,j) = nnz(dataIndex(i,((j-1)*slicesize)+1:(j*slicesize)));
   end
end

[X,Y] = meshgrid(1:slicesize:length,1:iterations);

s = pcolor(ax2,X,Y,dencity);
colorbar
s.FaceColor = 'interp';
set(s, 'EdgeColor', 'none');
set(gca,'ydir','reverse')
set(gca,'fontsize',8)
pbaspect([2560 1080 1])

xlabel(ax2,'Road Position')
ylabel(ax2,'Iteration')

exportgraphics(ax2,'dencity.png','Resolution',300)
