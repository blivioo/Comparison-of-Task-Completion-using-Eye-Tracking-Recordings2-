%%function for eye-tracking perf. feedback:

function [Distances,UserDistance,AppearanceN,AppearanceE,T_A_N_names,T_A_E_names] = score_calc2(seqN, seqE, seqT, seqF, UserInput, numN, numE, VariableNames, All_Trials)
%% Let user choose template if there is one provided: 
 
NRow = 1; 
ERow = 1;

 if (UserInput == 2) && strcmp(All_Trials, 'Single')
    
   TEMPL_P1 = string(seqT{1,1}{1,2});
   TEMPL_P2 = string(seqT{1,1}{1,3});

 elseif (UserInput == 1) && strcmp(All_Trials, 'Single')
     
    TEMPL_P1 = string(seqT{1,1}{1,2});
 
 elseif (UserInput == 2) && strcmp(All_Trials, 'Whole')
   
   countcol1 = 1;
   
   for i = 2:2:size(seqT{1,1},2)
         
   TEMPL_P1(1,countcol1) = string(seqT{1,1}{1,i});
   TEMPL_P2(1,countcol1) = string(seqT{1,1}{1,i+1});
    
   countcol1 = countcol1+1;
   end
   
 elseif (UserInput == 1) && strcmp(All_Trials, 'Whole')    
   
   countcol1 = 1;
   
   for i = 2:size(seqT{1,1},2)
       
     TEMPL_P1(1,countcol1) = string(seqT{1,1}{1,i});
     
     countcol1 = countcol1+1;
   end
   
 end

%% assign data to number of participant-variables(Novices/Experts) to calculate edit-distances:

for j = 1:numN
   
   my_variablesN = sprintf('seq_N%d', j);
   NovicesS(1).(my_variablesN) = seqN{j,1};
   NSeqNames(j,1) = convertCharsToStrings(my_variablesN);
   
   my_variablesN = sprintf('L_P1_N%d', j);
   NovicesD1(1).(my_variablesN) = {};
   N_NamesD1(j,1) = convertCharsToStrings(my_variablesN);
   
   my_variablesN = sprintf('D_L_P1_N%d', j);
   NovicesD1(1).(my_variablesN) = {};
   N_NamesD1(j+numN,1) = convertCharsToStrings(my_variablesN);

   my_variablesN = sprintf('L_P2_N%d', j);
   NovicesD2(1).(my_variablesN) = {};
   N_NamesD2(j,1) = convertCharsToStrings(my_variablesN);
   
   my_variablesN = sprintf('D_L_P2_N%d', j);
   NovicesD2(1).(my_variablesN) = {};
   N_NamesD2(j+numN,1) = convertCharsToStrings(my_variablesN);

   my_variablesN = sprintf('allD_N%d', j);
   AllDN(1).(my_variablesN) = [];
   AllDN_names(j,1) = convertCharsToStrings(my_variablesN);
   
   my_variablesN = sprintf('TN%d', j);
   my_variablesN_L = sprintf('L_DN%d', j);
   my_variablesN_DL = sprintf('DL_DN%d', j);
   AllTN(1).(my_variablesN) = [];
   AllTN_names(j,1) = convertCharsToStrings(my_variablesN);
   AllTN_names(j,2) = convertCharsToStrings(my_variablesN_L);
   AllTN_names(j,3) = convertCharsToStrings(my_variablesN_DL);
% 
%    my_variablesN = sprintf('ScoresN%d', j);
%    ScoresN(1).(my_variablesN) = [];
%    ScoresN_names(j,1) = convertCharsToStrings(my_variablesN);
    
end

for j = 1:size(seqN{1,1},1)
    
   my_variablesN = sprintf('ScoresN%d', j);
   ScoresN(1).(my_variablesN) = [];
   ScoresN_names(j,1) = convertCharsToStrings(my_variablesN);
   
   my_variablesN = sprintf('T_A_N%d', j);
   T_A_N(1).(my_variablesN) = [];
   T_A_N_names(j,1) = convertCharsToStrings(my_variablesN);   
    
end

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
   
%    my_variablesE = sprintf('ScoresE%d', j);
%    ScoresE(1).(my_variablesE) = [];
%    ScoresE_names(j,1) = convertCharsToStrings(my_variablesE);
   
end

