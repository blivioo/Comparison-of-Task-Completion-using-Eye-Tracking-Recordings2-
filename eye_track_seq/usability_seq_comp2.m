clear all; 
clc; 

%% Add path to data-folder

addpath('P:\04_Student_theses\1378_BereiterLivio_BA_TSP_AutomatedProcessAnalysis\Program\sequence_analysis\eye_track_seq\Data');

%% import sequences from all participants and experts and store them in a cell array
 
numN = 1;

numE = 1; 

prompt = 'Does your data-set have two characteristic parts like Part1 and Part2 for each trial?(INPUT:2 or 1 respectively)\n';

UserParts = input(prompt); 

prompt = 'How many trials does your experiment have?(INPUT:Number)\n';

if UserParts == 2
    
  numTrials = input(prompt); 
  Variables(1,1) = {'Participants'};
  colcount = 1;
  
  for i = 1:numTrials
          
   my_variables1 = sprintf('T%dP1', i);
   Variables11(1,i) = {my_variables1};
   
  end
  
  for i = 1:numTrials
      
    my_variables2 = sprintf('T%dP2', i);
    Variables22(1,i) = {my_variables2};
      
  end

  for i = 1:2:(2*numTrials)

      Variables(1,i+1) = Variables11(1,colcount);
      Variables(1,i+2) = Variables22(1,colcount); 
  
      colcount = colcount + 1;
      
  end
  
  Variables = string(Variables);
  numTrials = (2*numTrials) + 1;
  
elseif UserParts == 1
    
  numTrials = input(prompt);
  Variables(1,1) = {'Participants'};
  
  for i = 1:numTrials
          
   my_variables1 = sprintf('T%dP1', i);
   Variables(1,i+1) = {my_variables1};
   
  end
  
  Variables = string(Variables);
  numTrials = numTrials + 1;
  
end

%import novice-data:
DataN(1,1) = {importfile3('Participants_Type1.txt', Variables, numTrials)};
 
%import expert-data:
DataE(1,1) = {importfile3('Experts_Type1.txt', Variables, numTrials)};

%import template:
 
disp('Does your Template_Typei.txt-file contain a single sequence per part of the experiment');
disp('or does it contain a whole set ranging for example from Trial1 to Trial9?(INPUT:Single or Whole)'); 
   
prompt='';
 
LO_SH = input(prompt, 's');
 
if strcmp(LO_SH, 'Single')
 
 if UserParts == 2 
     
   numTrials = 2+1;
   
   VariablesT = ["Participants", "P1", "P2"];
   
 elseif UserParts == 1 
     
   numTrials = 1+1;
   
   VariablesT = ["Participants", "P1"];
     
 end
 
elseif strcmp(LO_SH, 'Whole')
    
    VariablesT = Variables;
 
end
   
   DataT(1,1) = {importfile3('Template_Type3.txt', VariablesT, numTrials)};

% import Find_Typei.txt file for customized analysation 

 DataF(1,1) = {importfile4('Find_Type1.txt')};

 %disp(DataF{1,1});

%% shorten sequences to not successive characters; example AAABBCCCCCABBC to ABCABC 
while (true)
      
 while (true)
 prompt = 'Do you want to shorten the sequences? For example from AAABBCCCCCABBC to ABCABC?(INPUT:yes or no)\n';

 Gonogo = input(prompt, 's');

  if strcmp(Gonogo, 'yes')
    
%Participants:
  for i1 = 1:size(DataN,1)
    
 for i2 = 1:size(DataN{i1,1},1)
    
    SeqShort_N{i1,1}{i2,1} = convertStringsToChars(DataN{i1,1}{i2,1});
    
     for j = 2:size(DataN{i1,1},2) 
         
          if length(convertStringsToChars(DataN{i1,1}{i2,j})) < 2
             
             SeqShort_N{i1,1}{i2,j} = [];
             
          else
              
          SeqShort_N{i1,1}{i2,j} = seq_slimmer(convertStringsToChars(DataN{i1,1}{i2,j}));
       
         end
      
     end
     
 end

