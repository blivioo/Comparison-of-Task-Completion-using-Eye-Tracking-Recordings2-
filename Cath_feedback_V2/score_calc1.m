%% function for surgeon perf. feedback:
function [Scores,Scores_Track,ScoreN_Names,ScoreE_Names,TrackN_Names,TrackE_Names] = score_calc1(seqN, seqE, seqT, seqPF, UserInput, numN, numE)
%% Let user choose template if there is one provided: 

  prompt = 'Which template of your template-file would you like to use?(INPUT:Number of specific row in template-file)\n';
  
  TRowPF = input(prompt);
     
     if (TRowPF == 1) && (UserInput == 2) 
    
       TEMPL_P1 = convertStringsToChars(seqT{1,1}{1,2});
       TEMPL_P2 = convertStringsToChars(seqT{1,1}{1,3});
    
     elseif (TRowPF == 2) && (UserInput == 2) 
    
       TEMPL_P1 = convertStringsToChars(seqT{1,1}{2,2});
       TEMPL_P2 = convertStringsToChars(seqT{1,1}{2,3});
     
     elseif (TRowPF == 3) && (UserInput == 2) 
    
       TEMPL_P1 = convertStringsToChars(seqT{1,1}{3,2});
       TEMPL_P2 = convertStringsToChars(seqT{1,1}{3,3});
       
     elseif (TRowPF == 4) && (UserInput == 2) 
    
       TEMPL_P1 = convertStringsToChars(seqT{1,1}{4,2});
       TEMPL_P2 = convertStringsToChars(seqT{1,1}{4,3});
       
     elseif (TRowPF == 5) && (UserInput == 2) 
    
       TEMPL_P1 = convertStringsToChars(seqT{1,1}{5,2});
       TEMPL_P2 = convertStringsToChars(seqT{1,1}{5,3});
     
     elseif (TRowPF == 1) && (UserInput == 1) 
    
       TEMPL_P1 = convertStringsToChars(seqT{1,1}{1,2});
       
     elseif (TRowPF == 2) && (UserInput == 1) 
    
       TEMPL_P1 = convertStringsToChars(seqT{1,1}{2,2});
       
     elseif (TRowPF == 3) && (UserInput == 1) 
    
       TEMPL_P1 = convertStringsToChars(seqT{1,1}{3,2});
      
     elseif (TRowPF == 4) && (UserInput == 1) 
    
       TEMPL_P1 = convertStringsToChars(seqT{1,1}{4,2});
      
     elseif (TRowPF == 5) && (UserInput == 1) 
    
       TEMPL_P1 = convertStringsToChars(seqT{1,1}{5,2});
       
     end

%% assign data to number of participant-variables(Novices/Experts) to calculate edit-distances:

for j = 1:numN
   %dynamic creation of variables needed for the score calculation according
   %to users data size:
   %generate variable needed
   my_variablesN = sprintf('seq_N%d', j);
   %store it in struct and asign data of novices seqN
   NovicesS(1).(my_variablesN) = seqN{j,1};
   %generate string with all struct variable names to be able to use loops
   %for calculation
   NSeqNames(j,1) = convertCharsToStrings(my_variablesN);
   
   %variables for respectively levenshtein distance storage for part 1 of
   %surgery 
   my_variablesN = sprintf('L_P1_N%d', j);
   NovicesD1(1).(my_variablesN) = {};
   N_NamesD1(j,1) = convertCharsToStrings(my_variablesN);
   
   %variables for respectively damerau-levenshtein distance storage part 1 
   %of surgery 
   my_variablesN = sprintf('D_L_P1_N%d', j);
   NovicesD1(1).(my_variablesN) = {};
   N_NamesD1(j+numN,1) = convertCharsToStrings(my_variablesN);
   
   %same for part2
   my_variablesN = sprintf('L_P2_N%d', j);
   NovicesD2(1).(my_variablesN) = {};
   N_NamesD2(j,1) = convertCharsToStrings(my_variablesN);
   
   %same for part2
   my_variablesN = sprintf('D_L_P2_N%d', j);
   NovicesD2(1).(my_variablesN) = {};
   N_NamesD2(j+numN,1) = convertCharsToStrings(my_variablesN);
   
   %struct to store all the distances to display data in overall table per
   %participant
   my_variablesN = sprintf('allD_N%d', j);
   AllDN(1).(my_variablesN) = [];
   AllDN_names(j,1) = convertCharsToStrings(my_variablesN);
   
   %table structs to store tables containing distances: 
   my_variablesN = sprintf('TN%d', j);
   my_variablesN_L = sprintf('L_DN%d', j);
   my_variablesN_DL = sprintf('DL_DN%d', j);
   AllTN(1).(my_variablesN) = [];
   AllTN_names(j,1) = convertCharsToStrings(my_variablesN);
   AllTN_names(j,2) = convertCharsToStrings(my_variablesN_L);
   AllTN_names(j,3) = convertCharsToStrings(my_variablesN_DL);

   %struct to save scores of novices:
   my_variablesN = sprintf('ScoresN%d', j);
   ScoresN(1).(my_variablesN) = [];
   ScoresN_names(j,1) = convertCharsToStrings(my_variablesN);
   
   %struct to save scores_track of novices:
   my_variablesN = sprintf('Scores_TrackN%d', j);
   Scores_TrackN(1).(my_variablesN) = [];
   Scores_TrackN_names(j,1) = convertCharsToStrings(my_variablesN);
   
   %tables stored in struct with the scores and score-track to display
   %results in a organised way: 
   my_variablesN = sprintf('T_ScoreN%d', j);
   T_ScoreN(1).(my_variablesN) = [];
   T_ScoreN_names(j,1) = convertCharsToStrings(my_variablesN);   

   my_variablesN = sprintf('T_TrackN%d', j);
   T_TrackN(1).(my_variablesN) = [];
   T_TrackN_names(j,1) = convertCharsToStrings(my_variablesN);      
    