for j = 1:size(seqE{1,1},1)
    
   my_variablesE = sprintf('ScoresE%d', j);
   ScoresE(1).(my_variablesE) = [];
   ScoresE_names(j,1) = convertCharsToStrings(my_variablesE);
   
   my_variablesE = sprintf('T_A_E%d', j);
   T_A_E(1).(my_variablesE) = [];
   T_A_E_names(j,1) = convertCharsToStrings(my_variablesE);   
   
end
%% calculate distances for single partitioned surgery 

if UserInput == 1
    
while (true)
    
while (true)
    
 prompt = 'Would you like to calculate the Levenshtein-Dist. and the Damerau-Levenshtein-Dist.?(INPUT:yes or no)\n';
 UserDistance = input(prompt,'s');

 if strcmp(UserDistance,'no')
%%Levenshtein-dist.:
 
%Novices:
    
    for j = 1:size(NovicesS(1).(NSeqNames(NRow,1)),1)
        
        colcount = 1;
        
        for k = 2:size(NovicesS(1).(NSeqNames(NRow,1)),2)
            
         NovicesD1(1).(N_NamesD1(NRow,1)){j,k-1} = L_distance(char(convertStringsToChars(TEMPL_P1(1,colcount))),char(convertStringsToChars(NovicesS(1).(NSeqNames(NRow,1)){j,k}))); 
         
         if strcmp(All_Trials, 'Whole')    
         colcount = colcount + 1;
         end
        end
        
    end
       
        AllDN(1).(AllDN_names(NRow,1)){1,1} = cell2mat(NovicesD1(1).(N_NamesD1(NRow,1)));

        AllTN(1).(AllTN_names(NRow,1)) = array2table(AllDN(1).(AllDN_names(NRow,1)){1,1}, 'VariableNames', VariableNames(1,2:end), 'RowNames', ...
        NovicesS(1).(NSeqNames(NRow,1))(1:end,1));

%Experts:

    for j = 1:size(ExpertsS(1).(ESeqNames(numE,1)),1)
        
        colcount = 1;
        for k = 2:size(ExpertsS(1).(ESeqNames(ERow,1)),2)
       
         ExpertsD1(1).(E_NamesD1(ERow,1)){j,k-1} = L_distance(char(convertStringsToChars(TEMPL_P1(1,colcount))),char(convertStringsToChars(ExpertsS(1).(ESeqNames(ERow,1)){j,k}))); 
         if strcmp(All_Trials, 'Whole')
         colcount = colcount + 1;
         end
        end
        
    end
       
        AllDE(1).(AllDE_names(ERow,1)){1,1} = cell2mat(ExpertsD1(1).(E_NamesD1(ERow,1))); 
   
        AllTE(1).(AllTE_names(ERow,1)) = array2table(AllDE(1).(AllDE_names(ERow,1)){1,1}, 'VariableNames', VariableNames(1,2:end), 'RowNames', ...
        ExpertsS(1).(ESeqNames(ERow,1))(1:end,1));
        
        Distances(1).DistN = AllTN(1).(AllTN_names(NRow,1));
        Distances(1).DistE = AllTE(1).(AllTE_names(ERow,1));
        break;

%% calculate Levenshtein-Dist. and Damerau-Levenshtein-Dist. 

%choose sequences in seq array to calculate edit distance in comparison to
%template 
 elseif strcmp(UserDistance,'yes')

%Levenshtein Dist.:
%Novices
    for j = 1:size(NovicesS(1).(NSeqNames(NRow,1)),1)
        
        colcount = 1;
        for k = 2:size(NovicesS(1).(NSeqNames(NRow,1)),2)
            
         NovicesD1(1).(N_NamesD1(NRow,1)){j,k-1} = L_distance(char(convertStringsToChars(TEMPL_P1(1,colcount))),char(convertStringsToChars(NovicesS(1).(NSeqNames(NRow,1)){j,k}))); 
         if strcmp(All_Trials, 'Whole')
         colcount = colcount + 1;
         end
        end
        
    end

%Experts:
    for j = 1:size(ExpertsS(1).(ESeqNames(numE,1)),1)
        
        colcount = 1;
        for k = 2:size(ExpertsS(1).(ESeqNames(ERow,1)),2)
       
         ExpertsD1(1).(E_NamesD1(ERow,1)){j,k-1} = L_distance(char(convertStringsToChars(TEMPL_P1(1,colcount))),char(convertStringsToChars(ExpertsS(1).(ESeqNames(ERow,1)){j,k}))); 
         if strcmp(All_Trials, 'Whole')
         colcount = colcount + 1;
         end
        end
        
    end

