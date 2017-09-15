

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
        [participantMin,participantError] = errorMinimizer(participantData,'ext',fi);
        pointingMin.(fields{fi})(:,participant) = participantMin;
        pointingError.(fields{fi})(:,participant) = participantError;
    end
end

%line up participants based on whether they were F-Ank or G-Ank
minAnkMid = [pointingMin.MidG(1,1:24) pointingMin.MidF(1,25:48)];
minNoAnkMid = [pointingMin.MidF(1,1:24) pointingMin.MidG(1,25:48)];

errorAnkMid = [pointingError.MidG(1,1:24) pointingError.MidF(1,25:48)];
errorNoAnkMid = [pointingError.MidF(1,1:24) pointingError.MidG(1,25:48)];

errorAnkPost = [pointingError.PostG(1,1:24) pointingError.PostF(1,25:48)];
errorNoAnkPost = [pointingError.PostF(1,1:24) pointingError.PostG(1,25:48)];


%Correct mins for rotating in the correct direction;
minAnkMid = 360 - minAnkMid;
minNoAnkMid = 360 - minNoAnkMid;


forCorr(:,1) = minAnkMid';
forCorr(:,2) = ankThought;
forCorr(:,3) = minNoAnkMid';
forCorr(:,4) = noAnkThought;
 
for i = 1:length(forCorr)
    forCorrRad(i,1) = deg2rad(forCorr(i,1));
    forCorrRad(i,2) = deg2rad(forCorr(i,2));
    forCorrRad(i,3) = deg2rad(forCorr(i,3));
    forCorrRad(i,4) = deg2rad(forCorr(i,4));

end

% 
%  
% for i = 1:length(unnamed)
%     forCorrRad(i,2) = deg2rad(unnamed(i,2));
%     forCorrRad(i,3) = deg2rad(unnamed(i,3));
%     forCorrRad(i,4) = deg2rad(unnamed(i,4));
%     forCorrRad(i,5) = deg2rad(unnamed(i,5));
%     forCorrRad(i,6) = deg2rad(unnamed(i,6));
%     forCorrRad(i,7) = deg2rad(unnamed(i,7));
%     forCorrRad(i,8) = deg2rad(unnamed(i,8));
%     forCorrRad(i,9) = deg2rad(unnamed(i,9));
% end
% 
% [h,p] = circ_corrcc(forCorrRad(:,2),forCorrRad(:,6))
% [h,p] = circ_corrcc(forCorrRad(:,3),forCorrRad(:,7))
% [h,p] = circ_corrcc(forCorrRad(:,2),forCorrRad(:,4))
% [h,p] = circ_corrcc(forCorrRad(:,6),forCorrRad(:,8))
% [h,p] = circ_corrcc(forCorrRad(:,3),forCorrRad(:,5))
% [h,p] = circ_corrcc(forCorrRad(:,7),forCorrRad(:,9))
% 
% figure
% subplot(2,2,1)
% circ_plot(forCorrRad(:,1)+(pi/2),'hist',[],40,false,true,'linewidth',2,'color','g')
% subplot(2,2,2)
% circ_plot(forCorrRad(:,2)+(pi/2),'hist',[],40,false,true,'linewidth',2,'color','g')
% subplot(2,2,3)
% circ_plot(forCorrRad(:,3)+(pi/2),'hist',[],40,false,true,'linewidth',2,'color','g')
% subplot(2,2,4)
% circ_plot(forCorrRad(:,4)+(pi/2),'hist',[],40,false,true,'linewidth',2,'color','g')
% 
% 
% subplot(2,2,1)
% title('Compass Best Fit')
% subplot(2,2,2)
% title('Compass Participant North')
% subplot(2,2,3)
% title('Non-Compass Best Fit')
% subplot(2,2,4)
% title('Non-Compass Participant North')