end

%same for expert-data, see explanation above: 
for j = 1:numE
    
   my_variablesE = sprintf('seq_E%d', j);
   ExpertsS(1).(my_variablesE) = seqE{j,1};
   ESeqNames(j,1) = convertCharsToStrings(my_variablesE);
   
   my_variablesE = sprintf('L_P1_E%d', j);
   ExpertsD1(1).(my_variablesE) = {};  
   E_NamesD1(j,1) = convertCharsToStrings(my_variablesE);
   
   my_variablesE = sprintf('D_L_P1_E%d', j);
   ExpertsD1(1).(my_variablesE) = {};  
   E_NamesD1(j+numE,1) = convertCharsToStrings(my_variablesE);
   
   my_variablesE = sprintf('L_P2_E%d', j);
   ExpertsD2(1).(my_variablesE) = {};
   E_NamesD2(j,1) = convertCharsToStrings(my_variablesE);
   
   my_variablesE = sprintf('D_L_P2_E%d', j);
   ExpertsD2(1).(my_variablesE) = {};
   E_NamesD2(j+numE,1) = convertCharsToStrings(my_variablesE);
   
   my_variablesE = sprintf('allD_E%d', j);
   AllDE(1).(my_variablesE) = [];
   AllDE_names(j,1) = convertCharsToStrings(my_variablesE);
   
   my_variablesE = sprintf('TE%d', j);
   my_variablesE_L = sprintf('L_DE%d', j);
   my_variablesE_DL = sprintf('DL_DE%d', j);
   AllTE(1).(my_variablesE) = [];
   AllTE_names(j,1) = convertCharsToStrings(my_variablesE);
   AllTE_names(j,2) = convertCharsToStrings(my_variablesE_L);
   AllTE_names(j,3) = convertCharsToStrings(my_variablesE_DL);
   
   my_variablesE = sprintf('ScoresE%d', j);
   ScoresE(1).(my_variablesE) = [];
   ScoresE_names(j,1) = convertCharsToStrings(my_variablesE);
   
   my_variablesE = sprintf('Scores_TrackE%d', j);
   Scores_TrackE(1).(my_variablesE) = [];
   Scores_TrackE_names(j,1) = convertCharsToStrings(my_variablesE);
   
   my_variablesE = sprintf('T_ScoreE%d', j);
   T_ScoreE(1).(my_variablesE) = [];
   T_ScoreE_names(j,1) = convertCharsToStrings(my_variablesE);
 
   my_variablesE = sprintf('T_TrackE%d', j);
   T_TrackE(1).(my_variablesE) = [];
   T_TrackE_names(j,1) = convertCharsToStrings(my_variablesE);
   
end

%% calculate edit-distances for single partitioned surgery 

if UserInput == 1
    
while (true)
    