%Damerau-Levenshtein Dist.:    
%Novices: 
    for j = 1:size(NovicesS(1).(NSeqNames(NRow,1)),1)
        
        colcount = 1;
        for k = 2:size(NovicesS(1).(NSeqNames(NRow,1)),2)

         NovicesD2(1).(N_NamesD2(NRow,1)){j,k-1} = damerau_levenshtein(char(convertStringsToChars(TEMPL_P1(1,colcount))),char(convertStringsToChars(NovicesS(1).(NSeqNames(NRow,1)){j,k}))); 
         if strcmp(All_Trials, 'Whole')
         colcount = colcount + 1;
         end
        end
        
    end

    AllDN(1).(AllDN_names(NRow,1)){1,1} = cell2mat(NovicesD1(1).(N_NamesD1(NRow,1)));
    AllDN(1).(AllDN_names(NRow,1)){2,1} = cell2mat(NovicesD2(1).(N_NamesD2(NRow,1)));

    AllTN(1).(AllTN_names(NRow,1)){1,1} = array2table(AllDN(1).(AllDN_names(NRow,1)){1,1}, 'VariableNames', VariableNames(1,2:end), ... 
       'RowNames', NovicesS(1).(NSeqNames(NRow,1))(1:end,1));
    AllTN(1).(AllTN_names(NRow,1)){2,1} = array2table(AllDN(1).(AllDN_names(NRow,1)){2,1}, 'VariableNames', VariableNames(1,2:end), ... 
           'RowNames', NovicesS(1).(NSeqNames(NRow,1))(1:end,1));

%Experts:
    for j = 1:size(ExpertsS(1).(ESeqNames(numE,1)),1)
        
        colcount = 1;
        for k = 2:size(ExpertsS(1).(ESeqNames(ERow,1)),2)
         
         ExpertsD2(1).(E_NamesD2(ERow,1)){j,k-1} = damerau_levenshtein(char(convertStringsToChars(TEMPL_P1(1,colcount))),char(convertStringsToChars(ExpertsS(1).(ESeqNames(ERow,1)){j,k}))); 
         if strcmp(All_Trials, 'Whole')
         colcount = colcount + 1;
         end
        end
        
    end

        AllDE(1).(AllDE_names(ERow,1)){1,1} = cell2mat(ExpertsD1(1).(E_NamesD1(ERow,1)));
        AllDE(1).(AllDE_names(ERow,1)){2,1} = cell2mat(ExpertsD2(1).(E_NamesD2(ERow,1)));

        AllTE(1).(AllTE_names(ERow,1)){1,1} = array2table(AllDE(1).(AllDE_names(ERow,1)){1,1}, 'VariableNames', VariableNames(1,2:end), ... 
           'RowNames', ExpertsS(1).(ESeqNames(ERow,1))(1:end,1));
        AllTE(1).(AllTE_names(ERow,1)){2,1} = array2table(AllDE(1).(AllDE_names(ERow,1)){2,1}, 'VariableNames', VariableNames(1,2:end), ... 
           'RowNames', ExpertsS(1).(ESeqNames(ERow,1))(1:end,1));  

        Distances(1).DistN = AllTN(1).(AllTN_names(NRow,1));
        Distances(1).DistE = AllTE(1).(AllTE_names(ERow,1));
       
       break;

 else disp('WRONG INPUT');
  
 end

end

 break;
 
end
        
%% calculate distances for two partitioned surgery 

elseif UserInput == 2
    
while (true)
    
while (true)
    
 prompt = 'Would you like to calculate the Levenshtein-Dist. and the Damerau-Levenshtein-Dist.?(INPUT:yes or no)\n';
 UserDistance = input(prompt,'s');

 if strcmp(UserDistance,'no')
%%Levenshtein-dist.:
 
