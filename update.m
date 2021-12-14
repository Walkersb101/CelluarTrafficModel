function [newIndex, newvel] = update(roadIndex,vel, vMax, decelprob, circle)
    length = size(roadIndex,2);
    carpos = roadIndex ~= 0;
    noCars = nnz(roadIndex);
    
    if numel(vMax) == 1
        vMax = vMax*ones(size(roadIndex));
    end
    %acceleration
    dbetweencars = diff(find([carpos,carpos]));
    dbetweencars = dbetweencars(1:noCars);
 
    toAccelerate = vel(carpos )+1 < dbetweencars;
    acceleratepos = carpos;
    acceleratepos(carpos) = toAccelerate;
    vel(acceleratepos) = vel(acceleratepos)+1;
    %break
    toBreak = dbetweencars <= vel(carpos);
    breakpos = carpos;
    breakpos(carpos) = toBreak;
    vel(breakpos) = dbetweencars(toBreak)-1;
    
    %rand
    toDecelerate = binornd(1,decelprob,1,noCars);
    deceleratepos = carpos;
    deceleratepos(carpos) = toDecelerate;
    vel(deceleratepos) = vel(deceleratepos)-1;
    
    %keep speed in range
    vel(vel > vMax) = vMax(vel > vMax);
    vel(vel<0) = 0;
    
    %update positions
    newIndex = zeros(1,length*2);
    newvel = zeros(1,length*2);
    
    index = find(carpos);
    if circle
        index = index + vel(carpos) - 1;
        index = mod(index,length) + 1;
    else
        index = index + vel(carpos);
    end
    
    newIndex(index) = roadIndex(carpos);
    newvel(index) = vel(carpos);
    
    newIndex = newIndex(1:length);
    newvel = newvel(1:length);
    
end