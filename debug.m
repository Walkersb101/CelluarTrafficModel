clear all;

length = 10;
noCars = 3;
vMax = 5;
startVelMin = 3;
breakprob = 0.25;
iterations = 100;

roadIndex = [2     1     3     0     0     0     0     0     0     0]
vel = [1     0     0     0     0     0     0     0     0     0]

[newIndex, newvel] = update(roadIndex,vel, vMax, breakprob)