%Novices:
    
    for j = 1:size(NovicesS(1).(NSeqNames(NRow,1)),1)
        
        colcount = 1;
        
        for k = 2:2:size(NovicesS(1).(NSeqNames(NRow,1)),2)
            
         NovicesD1(1).(N_NamesD1(NRow,1)){j,k-1} = L_distance(char(convertStringsToChars(TEMPL_P1(1,colcount))),char(convertStringsToChars(NovicesS(1).(NSeqNames(NRow,1)){j,k}))); 
   
         NovicesD1(1).(N_NamesD1(NRow,1)){j,k} = L_distance(char(convertStringsToChars(TEMPL_P2(1,colcount))),char(convertStringsToChars(NovicesS(1).(NSeqNames(NRow,1)){j,k+1}))); 
         
         if strcmp(All_Trials, 'Whole')
         colcount = colcount + 1;
         end
        end
        
    end
       
        AllDN(1).(AllDN_names(NRow,1)){1,1} = cell2mat(NovicesD1(1).(N_NamesD1(NRow,1)));

        AllTN(1).(AllTN_names(NRow,1)) = array2table(AllDN(1).(AllDN_names(NRow,1)){1,1}, 'VariableNames', VariableNames(1,2:end), 'RowNames', ...
        NovicesS(1).(NSeqNames(NRow,1))(1:end,1));
     
%Experts:

    for j = 1:size(ExpertsS(1).(ESeqNames(numE,1)),1)
        
        colcount = 1;
        
        for k = 2:2:size(ExpertsS(1).(ESeqNames(ERow,1)),2)
       
         ExpertsD1(1).(E_NamesD1(ERow,1)){j,k-1} = L_distance(char(convertStringsToChars(TEMPL_P1(1,colcount))),char(convertStringsToChars(ExpertsS(1).(ESeqNames(ERow,1)){j,k}))); 
   
         ExpertsD1(1).(E_NamesD1(ERow,1)){j,k} = L_distance(char(convertStringsToChars(TEMPL_P2(1,colcount))),char(convertStringsToChars(ExpertsS(1).(ESeqNames(ERow,1)){j,k+1}))); 
         
         if strcmp(All_Trials, 'Whole')
         colcount = colcount + 1;
         end
        end
        
    end
       
        AllDE(1).(AllDE_names(ERow,1)){1,1} = cell2mat(ExpertsD1(1).(E_NamesD1(ERow,1)));
   
        AllTE(1).(AllTE_names(ERow,1)) = array2table(AllDE(1).(AllDE_names(ERow,1)){1,1}, 'VariableNames', VariableNames(1,2:end), 'RowNames', ...
        ExpertsS(1).(ESeqNames(ERow,1))(1:end,1));
        
        Distances(1).DistN = AllTN(1).(AllTN_names(NRow,1));
        Distances(1).DistE = AllTE(1).(AllTE_names(ERow,1));
        
        break;


%% calculate Levenshtein-Dist. and Damerau-Levenshtein-Dist. 

%choose sequences in seq array to calculate edit distance in comparison to
%template 
 elseif strcmp(UserDistance,'yes')
 
%Levenshtein Dist.:
%Novices
    for j = 1:size(NovicesS(1).(NSeqNames(NRow,1)),1)
        
        colcount = 1;
        
        for k = 2:2:size(NovicesS(1).(NSeqNames(NRow,1)),2)
            
         NovicesD1(1).(N_NamesD1(NRow,1)){j,k-1} = L_distance(char(convertStringsToChars(TEMPL_P1(1,colcount))),char(convertStringsToChars(NovicesS(1).(NSeqNames(NRow,1)){j,k}))); 
   
         NovicesD1(1).(N_NamesD1(NRow,1)){j,k} = L_distance(char(convertStringsToChars(TEMPL_P2(1,colcount))),char(convertStringsToChars(NovicesS(1).(NSeqNames(NRow,1)){j,k+1}))); 
         
         if strcmp(All_Trials, 'Whole')
         colcount = colcount + 1;
         end
        end
        
    end

%Experts:
    for j = 1:size(ExpertsS(1).(ESeqNames(numE,1)),1)
        
        colcount = 1;
        
        for k = 2:2:size(ExpertsS(1).(ESeqNames(ERow,1)),2)
       
         ExpertsD1(1).(E_NamesD1(ERow,1)){j,k-1} = L_distance(char(convertStringsToChars(TEMPL_P1(1,colcount))),char(convertStringsToChars(ExpertsS(1).(ESeqNames(ERow,1)){j,k}))); 
   
         ExpertsD1(1).(E_NamesD1(ERow,1)){j,k} = L_distance(char(convertStringsToChars(TEMPL_P2(1,colcount))),char(convertStringsToChars(ExpertsS(1).(ESeqNames(ERow,1)){j,k+1}))); 
         
         if strcmp(All_Trials, 'Whole')
         colcount = colcount + 1;
         end
         
        end
        
    end

