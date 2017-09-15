function [mini, error] = errorMinimizer(raw,extint,location)
%raw is the participant's raw pointing judgments in angle form
%extint is whether this is for external or internal landmarks
%location refers to the location in the environment 
    %(1 = PreG, 2 = MidG, 3 = PostG, 4 = PreF, 5 = MidF, 6 = PostF).

    %example usage; [mini,error] = errorMinimizer(raw,'ext',2);
    
    
    
%pointing judgment order for ext (data from Pointing_Answers.xlsx):
    %City Hall
    %Philadelphia Airport
    %Philadelphia Art Museum
    %Philadelphia Sports Complex
    %Franklin Field
    %Goddard Hall
    %Locust Walk Bridge
    %Van Pelt Library
    
%pointing judgment order for int (data from Pointing_Answers.xlsx)
    %Obj1_Loc
    %Obj2_Loc
    %Obj3_Loc
    %Obj1_Orient
    %Obj2_Orient
    %Obj3_Orient
    
if strcmp(extint,'ext') && location == 1
    correct = [83.64472222 205.7897222 33.16083333 155.7625 84.60166667 270.2583333 312.2458333 19.78666667];
elseif strcmp(extint,'ext') && location == 2
    correct = [85.61944444 205.5469444 34.55916667 156.1619444 97.09388889 251.6063889 302.4219444 26.54611111];
elseif strcmp(extint,'ext') && location == 3
    correct = [83.64472222 205.7897222 33.16083333 155.7625 84.60166667 270.2583333 312.2458333 19.78666667];   
elseif strcmp(extint,'ext') && location == 4
    correct = [84.29777778 206.5075 30.24 157.4241667 91.23472222 264.0291667 298.1327778 352.8458333];   
elseif strcmp(extint,'ext') && location == 5
    correct = [83.56083333 206.0138889 32.24666667 156.1547222 84.12472222 270.1133333 309.0072222 13.26277778];   
elseif strcmp(extint,'ext') && location == 6
    correct = [84.29777778 206.5075 30.24 157.4241667 91.23472222 264.0291667 298.1327778 352.8458333];   
elseif strcmp(extint,'int') && location == 2
    correct = [152.6394444 130.6394444 139.1394444 279.1394444 99.13944444 189.1394444]; 
elseif strcmp(extint,'int') && location == 3
    correct = [58.63944444 69.63944444 21.13944444 279.1394444 99.13944444 189.1394444];  
elseif strcmp(extint,'int') && location == 5
    correct = [67.13944444 41.63944444 45.13944444 189.1394444 279.1394444 324.1394444]; 
elseif strcmp(extint,'int') && location == 6
    correct = [349.1394444 291.6394444 268.6394444 189.1394444 279.1394444 324.1394444]; 
else
    correct = zeros(1,6);
end

% Use this for internal Locs / Orientations separately
if size(raw,1) == 3
    correct = correct(1,4:6);
end


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



