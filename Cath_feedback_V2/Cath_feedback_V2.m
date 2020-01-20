%% import sequences from all participants and store them in a cell array

addpath('P:\04_Student_theses\1378_BereiterLivio_BA_TSP_AutomatedProcessAnalysis\Program\sequence_analysis\Cath_feedback_V2\Data\Participant_Sequences');
addpath('P:\04_Student_theses\1378_BereiterLivio_BA_TSP_AutomatedProcessAnalysis\Program\sequence_analysis\Cath_feedback_V2\Data\Procedure_Steps_Def');
addpath('P:\04_Student_theses\1378_BereiterLivio_BA_TSP_AutomatedProcessAnalysis\Program\sequence_analysis\Cath_feedback_V2\Data\Templates');

%addpath(['/Volumes/1378_BereiterLivio_BA_TSP_AutomatedProcessAnalysis/Program/sequence_analysis/Cath_feedback_V2/Data']);
%addpath('P:\04_Student_theses\1378_BereiterLivio_BA_TSP_AutomatedProcessAnalysis\Program\sequence_analysis\Cath_feedback_V2\Data\Participant_Sequences');
%addpath('P:\04_Student_theses\1378_BereiterLivio_BA_TSP_AutomatedProcessAnalysis\Program\sequence_analysis\Cath_feedback_V2\Data\Participant_Sequences');

%find out what the size is of the users data-set: 
prompt = 'How many Novices does your data-set involve?(INPUT:Number)\n';

numN = input(prompt); 

prompt = 'How many Experts does your data-set involve?(INPUT:Number)\n';

numE = input(prompt); 

%does the surgery the user wishes to analyse have two characteristics parts
%or are there only single sequences for the whole procedure?
prompt = 'Does the surgery you wish to analyse have two characteristic parts as defined by the seperation of left leg (LL) and right leg (RL) seen in the example Novice1.txt or not?(INPUT:2 or 1 respectively)\n';

UserParts = input(prompt); 
%import novice-data: 
for i = 1:numN
    
    DataN(i,1) = {importfile2(sprintf('Novice%d.txt', i),UserParts)};
    
end
%import experts-data: 
for i = 1:numE
    
    DataE(i,1) = {importfile2(sprintf('Expert%d.txt', i),UserParts)};
    
end

%% import Templates
prompt = 'How many different templates does your data-set involve?(INPUT:Number)\n';

numT = input(prompt);

for i = 1:numT
    
DataT(i,1) = {importfile2(sprintf('Template%d.txt', i),UserParts)};

end
%% Calculate score for each participant using Levenshtein-Dist., Damerau-Levenshtein-Dist. and user-defined feedback regulations

addpath('P:\04_Student_theses\1378_BereiterLivio_BA_TSP_AutomatedProcessAnalysis\Program\sequence_analysis\Cath_feedback_V2\Data\Crucial_Feedback_Steps');

for i = 1:UserParts
    
DataPF(i,1) = {importfile4(sprintf('Crucial_Feedback_Cath_Steps%d.txt', i))};

end

%Score-Function which uses data-sets as inputs and Userinformation about his data-set and gives as output the scores and score-track: 
[Scores,Scores_Track,ScoreN_Names,ScoreE_Names,TrackN_Names,TrackE_Names] = score_calc1(DataN, DataE, DataT, DataPF, UserParts, numN, numE);

%display results of score calculation: 
for i = 1:numN 
    
    disp(Scores.Novices.(ScoreN_Names(i,1)));
    disp(Scores_Track.Novices.(TrackN_Names(i,1)));
    
end

for i = 1:numE
    
    disp(Scores.Experts.(ScoreE_Names(i,1)));
    disp(Scores_Track.Experts.(TrackE_Names(i,1)));
    
end







