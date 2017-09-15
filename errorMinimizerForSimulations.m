function [mini, error] = errorMinimizerForSimulations(raw,correct)
%raw is the participant's raw pointing judgments in angle form
%correct is the "correct" data

% Use this for internal Locs / Orientations separately
% if size(raw,1) == 3
%     correct = correct(1,4:6);
% end

correct = correct';
raw = raw';


for j = 1:360
    adjraw = raw + j-1;
    for i = 1:length(adjraw)
        if adjraw(1,i) >= 360
            adjraw(1,i) = adjraw(1,i) - 360;
        end
    end
    for i = 1:length(adjraw)
        adjError(i,j) = abs(correct(i) - adjraw(i));
        if adjError(i,j) >= 180
            adjError(i,j) = 360 - adjError(i,j);
        end
    end
end

meanError = mean(adjError);

[error, mini] = min(meanError);

end



