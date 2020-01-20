%% Score_calculation with single partitioned surgery:
disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');
disp(seqF{1,1});

prompt = 'How many AOI-patterns or single AOIs does your Find_Typei.txt file contain?(INPUT:number)\n';
  
numPF = input(prompt); 
 
  for j =1:numPF

   my_variablesPF = sprintf('PF_%d', j);
   PF(1).(my_variablesPF) = string(seqF{1,1}(j,2));
   PF_names(j,1) = convertCharsToStrings(my_variablesPF);
   
  end

prompt = 'Of how many PF-steps would you like to know the number of appearances?(INPUT:number)\n';
NumApp = input(prompt);
disp('Now type the row number of these steps respectively.(INPUT:Number of row)'); 

for i = 1:NumApp
    
prompt = 'Row number:';
RowApp(i,1) = input(prompt);

end
    
  for j = 1:size(NovicesS(1).(NSeqNames(NRow,1)),1)
   
   for k = 2:size(NovicesS(1).(NSeqNames(NRow,1)),2)
     
    k2 = 1;
    
    for k1 = 1:numPF  
     
      if ~strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
        
       if contains(NovicesS(1).(NSeqNames(NRow,1)){j,k}, PF(1).(PF_names(k1,1)))
         
        ScoresN(1).(ScoresN_names(j,1)){k1,k} = 1;
       
       else ScoresN(1).(ScoresN_names(j,1)){k1,k} = 0;
           
       end
       
      elseif strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
          
       if contains(NovicesS(1).(NSeqNames(NRow,1)){j,k}, PF(1).(PF_names(k1,1)))
        
        count = length(strfind(string(NovicesS(1).(NSeqNames(NRow,1)){j,k}), PF(1).(PF_names(k1,1))));
        ScoresN(1).(ScoresN_names(j,1)){k1,k} = count;
        
       else ScoresN(1).(ScoresN_names(j,1)){k1,k} = 0;
           
       end
          
        k2 = k2+1;
        
      end
     
     end
     
   end
    
   for i = 1:size(seqF{1,1},1)
       
    ScoresN(1).(ScoresN_names(j,1)){i,1} = seqF{1,1}{i,2};
    
   end
    
   end 
   
%Experts:
      
  for j = 1:size(ExpertsS(1).(ESeqNames(ERow,1)),1)
   
   for k = 2:size(ExpertsS(1).(ESeqNames(ERow,1)),2)
     
    k2 = 1;
    
    for k1 = 1:numPF  
     
      if ~strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
        
       if contains(ExpertsS(1).(ESeqNames(ERow,1)){j,k}, PF(1).(PF_names(k1,1)))
         
        ScoresE(1).(ScoresE_names(j,1)){k1,k} = 1;
       
       else ScoresE(1).(ScoresE_names(j,1)){k1,k} =  0;
            
       end
       
      elseif strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
          
       if contains(ExpertsS(1).(ESeqNames(ERow,1)){j,k}, PF(1).(PF_names(k1,1)))
        
        count = length(strfind(string(ExpertsS(1).(ESeqNames(ERow,1)){j,k}), PF(1).(PF_names(k1,1))));
        ScoresE(1).(ScoresE_names(j,1)){k1,k} = count;
        
       else ScoresE(1).(ScoresE_names(j,1)){k1,k} = 0;
           
       end
          
        k2 = k2+1;
        
      end
     
     end
     
   end
   
   for i = 1:size(seqF{1,1},1)
       
    ScoresE(1).(ScoresE_names(j,1)){i,1} = seqF{1,1}{i,2};
    
   end
   
  end
%% Store Appearances in tables for each Participant/Expert:

VariableNames{1,1} = 'AOIsToFind';

for i = 1:size(T_A_N_names,1)

     T_A_N(1).(T_A_N_names(i,1)) = array2table(ScoresN(1).(ScoresN_names(i,1)), 'VariableNames', VariableNames(1,1:end));

end

for i = 1:size(T_A_E_names,1)

     T_A_E(1).(T_A_E_names(i,1)) = array2table(ScoresE(1).(ScoresE_names(i,1)), 'VariableNames', VariableNames(1,1:end));

end

AppearanceN = T_A_N;
AppearanceE = T_A_E;




