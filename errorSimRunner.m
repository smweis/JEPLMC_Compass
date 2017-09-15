
for i = 1:40
    big = randi([0,359],i,1000);
    bigAns = randi([0,359],i,1);
    for p = 1:size(big,2)
        
        [mini(p,:),error(p,:)] = errorMinimizerForSimulations(big(:,p),bigAns);
    
    end
    i
    result(i) = mean(error);
    
end
