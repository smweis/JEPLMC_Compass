

%subjects 1-24 had the Anklet on G
%subjects 25-48 had the Anklet on F

%pointing judgment order (data from Pointing_Answers.xlsx):
    %City Hall
    %Philadelphia Airport
    %Philadelphia Art Museum
    %Philadelphia Sports Complex
    %Franklin Field
    %Goddard Hall
    %Locust Walk Bridge
    %Van Pelt Library

load('externalData.mat');
load('subjData.mat');
load('extAnswers.mat');

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
        participantData = pointingData.(fields{fi})(:,participant);
        [participantMin,participantError] = errorMinimizer(participantData);
        pointingMin.(fields{fi})(:,participant) = participantMin;
        pointingError.(fields{fi})(:,participant) = participantError;
    end
end

%line up participants based on whether they were F-Ank or G-Ank
minAnkMid = [pointingMin.MidG(1,1:24) pointingMin.MidF(1,25:48)];
minNoAnkMid = [pointingMin.MidF(1,1:24) pointingMin.MidG(1,25:48)];

errorAnkMid = [pointingError.MidG(1,1:24) pointingError.MidF(1,25:48)];
errorNoAnkMid = [pointingError.MidF(1,1:24) pointingError.MidG(1,25:48)];

%Correct mins for rotating in the correct direction;
minAnkMid = 360 - minAnkMid;
minNoAnkMid = 360 - minNoAnkMid;


forCorr(:,1) = extNorthGuessNoAnk;
forCorr(:,2) = extNorthGuessAnk;
forCorr(:,3) = extNorthBestFitNoAnk;
forCorr(:,4) = extNorthBestFitAnk;

for i = 1:length(forCorr)
    forCorrRad(i,1) = deg2rad(forCorr(i,1));
    forCorrRad(i,2) = deg2rad(forCorr(i,2));
    forCorrRad(i,3) = deg2rad(forCorr(i,3));
    forCorrRad(i,4) = deg2rad(forCorr(i,4));
end

