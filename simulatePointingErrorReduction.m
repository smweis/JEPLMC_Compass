

randP = randi(180,8,1000);
correct = [85.61944444 205.5469444 34.55916667 156.1619444 97.09388889 251.6063889 302.4219444 26.54611111];

for i = 1:1000
    [mini,error] = errorMinimizer(randP(:,i),'ext',2);
    miniAll(1,i) = mini;
    errorAll(1,i) = error;
    rawError(:,i) = abs(randP(:,i) - correct');
end

for i = 1:8
    for j = 1:48
        if rawError(i,j) >= 180
            rawError(i,j) = 360 - rawError(i,j);
        end
    end
end

originalError = mean(rawError);
