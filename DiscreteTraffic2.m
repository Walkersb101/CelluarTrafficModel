clear all;

length = 1000;
noCars = 300;
vMax = 5*ones(1,length);
vMax(600:end) = 0;
startVelMin = 1;
startrange = 600;
breakprob = 0.1;
iterations = 1000;

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
    if i == 150
        vMax = 5*ones(1,length);
    end
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

slicesize = 20;
slices = length/slicesize;
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
pbaspect([1080 1080 1])

xlabel(ax2,'Road Position')
ylabel(ax2,'Iteration')

exportgraphics(ax2,'dencity2.png','Resolution',300)
