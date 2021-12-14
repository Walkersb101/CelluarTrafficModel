clear all;

length = 1e4;

vMax = 5;
breakprob = 0.1;
iterations = 1e5;

point = 10; 

N = 200;

storage = zeros(4,N);

%---------------------------------------

dencities = linspace(0.01,1,N+1);
dencities = dencities(1:N);

parfor_progress(N);

parfor j = 1:N

    dencity = dencities(j);
    noCars = floor(length*dencity);

    roadIndex = zeros(1,length);
    vel= zeros(1,length);

    startPoints = randperm(length,noCars);
    roadIndex(startPoints) = 1:noCars;
    vel(startPoints) = 0;
    
    dencitycount = 0;
    motioncount = 0;

    averagevel = 0;
    for i = 1:iterations
        [newroadIndex, newvel] = update(roadIndex,vel,vMax,breakprob,1);
        if roadIndex(point) ~= 0
            dencitycount = dencitycount + 1;
        end
        LHS = nonzeros(roadIndex(1:point));
        RHS = nonzeros(newroadIndex(point+1:end));
        motion = ismember(LHS,RHS);
        if any(motion)
            motioncount = motioncount + 1;
        end
        roadIndex = newroadIndex;
        vel = newvel;
        averagevel = (averagevel + mean(vel(roadIndex~=0),'all'))/2;
    end
    
    dencityapprox = dencitycount/iterations;
    flow = motioncount/iterations;
    
    storage(:,j) = [dencity; dencityapprox ; flow; averagevel];
    
    parfor_progress;
    
end


plot(storage(1,:),storage(4,:))
csvwrite('Flow.csv',storage)
parfor_progress(0);
