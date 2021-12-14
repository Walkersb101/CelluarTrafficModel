storage = readtable('Flow.csv');
storage = storage{:,:};

plot(storage(1,:),storage(4,:),'k')

title('Fundamental Average Velocity Diagram')
xlabel('Dencity of cars [no of cars/no of cells]') 
ylabel('Average Velocity') 