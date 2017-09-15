

%subjects 1-24 had the Anklet on G
%subjects 25-48 had the Anklet on F


%pointing judgment order for int (data from Pointing_Answers.xlsx)
    %Obj1_Loc
    %Obj2_Loc
    %Obj3_Loc
    %Obj1_Orient
    %Obj2_Orient
    %Obj3_Orient

load('internalData.mat');
load('subjData.mat');


pointingError = struct;
pointingError.PreG = zeros(1,48);
pointingError.MidG = zeros(1,48);
pointingError.PostG = zeros(1,48);
pointingError.PreF = zeros(1,48);
pointingError.MidF = zeros(1,48);
pointingError.PostF = zeros(1,48);
pointingMin = struct;
pointingMin.PreG = zeros(1,48);
pointingMin.MidG = zeros(1,48);
pointingMin.PostG = zeros(1,48);
pointingMin.PreF = zeros(1,48);
pointingMin.MidF = zeros(1,48);
pointingMin.PostF = zeros(1,48);


fields = fieldnames(pointingData);

for fi = 1:length(fields)
    for participant = 1:length(pointingData.(fields{fi}))
        participantData = pointingData.(fields{fi})(4:6,participant);
        [participantMin,participantError] = errorMinimizer(participantData,'int',fi);
        pointingMin.(fields{fi})(:,participant) = participantMin;
        pointingError.(fields{fi})(:,participant) = participantError;
    end
end

%line up participants based on whether they were F-Ank or G-Ank
minAnkMid = [pointingMin.MidG(1,1:24) pointingMin.MidF(1,25:48)];
minNoAnkMid = [pointingMin.MidF(1,1:24) pointingMin.MidG(1,25:48)];

minAnkEnd = [pointingMin.PostG(1,1:24) pointingMin.PostF(1,25:48)];
minNoAnkEnd = [pointingMin.PostF(1,1:24) pointingMin.PostG(1,25:48)];

errorAnkMid = [pointingError.MidG(1,1:24) pointingError.MidF(1,25:48)];
errorNoAnkMid = [pointingError.MidF(1,1:24) pointingError.MidG(1,25:48)];

errorAnkEnd = [pointingError.PostG(1,1:24) pointingError.PostF(1,25:48)];
errorNoAnkEnd = [pointingError.PostF(1,1:24) pointingError.PostG(1,25:48)];

%Correct mins for rotating in the correct direction;
minAnkMid = 360 - minAnkMid;
minNoAnkMid = 360 - minNoAnkMid;
minAnkEnd = 360 - minAnkEnd;
minNoAnkEnd = 360 - minNoAnkEnd;

% 
% 
for i = 1:length(minAnkMid)
     minAnkMid(1,i) = deg2rad(minAnkMid(1,i));
     minNoAnkMid(1,i) = deg2rad(minNoAnkMid(1,i));
     minAnkEnd(1,i) = deg2rad(minAnkEnd(1,i));
     minNoAnkEnd(1,i) = deg2rad(minNoAnkEnd(1,i));
end