while (true)
    
 prompt = 'Would you like to calculate the Levenshtein-Dist. and the Damerau-Levenshtein-Dist.?(INPUT:yes or no)\n';
 UserDistance = input(prompt,'s');

 if strcmp(UserDistance,'no')
%%Levenshtein-dist.:
 
  disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');
  disp('The sequences of the novices and experts were compared with the beforehand chosen template');
  disp('and these were the corresponding Levenshtein distances (and Damerau-Levenshtein distances):');
  
%Novices:
  for i = 1:numN
    
    for j = 1:size(NovicesS(1).(NSeqNames(i,1)),1)
         
         %calculate levenshtein dist. for each sequence and store it in
         %distance struct NovicesD1 where D1 stands for distances in part1
         %of surgery containing no further characteristic parts:
         NovicesD1(1).(N_NamesD1(i,1)){j,1} = L_distance(TEMPL_P1,convertStringsToChars(NovicesS(1).(NSeqNames(i,1)){j,2})); 
         
    end
        %put distances in display struct where cell is changed to a table
        %with the row and column names for this calculation: 
        AllDN(1).(AllDN_names(i,1)){1,1} = cell2mat(NovicesD1(1).(N_NamesD1(i,1)).');

        AllTN(1).(AllTN_names(i,1)) = cell2table(AllDN(1).(AllDN_names(i,1)), 'VariableNames', {'P1'}, 'RowNames', {convertStringsToChars(AllTN_names(i,2))});
        disp(AllTN(1).(AllTN_names(i,1)));
  
  end

%Experts: (same as above but for different type of participant) 
  for i = 1:numE
    
    for j = 1:size(ExpertsS(1).(ESeqNames(i,1)),1)
         
         %L_distance needs character vectors as input, therefore the
         %sequences must be converted to it: 
         ExpertsD1(1).(E_NamesD1(i,1)){j,1} = L_distance(TEMPL_P1,convertStringsToChars(ExpertsS(1).(ESeqNames(i,1)){j,2})); 
         
    end
       
        AllDE(1).(AllDE_names(i,1)){1,1} = cell2mat(ExpertsD1(1).(E_NamesD1(i,1)).');
   
        AllTE(1).(AllTE_names(i,1)) = cell2table(AllDE(1).(AllDE_names(i,1)), 'VariableNames', {'P1'}, 'RowNames', {convertStringsToChars(AllTE_names(i,2))});
        disp(AllTE(1).(AllTE_names(i,1)));
  
  end

%% calculate Levenshtein-Dist. and Damerau-Levenshtein-Dist. 
 
 elseif strcmp(UserDistance,'yes')
 
  disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');
  disp('The sequences of the novices and experts were compared with the beforehand chosen template');
  disp('and these were the corresponding Levenshtein distances (and Damerau-Levenshtein distances):');

%Fist levenshtein dist. is calculated
%Novices
  for i = 1:numN
    
   for j = 1:size(NovicesS(1).(NSeqNames(i,1)),1)
       
         NovicesD1(1).(N_NamesD1(i,1)){j,1} = L_distance(TEMPL_P1,convertStringsToChars(NovicesS(1).(NSeqNames(i,1)){j,2})); 
         
   end
   
  end

%Experts:
  for i = 1:numE
    
    for j = 1:size(ExpertsS(1).(ESeqNames(i,1)),1)
       
         ExpertsD1(1).(E_NamesD1(i,1)){j,1} = L_distance(TEMPL_P1,convertStringsToChars(ExpertsS(1).(ESeqNames(i,1)){j,2})); 
         
    end
   
  end

%in a second step damerau-levenshtein dist. is calculated: 
%Novices: 
  for i = 1:numN
    
    for j = 1:size(NovicesS(1).(NSeqNames(i,1)),1)
       
         NovicesD1(1).(N_NamesD1(i+numN,1)){j,1} = damerau_levenshtein(TEMPL_P1,convertStringsToChars(NovicesS(1).(NSeqNames(i,1)){j,2})); 
         
    end 
        
        %assign distances to struct with all distances and generate table
        %with row and column names according to participant names:
        AllDN(1).(AllDN_names(i,1)){1,1} = cell2mat(NovicesD1(1).(N_NamesD1(i,1)).');
        AllDN(1).(AllDN_names(i,1)){2,1} = cell2mat(NovicesD1(1).(N_NamesD1(i+numN,1)).');
        
        AllTN(1).(AllTN_names(i,1)) = cell2table(AllDN(1).(AllDN_names(i,1)), 'VariableNames', {'P1'}, ... 
           'RowNames', {convertStringsToChars(AllTN_names(i,2)), convertStringsToChars(AllTN_names(i,3))});
        disp(AllTN(1).(AllTN_names(i,1)));
   
  end

%Experts:
  for i = 1:numE
    
    for j = 1:size(ExpertsS(1).(ESeqNames(i,1)),1)
       
         ExpertsD1(1).(E_NamesD1(i+numE,1)){j,1} = damerau_levenshtein(TEMPL_P1,convertStringsToChars(ExpertsS(1).(ESeqNames(i,1)){j,2})); 
         
    end

        AllDE(1).(AllDE_names(i,1)){1,1} = cell2mat(ExpertsD1(1).(E_NamesD1(i,1)).');
        AllDE(1).(AllDE_names(i,1)){2,1} = cell2mat(ExpertsD1(1).(E_NamesD1(i+numE,1)).');
        
    
        AllTE(1).(AllTE_names(i,1)) = cell2table(AllDE(1).(AllDE_names(i,1)), 'VariableNames', {'P1'}, 'RowNames', ...
           {convertStringsToChars(AllTE_names(i,2)), convertStringsToChars(AllTE_names(i,3))});
        disp(AllTE(1).(AllTE_names(i,1)));
   
  end

 %if user types something else than yes or no the loop starts from the
 %beginning, ensuring no unintended error occurs: 
 else disp('WRONG INPUT');
    
     break;
    
 end

 break;
 
end

 break;
 
end
        
%% calculate distances for two partitioned surgery 
%here all the calculations have to be undertaken for part1 and part2: 
elseif UserInput == 2
    
while (true)
    
while (true)
    
 prompt = 'Would you like to calculate the Levenshtein-Dist. and the Damerau-Levenshtein-Dist.?(INPUT:yes or no)\n';
 UserDistance = input(prompt,'s');

 if strcmp(UserDistance,'no')
%%Levenshtein-dist.:
 
  disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');
  disp('The sequences of the novices and experts were compared with the beforehand chosen template');
  disp('and these were the corresponding Levenshtein distances (and Damerau-Levenshtein distances):');
  
%Novices:
  for i = 1:numN
    
    for j = 1:size(NovicesS(1).(NSeqNames(i,1)),1)
         
         NovicesD1(1).(N_NamesD1(i,1)){j,1} = L_distance(TEMPL_P1,convertStringsToChars(NovicesS(1).(NSeqNames(i,1)){j,2})); 
         %part2 distances get assigned to ...D2 struct, the rest stayes the
         %same as above for a single partitioned surgery 
         NovicesD2(1).(N_NamesD2(i,1)){j,1} = L_distance(TEMPL_P2,convertStringsToChars(NovicesS(1).(NSeqNames(i,1)){j,3})); 
         
    end
        
        % now in column 1 distances from part 1 get assigned and in column 2
        % distances from part 2:
        AllDN(1).(AllDN_names(i,1)){1,1} = cell2mat(NovicesD1(1).(N_NamesD1(i,1)).');
        AllDN(1).(AllDN_names(i,1)){1,2} = cell2mat(NovicesD2(1).(N_NamesD2(i,1)).');

        AllTN(1).(AllTN_names(i,1)) = cell2table(AllDN(1).(AllDN_names(i,1)), 'VariableNames', {'P1' 'P2'}, 'RowNames', {convertStringsToChars(AllTN_names(i,2))});
        disp(AllTN(1).(AllTN_names(i,1)));
  
  end

%Experts:
  for i = 1:numE
    
    for j = 1:size(ExpertsS(1).(ESeqNames(i,1)),1)
       
         ExpertsD1(1).(E_NamesD1(i,1)){j,1} = L_distance(TEMPL_P1,convertStringsToChars(ExpertsS(1).(ESeqNames(i,1)){j,2})); 
   
         ExpertsD2(1).(E_NamesD2(i,1)){j,1} = L_distance(TEMPL_P2,convertStringsToChars(ExpertsS(1).(ESeqNames(i,1)){j,3})); 
         
    end
       
        AllDE(1).(AllDE_names(i,1)){1,1} = cell2mat(ExpertsD1(1).(E_NamesD1(i,1)).');
        AllDE(1).(AllDE_names(i,1)){1,2} = cell2mat(ExpertsD2(1).(E_NamesD2(i,1)).'); 
   
        AllTE(1).(AllTE_names(i,1)) = cell2table(AllDE(1).(AllDE_names(i,1)), 'VariableNames', {'P1' 'P2'}, 'RowNames', {convertStringsToChars(AllTE_names(i,2))});
        disp(AllTE(1).(AllTE_names(i,1)));
  
  end

%% calculate Levenshtein-Dist. and Damerau-Levenshtein-Dist. 

 elseif strcmp(UserDistance,'yes')
 
  disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');
  disp('The sequences of the novices and experts were compared with the beforehand chosen template');
  disp('and these were the corresponding Levenshtein distances (and Damerau-Levenshtein distances):');
  
%Novices
  for i = 1:numN
    
   for j = 1:size(NovicesS(1).(NSeqNames(i,1)),1)
       
         NovicesD1(1).(N_NamesD1(i,1)){j,1} = L_distance(TEMPL_P1,convertStringsToChars(NovicesS(1).(NSeqNames(i,1)){j,2})); 
   
         NovicesD2(1).(N_NamesD2(i,1)){j,1} = L_distance(TEMPL_P2,convertStringsToChars(NovicesS(1).(NSeqNames(i,1)){j,3})); 
         
   end
   
  end

%Experts:
  for i = 1:numE
    
    for j = 1:size(ExpertsS(1).(ESeqNames(i,1)),1)
       
         ExpertsD1(1).(E_NamesD1(i,1)){j,1} = L_distance(TEMPL_P1,convertStringsToChars(ExpertsS(1).(ESeqNames(i,1)){j,2})); 
   
         ExpertsD2(1).(E_NamesD2(i,1)){j,1} = L_distance(TEMPL_P2,convertStringsToChars(ExpertsS(1).(ESeqNames(i,1)){j,3})); 
         
    end
   
  end
    
%Novices: 
  for i = 1:numN
    
    for j = 1:size(NovicesS(1).(NSeqNames(i,1)),1)
       
         % damerau levenshtein dist. get assigned to the damerau-levenshtein 
         % arrays called by their names N_NamesD1(i+numN,1) corresponding
         % to part 1 or 2 they belong to: 
         NovicesD1(1).(N_NamesD1(i+numN,1)){j,1} = damerau_levenshtein(TEMPL_P1,convertStringsToChars(NovicesS(1).(NSeqNames(i,1)){j,2})); 
   
         NovicesD2(1).(N_NamesD2(i+numN,1)){j,1} = damerau_levenshtein(TEMPL_P2,convertStringsToChars(NovicesS(1).(NSeqNames(i,1)){j,3})); 
         
    end 
        
        %for displayment all levenshtein distances per participant and per surgery
        %undertaken get assigned to row 1 and damerau-lev. dist. to row 2;
        %the differentiation between part 1 and part 2 is ensured by
        %putting part1 distances in column 1 and part 2 distances in column
        %2. as a example the first number in (1,1) stands for the
        %levenshtein distance for part 1 in the first surgery, and (1,2)
        %for the distance for part 2. 
        %the same structure is also applied to the damerau-lev. distances: 
        AllDN(1).(AllDN_names(i,1)){1,1} = cell2mat(NovicesD1(1).(N_NamesD1(i,1)).');
        AllDN(1).(AllDN_names(i,1)){1,2} = cell2mat(NovicesD2(1).(N_NamesD2(i,1)).');
        AllDN(1).(AllDN_names(i,1)){2,1} = cell2mat(NovicesD1(1).(N_NamesD1(i+numN,1)).');
        AllDN(1).(AllDN_names(i,1)){2,2} = cell2mat(NovicesD2(1).(N_NamesD2(i+numN,1)).');
        
        AllTN(1).(AllTN_names(i,1)) = cell2table(AllDN(1).(AllDN_names(i,1)), 'VariableNames', {'P1' 'P2'}, ... 
           'RowNames', {convertStringsToChars(AllTN_names(i,2)), convertStringsToChars(AllTN_names(i,3))});
        disp(AllTN(1).(AllTN_names(i,1)));
   
  end

%Experts:
  for i = 1:numE
    
    for j = 1:size(ExpertsS(1).(ESeqNames(i,1)),1)
       
         ExpertsD1(1).(E_NamesD1(i+numE,1)){j,1} = damerau_levenshtein(TEMPL_P1,convertStringsToChars(ExpertsS(1).(ESeqNames(i,1)){j,2})); 
   
         ExpertsD2(1).(E_NamesD2(i+numE,1)){j,1} = damerau_levenshtein(TEMPL_P2,convertStringsToChars(ExpertsS(1).(ESeqNames(i,1)){j,3})); 
         
    end

        AllDE(1).(AllDE_names(i,1)){1,1} = cell2mat(ExpertsD1(1).(E_NamesD1(i,1)).');
        AllDE(1).(AllDE_names(i,1)){1,2} = cell2mat(ExpertsD2(1).(E_NamesD2(i,1)).');
        AllDE(1).(AllDE_names(i,1)){2,1} = cell2mat(ExpertsD1(1).(E_NamesD1(i+numE,1)).');
        AllDE(1).(AllDE_names(i,1)){2,2} = cell2mat(ExpertsD2(1).(E_NamesD2(i+numE,1)).');
    
        AllTE(1).(AllTE_names(i,1)) = cell2table(AllDE(1).(AllDE_names(i,1)), 'VariableNames', {'P1' 'P2'}, 'RowNames', ...
           {convertStringsToChars(AllTE_names(i,2)), convertStringsToChars(AllTE_names(i,3))});
        disp(AllTE(1).(AllTE_names(i,1)));
   
  end

 else disp('WRONG INPUT');
    
     break;
    
 end

 break;
 
end

 break;
 
end

end
%% Calculate final Score of Novices/Experts: 

%to understand the score calculation read the first description in
%sequence_analysis.m

disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');
disp('For the calculation of the final score, only the Levenshtein distance is considered.')
InScore = 100; 

%1) Edit-Distance interval for first score calc.: 
%there are three intervals defined: 

if UserInput == 1

%Novices:
for i = 1:numN
   %check into which interval the respective distance calculated above falls 
   %and assign starting score according to the definde deductions per
   %interval
   for j = 1:size(NovicesS(1).(NSeqNames(i,1)),1)

    if (AllDN(1).(AllDN_names(i,1)){1,1}(1,j) >= 1) && (AllDN(1).(AllDN_names(i,1)){1,1}(1,j) <= 2)
        
       ScoresN(1).(ScoresN_names(i,1))(1,j) = InScore - 10;
       %keep track of what caused the score deduction with scores_track..
       %to be able to understand in the end how the score was calculated: 
       Scores_TrackN(1).(Scores_TrackN_names(i,1)){1,j} = (-10);
        
    elseif (AllDN(1).(AllDN_names(i,1)){1,1}(1,j) == 0)
        
       ScoresN(1).(ScoresN_names(i,1))(1,j) = InScore; 
       Scores_TrackN(1).(Scores_TrackN_names(i,1)){1,j} = 0;
       
    elseif (AllDN(1).(AllDN_names(i,1)){1,1}(1,j) >= 3) && (AllDN(1).(AllDN_names(i,1)){1,1}(1,j) <= 5)
        
        ScoresN(1).(ScoresN_names(i,1))(1,j) = InScore - 30;
        Scores_TrackN(1).(Scores_TrackN_names(i,1)){1,j} = (-30);
        
    elseif (AllDN(1).(AllDN_names(i,1)){1,1}(1,j) >= 6) 
        
        ScoresN(1).(ScoresN_names(i,1))(1,j) = InScore - 40;
        Scores_TrackN(1).(Scores_TrackN_names(i,1)){1,j} = (-40);
        
    end

   end

end

%Experts:
for i = 1:numE
      
   for j = 1:size(ExpertsS(1).(ESeqNames(i,1)),1)

    if (AllDE(1).(AllDE_names(i,1)){1,1}(1,j) >= 1) && (AllDE(1).(AllDE_names(i,1)){1,1}(1,j) <= 2)
        
       ScoresE(1).(ScoresE_names(i,1))(1,j) = InScore - 10;
       Scores_TrackE(1).(Scores_TrackE_names(i,1)){1,j} = (-10);
       
    elseif (AllDE(1).(AllDE_names(i,1)){1,1}(1,j) == 0)
        
       ScoresE(1).(ScoresE_names(i,1))(1,j) = InScore; 
       Scores_TrackE(1).(Scores_TrackE_names(i,1)){1,j} = 0;
       
    elseif (AllDE(1).(AllDE_names(i,1)){1,1}(1,j) >= 3) && (AllDE(1).(AllDE_names(i,1)){1,1}(1,j) <= 5)
        
        ScoresE(1).(ScoresE_names(i,1))(1,j) = InScore - 30;
        Scores_TrackE(1).(Scores_TrackE_names(i,1)){1,j} = (-30);
        
    elseif (AllDE(1).(AllDE_names(i,1)){1,1}(1,j) >= 6) 
        
        ScoresE(1).(ScoresE_names(i,1))(1,j) = InScore - 40;
        Scores_TrackE(1).(Scores_TrackE_names(i,1)){1,j} = (-40);
        
    end

   end

end

%do the same twice if the surgery contains part1 and part2:
elseif UserInput == 2

%Novices:
 for i = 1:numN
    
   k = 1;
      
   for j = 1:size(NovicesS(1).(NSeqNames(i,1)),1)
          
     if (AllDN(1).(AllDN_names(i,1)){1,1}(1,j) >= 1) && (AllDN(1).(AllDN_names(i,1)){1,1}(1,j) <= 2)
        
       ScoresN(1).(ScoresN_names(i,1))(1,k) = InScore - 10;
       
       Scores_TrackN(1).(Scores_TrackN_names(i,1)){1,k} = (-10);
       
       %use k as an independend running variable to assign infromation for
       %each surgery-part, part 1 and 2 next to each other in array before
       %switching to next surgery: 
       k = k+1;
         
     elseif (AllDN(1).(AllDN_names(i,1)){1,1}(1,j) == 0)
        
       ScoresN(1).(ScoresN_names(i,1))(1,k) = InScore;
       
       Scores_TrackN(1).(Scores_TrackN_names(i,1)){1,k} = 0;
       
       k = k+1;
       
     elseif (AllDN(1).(AllDN_names(i,1)){1,1}(1,j) >= 3) && (AllDN(1).(AllDN_names(i,1)){1,1}(1,j) <= 5)
        
       ScoresN(1).(ScoresN_names(i,1))(1,k) = InScore - 30;
       
       Scores_TrackN(1).(Scores_TrackN_names(i,1)){1,k} = (-30);
       
       k = k+1;
        
     elseif (AllDN(1).(AllDN_names(i,1)){1,1}(1,j) >= 6) 
        
       ScoresN(1).(ScoresN_names(i,1))(1,k) = InScore - 40;
       
       Scores_TrackN(1).(Scores_TrackN_names(i,1)){1,k} = (-40);
       
       k = k+1;
       
     end
     
     if (AllDN(1).(AllDN_names(i,1)){1,2}(1,j) >= 1) && (AllDN(1).(AllDN_names(i,1)){1,2}(1,j) <= 2)
        
       ScoresN(1).(ScoresN_names(i,1))(1,k) = InScore - 10; 
       
       Scores_TrackN(1).(Scores_TrackN_names(i,1)){1,k} = (-10);
       
       k = k+1;
     
     elseif (AllDN(1).(AllDN_names(i,1)){1,2}(1,j) == 0)
         
       ScoresN(1).(ScoresN_names(i,1))(1,k) = InScore; 
       
       Scores_TrackN(1).(Scores_TrackN_names(i,1)){1,k} = 0;
       
       k = k+1;       
       
     elseif (AllDN(1).(AllDN_names(i,1)){1,2}(1,j) >= 3) && (AllDN(1).(AllDN_names(i,1)){1,2}(1,j) <= 5)
         
       ScoresN(1).(ScoresN_names(i,1))(1,k) = InScore - 30;
       
       Scores_TrackN(1).(Scores_TrackN_names(i,1)){1,k} = (-30);
       
       k = k+1;       
          
     elseif (AllDN(1).(AllDN_names(i,1)){1,2}(1,j) >= 6) 
         
       ScoresN(1).(ScoresN_names(i,1))(1,k) = InScore - 40;
       
       Scores_TrackN(1).(Scores_TrackN_names(i,1)){1,k} = (-40);
       
       k = k+1;       

     end  

   end

 end 
 
%Experts:
 for i = 1:numE
     
  k = 1;
      
   for j = 1:size(ExpertsS(1).(ESeqNames(i,1)),1)
          
     if (AllDE(1).(AllDE_names(i,1)){1,1}(1,j) >= 1) && (AllDE(1).(AllDE_names(i,1)){1,1}(1,j) <= 2)
        
       ScoresE(1).(ScoresE_names(i,1))(1,k) = InScore - 10;
       
       Scores_TrackE(1).(Scores_TrackE_names(i,1)){1,k} = (-10);
       
       k = k+1;       
         
     elseif (AllDE(1).(AllDE_names(i,1)){1,1}(1,j) == 0)
        
       ScoresE(1).(ScoresE_names(i,1))(1,k) = InScore;
       
       Scores_TrackE(1).(Scores_TrackE_names(i,1)){1,k} = 0;
       
       k = k+1;         
       
     elseif (AllDE(1).(AllDE_names(i,1)){1,1}(1,j) >= 3) && (AllDE(1).(AllDE_names(i,1)){1,1}(1,j) <= 5)
        
       ScoresE(1).(ScoresE_names(i,1))(1,k) = InScore - 30;
       
       Scores_TrackE(1).(Scores_TrackE_names(i,1)){1,k} = (-30);
       
       k = k+1;         
        
     elseif (AllDE(1).(AllDE_names(i,1)){1,1}(1,j) >= 6) 
        
       ScoresE(1).(ScoresE_names(i,1))(1,k) = InScore - 40;
       
       Scores_TrackE(1).(Scores_TrackE_names(i,1)){1,k} = (-40);
       
       k = k+1;         

     end
     
     if (AllDE(1).(AllDE_names(i,1)){1,2}(1,j) >= 1) && (AllDE(1).(AllDE_names(i,1)){1,2}(1,j) <= 2)
        
       ScoresE(1).(ScoresE_names(i,1))(1,k) = InScore - 10; 
       
       Scores_TrackE(1).(Scores_TrackE_names(i,1)){1,k} = (-10);
       
       k = k+1;        
     
     elseif (AllDE(1).(AllDE_names(i,1)){1,2}(1,j) == 0)
         
       ScoresE(1).(ScoresE_names(i,1))(1,k) = InScore; 
       
       Scores_TrackE(1).(Scores_TrackE_names(i,1)){1,k} = 0;
       
       k = k+1;        
       
     elseif (AllDE(1).(AllDE_names(i,1)){1,2}(1,j) >= 3) && (AllDE(1).(AllDE_names(i,1)){1,2}(1,j) <= 5)
         
       ScoresE(1).(ScoresE_names(i,1))(1,k) = InScore - 30;
       
       Scores_TrackE(1).(Scores_TrackE_names(i,1)){1,k} = (-30);
       
       k = k+1;          
          
     elseif (AllDE(1).(AllDE_names(i,1)){1,2}(1,j) >= 6) 
         
       ScoresE(1).(ScoresE_names(i,1))(1,k) = InScore - 40;
       
       Scores_TrackE(1).(Scores_TrackE_names(i,1)){1,k} = (-40);
       
       k = k+1;          

     end  

   end

 end  
    
end

%2) User-provided crucial Perf.-Feedb. cases for rest of score:  

if UserInput == 2
  disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');  
  disp('Do you wish to use a predefined PF-template for the catheterization-score-calculation');
  disp('which contains crucial steps with already defined weighting factors for this surgery?(INPUT:yes or no)');
  
  %since the program was designed to analyse different surgeries but the
  %initial design was done to compare surgeons-vessel catheterization
  %skills before a minimal invasive cardiovascular surgery, there is a
  %already predefined "user-provided" crucial perf. feedback template which
  %the user can now choose to use or not: 
  prompt = '';
  UseTemp = input(prompt,'s');
  
  if strcmp(UseTemp, 'no')
      
   score_calc1_twopartitioned;
   
  elseif strcmp(UseTemp, 'yes')
      
   score_calc1_catheterization; 
      
  end
  
elseif UserInput == 1
  
  score_calc1_singlepartitioned;

end

Scores(1).Novices = T_ScoreN;
Scores(1).Experts = T_ScoreE;
Scores_Track.Novices = T_TrackN;
Scores_Track.Experts = T_TrackE;
ScoreN_Names = T_ScoreN_names;
ScoreE_Names = T_ScoreE_names;
TrackN_Names = T_TrackN_names;
TrackE_Names = T_TrackE_names;

end