end

%Experts:
  for i1 = 1:size(DataE,1)
    
 for i2 = 1:size(DataE{i1,1},1)
    
    SeqShort_E{i1,1}{i2,1} = convertStringsToChars(DataE{i1,1}{i2,1});
    
     for j = 2:size(DataE{i1,1},2) 
         
          if length(convertStringsToChars(DataE{i1,1}{i2,j})) < 2
             
             SeqShort_E{i1,1}{i2,j} = 'too short';
             
          else
              
          SeqShort_E{i1,1}{i2,j} = seq_slimmer(convertStringsToChars(DataE{i1,1}{i2,j}));
       
         end
      
     end
     
 end

end

%Templates:

  for i1 = 1:size(DataT,1)
    
 for i2 = 1:size(DataT{i1,1},1)
    
    SeqShort_T{i1,1}{i2,1} = convertStringsToChars(DataT{i1,1}{i2,1});
    
     for j = 2:size(DataT{i1,1},2) 
         
          if length(convertStringsToChars(DataT{i1,1}{i2,j})) < 2
             
             SeqShort_T{i1,1}{i2,j} = 'too short';
             
          else
              
          SeqShort_T{i1,1}{i2,j} = seq_slimmer(convertStringsToChars(DataT{i1,1}{i2,j}));
       
         end
      
     end
     
 end

  end
 
  break;

  elseif strcmp(Gonogo, 'no')
    
     disp('The sequences are not shortened');
     SeqShort_N{1,1} = cellstr(DataN{1,1});
     SeqShort_E{1,1} = cellstr(DataE{1,1});
     SeqShort_T{1,1} = cellstr(DataT{1,1});
     break; 
     
  else 
    
    disp('Wrong INPUT, start again');
    
  end
  
 end
 
 break;
 
end
%% Calculate Levenshtein dist and Damerau-Levenshtein dist between Expert and Participants 

Variables = cell(convertStringsToChars(Variables));

[Distances,UserDec,AppearanceN,AppearanceE,T_A_N_names,T_A_E_names] = score_calc2(SeqShort_N, SeqShort_E, SeqShort_T, DataF, UserParts, numN, numE, Variables, LO_SH);

if strcmp(UserDec, 'no')
    
disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');
disp('The sequences of the novices and experts were compared with the beforehand provided template');
disp('and these were the corresponding Levenshtein distances:');    
disp(Distances.DistN);
disp(Distances.DistE);

elseif strcmp(UserDec, 'yes')

disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');
disp('The sequences of the novices and experts were compared with the beforehand provided template');
disp('and these were the corresponding Levenshtein distances(top table) and Damerau-Levenshtein distances(bottom table):');
disp(Distances.DistN{1,1});
disp(Distances.DistN{2,1});
disp(Distances.DistE{1,1});
disp(Distances.DistE{2,1});

end

% writetable(Distances.DistN, 'Participants_Type2_LevD_to_TiPi_short.xlsx');
% writetable(Distances.DistE, 'Experts_Type2_LevD_to_TiPi_short.xlsx');

%% find user-defined AOI's or patterns of AOI's

disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');
disp('The sequences have been analysed according to the custom inputs and were stored in the Find_Type1_P/E_Appearances.xlsx:');
disp('Each sheet stands for the corresponding Participant/Expert provided in your text-files.');

% for i = 1:size(SeqShort_N{1,1},1)
%     
%   writetable(AppearanceN.(T_A_N_names(i,1)), 'Find_Type1_Participants_Appearances.xlsx', 'Sheet', i);
% 
% end
% 
% for i = 1:size(SeqShort_E{1,1},1)
%     
%   writetable(AppearanceE.(T_A_E_names(i,1)), 'Find_Type1_Experts_Appearances.xlsx', 'Sheet', i);
% 
% end