%Damerau-Levenshtein Dist.:
%Novices: 

    for j = 1:size(NovicesS(1).(NSeqNames(NRow,1)),1)
        
        colcount = 1;
        
      for k = 2:2:size(NovicesS(1).(NSeqNames(NRow,1)),2)
       
         NovicesD2(1).(N_NamesD2(NRow,1)){j,k-1} = damerau_levenshtein(char(convertStringsToChars(TEMPL_P1(1,colcount))),char(convertStringsToChars(NovicesS(1).(NSeqNames(NRow,1)){j,k}))); 
   
         NovicesD2(1).(N_NamesD2(NRow,1)){j,k} = damerau_levenshtein(char(convertStringsToChars(TEMPL_P2(1,colcount))),char(convertStringsToChars(NovicesS(1).(NSeqNames(NRow,1)){j,k+1}))); 
         
         if strcmp(All_Trials, 'Whole')
         colcount = colcount + 1;
         end
         
      end
      
    end 

        AllDN(1).(AllDN_names(NRow,1)){1,1} = cell2mat(NovicesD1(1).(N_NamesD1(NRow,1)));
        AllDN(1).(AllDN_names(NRow,1)){2,1} = cell2mat(NovicesD2(1).(N_NamesD2(NRow,1)));

        AllTN(1).(AllTN_names(NRow,1)){1,1} = array2table(AllDN(1).(AllDN_names(NRow,1)){1,1}, 'VariableNames', VariableNames(1,2:end), ... 
           'RowNames', NovicesS(1).(NSeqNames(NRow,1))(1:end,1));
        AllTN(1).(AllTN_names(NRow,1)){2,1} = array2table(AllDN(1).(AllDN_names(NRow,1)){2,1}, 'VariableNames', VariableNames(1,2:end), ... 
           'RowNames', NovicesS(1).(NSeqNames(NRow,1))(1:end,1));
  
%Experts:

    for j = 1:size(ExpertsS(1).(ESeqNames(ERow,1)),1)
        
        colcount = 1;
        
      for k = 2:2:size(ExpertsS(1).(ESeqNames(ERow,1)),2)
       
         ExpertsD2(1).(E_NamesD2(ERow,1)){j,k-1} = damerau_levenshtein(char(convertStringsToChars(TEMPL_P1(1,colcount))),char(convertStringsToChars(ExpertsS(1).(ESeqNames(ERow,1)){j,k}))); 
   
         ExpertsD2(1).(E_NamesD2(ERow,1)){j,k} = damerau_levenshtein(char(convertStringsToChars(TEMPL_P2(1,colcount))),char(convertStringsToChars(ExpertsS(1).(ESeqNames(ERow,1)){j,k+1}))); 
         
         if strcmp(All_Trials, 'Whole')
         colcount = colcount + 1;
         end
         
      end
      
    end 

        AllDE(1).(AllDE_names(ERow,1)){1,1} = cell2mat(ExpertsD1(1).(E_NamesD1(ERow,1)));
        AllDE(1).(AllDE_names(ERow,1)){2,1} = cell2mat(ExpertsD2(1).(E_NamesD2(ERow,1)));

        AllTE(1).(AllTE_names(ERow,1)){1,1} = array2table(AllDE(1).(AllDE_names(ERow,1)){1,1}, 'VariableNames', VariableNames(1,2:end), ... 
           'RowNames', ExpertsS(1).(ESeqNames(ERow,1))(1:end,1));
        AllTE(1).(AllTE_names(ERow,1)){2,1} = array2table(AllDE(1).(AllDE_names(ERow,1)){2,1}, 'VariableNames', VariableNames(1,2:end), ... 
           'RowNames', ExpertsS(1).(ESeqNames(ERow,1))(1:end,1));
       
       Distances(1).DistN = AllTN(1).(AllTN_names(NRow,1));
       Distances(1).DistE = AllTE(1).(AllTE_names(ERow,1));
       
       break;
  
 else disp('WRONG INPUT');
    
 end
 
end

 break;
 
end

end

%% Find specific AOI/AOI-pattern appearances in sequences: 
    
score_calc2_custom;
    

end







