%% Score_calculation with single partitioned surgery:
 

prompt = 'How many feedback steps/definitions does your PF data-file have?(INPUT:Number of rows in Crucial_Feedback_Cath_Steps-file)\n';
  
  numPF = input(prompt); 
 
  for j =1:numPF

   my_variablesPF = sprintf('PF_%d', j);
   PF(1).(my_variablesPF) = string(seqPF{1,1}(j,2));
   PF_names(j,1) = convertCharsToStrings(my_variablesPF);
   
   my_variablesWf = sprintf('Wf_%d', j);
   Wf(1).(my_variablesWf) = [];
   Wf_names(j,1) = convertCharsToStrings(my_variablesWf);
   
  end

disp(seqPF{1,1});
prompt = 'From your PF-steps how many shall the programm treat as: if they do NOT appear execute a deduction in the score?(INPUT:Row number)\n';  
numNotThere = input(prompt);

if numNotThere ~= 0
    
for i = 1:numNotThere
    
prompt = 'Type the row number of these specific steps.(INPUT:Row number)\n';  
NotThere(i,1) = input(prompt);

end

end
  
numThere = numPF - numNotThere;
if numNotThere ~= 0
    
for i = 1:numThere
    
prompt = 'Type the row number of the specific steps you want the program to treat as: if they do appear execute a deduction in the score.(INPUT:Row number top to bottom of file)\n';  
There(i,1) = input(prompt);

end

end


prompt = 'From your PF-steps how many do you wish to weight stronger then -0.5?(INPUT:number)\n';  
NumWdif = input(prompt);
NumWIn = numPF - NumWdif;

disp('As a first step type the row number of the specific step. Then the weighting factor, which can max be 4.(INPUT:Number of row, factor for weighting)'); 
WIn = 0.5;
 
for i = 1:NumWdif
    
prompt = 'Row number:'; 
RowWdif(i,1) = input(prompt);

prompt = 'Weight factor of step:';
RowWdif(i,2) = input(prompt);
Wf(1).(Wf_names((RowWdif(i,1)),1)) = RowWdif(i,2)*WIn;

end

prompt = 'Of how many PF-steps would you like to know the number of appearances?(INPUT:number)\n';
NumApp = input(prompt);
disp('Now type the row number of these steps respectively.(INPUT:Number of row)'); 

for i = 1:NumApp
    
prompt = 'Row number:';
RowApp(i,1) = input(prompt);

end

prompt = 'After which count do you want the program to deduct -0.5 per further count?(INPUT:number)\n';
CountStart = input(prompt);

for i = 1:NumWIn
    
 prompt = 'From your PF-steps which ones do you wish to weight with -0.5?(INPUT:Row number)\n';  
 RowWIn(i,1) = input(prompt);  
 Wf(1).(Wf_names((RowWIn(i,1)),1)) = WIn;
 
end

%calculate score with this information:
%Novices: 
for i = 1:numN
    
  for j = 1:size(NovicesS(1).(NSeqNames(i,1)),1)
   
   if numNotThere == 0
       
   k3 = 1;
       
    for k1 = 1:numPF  
        
     for k2 = 1:NumApp
         
      if ~strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
        
       if contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF(1).(PF_names(k1,1)))
         
        ScoresN(1).(ScoresN_names(i,1))(1,j) = ScoresN(1).(ScoresN_names(i,1))(1,j) - (Wf(1).(Wf_names(k1,1)));
        
        Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,j} = PF(1).(PF_names(k1,1));
        
        k3 = k3+1;
        
       end
       
      elseif strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
          
       if contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF(1).(PF_names(k1,1)))
        
        count = length(strfind(string(NovicesS(1).(NSeqNames(i,1)){j,2}), PF(1).(PF_names(k1,1))));
        
        if count > CountStart
        
            CountMult = count - CountStart;
        
            ScoresN(1).(ScoresN_names(i,1))(1,j) = ScoresN(1).(ScoresN_names(i,1))(1,j) - (Wf(1).(Wf_names(k1,1))*CountMult);
        
            Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,j} = PF(1).(PF_names(k1,1));
        
            k3 = k3+1;
            
        end
         
       end
          
      
      end
     
     end
     
    end
    
  elseif numNotThere >= 1
      
  k3 = 1;
      
   for k1 = 1:numThere
        
     for k2 = 1:NumApp

       if ~strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
        
        if contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF(1).(PF_names(There(k1,1),1)))
         
         ScoresN(1).(ScoresN_names(i,1))(1,j) = ScoresN(1).(ScoresN_names(i,1))(1,j) - (Wf(1).(Wf_names(There(k1,1),1)));
         
         Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,j} = PF(1).(PF_names(There(k1,1),1));
         
         k3 = k3+1;
         
        end
       
       elseif strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
          
        if contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF(1).(PF_names(There(k1,1),1)))
        
         count = length(strfind(string(NovicesS(1).(NSeqNames(i,1)){j,2}), PF(1).(PF_names(There(k1,1),1))));
         
         if count > CountStart
             
           CountMult = count - CountStart;
         
           ScoresN(1).(ScoresN_names(i,1))(1,j) = ScoresN(1).(ScoresN_names(i,1))(1,j) - (Wf(1).(Wf_names(There(k1,1),1))*CountMult);
         
           Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,j} = PF(1).(PF_names(There(k1,1),1));
         
           k3 = k3+1;
         
         end
         
        end
          
      
       end
     
     end
     
   end
  
   for k1 = 1:numNotThere
    
    for k2 = 1:NumApp
    
     if ~strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
        
      if ~contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF(1).(PF_names(NotThere(k1,1),1)))
         
        ScoresN(1).(ScoresN_names(i,1))(1,j) = ScoresN(1).(ScoresN_names(i,1))(1,j) - (Wf(1).(Wf_names(NotThere(k1,1),1)));
        
        Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,j} = PF(1).(PF_names(NotThere(k1,1),1));
        
        k3 = k3+1;
        
      end
       
     elseif strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
          
      if ~contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF(1).(PF_names(NotThere(k1,1),1)))
        
        count = length(strfind(string(NovicesS(1).(NSeqNames(i,1)){j,2}), PF(1).(PF_names(NotThere(k1,1),1))));
        
        if count > CountStart
        
            CountMult = count - CountStart;
        
            ScoresN(1).(ScoresN_names(i,1))(1,j) = ScoresN(1).(ScoresN_names(i,1))(1,j) - (Wf(1).(Wf_names(NotThere(k1,1),1))*CountMult);
        
            Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,j} = PF(1).(PF_names(NotThere(k1,1),1));
        
            k3 = k3+1;
            
        end
        
      end
          
      
     end
     
    end
     
   end
     
  end
     
 end
  
end
 
%Experts: 

for i = 1:numE
    
  for j = 1:size(ExpertsS(1).(ESeqNames(i,1)),1)
   
   if numNotThere == 0
       
   k3 = 1;
       
    for k1 = 1:numPF  
        
     for k2 = 1:NumApp
         
      if ~strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
        
       if contains(ExpertsS(1).(ESeqNames(i,1)){j,2}, PF(1).(PF_names(k1,1)))
         
        ScoresE(1).(ScoresE_names(i,1))(1,j) = ScoresE(1).(ScoresE_names(i,1))(1,j) - (Wf(1).(Wf_names(k1,1)));
        
        Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,j} = PF(1).(PF_names(k1,1));
       
        k3 = k3+1;
       
       end
       
      elseif strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
          
       if contains(ExpertsS(1).(ESeqNames(i,1)){j,2}, PF(1).(PF_names(k1,1)))
        
        count = length(strfind(string(ExpertsS(1).(ESeqNames(i,1)){j,2}), PF(1).(PF_names(k1,1))));
        if count > CountStart
         CountMult = count - CountStart;
         ScoresE(1).(ScoresE_names(i,1))(1,j) = ScoresE(1).(ScoresE_names(i,1))(1,j) - (Wf(1).(Wf_names(k1,1))*CountMult);
         Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,j} = PF(1).(PF_names(k1,1));
         k3 = k3+1;
        end
         
       end
          
      
      end
     
      end
     
    end
    
  elseif numNotThere >= 1
     
  k3 = 1;
  
   for k1 = 1:numThere
        
     for k2 = 1:NumApp

       if ~strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
        
        if contains(ExpertsS(1).(ESeqNames(i,1)){j,2}, PF(1).(PF_names(There(k1,1),1)))
         
         ScoresE(1).(ScoresE_names(i,1))(1,j) = ScoresE(1).(ScoresE_names(i,1))(1,j) - (Wf(1).(Wf_names(There(k1,1),1)));
         
         Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,j} = PF(1).(PF_names(There(k1,1),1));
       
         k3 = k3+1;
         
        end
       
       elseif strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
          
        if contains(ExpertsS(1).(ESeqNames(i,1)){j,2}, PF(1).(PF_names(There(k1,1),1)))
        
         count = length(strfind(string(ExpertsS(1).(ESeqNames(i,1)){j,2}), PF(1).(PF_names(There(k1,1),1))));
         if count > CountStart
          CountMult = count - CountStart;
          ScoresE(1).(ScoresE_names(i,1))(1,j) = ScoresE(1).(ScoresE_names(i,1))(1,j) - (Wf(1).(Wf_names(There(k1,1),1))*CountMult);
         
          Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,j} = PF(1).(PF_names(There(k1,1),1));
         
          k3 = k3+1;
          
         end
         
        end
          
      
       end
     
     end
     
   end
  
   for k1 = 1:numNotThere
    
    for k2 = 1:NumApp
    
     if ~strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
        
      if ~contains(ExpertsS(1).(ESeqNames(i,1)){j,2}, PF(1).(PF_names(NotThere(k1,1),1)))
         
        ScoresE(1).(ScoresE_names(i,1))(1,j) = ScoresE(1).(ScoresE_names(i,1))(1,j) - (Wf(1).(Wf_names(NotThere(k1,1),1)));
        
        Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,j} = PF(1).(PF_names(NotThere(k1,1),1));
       
        k3 = k3+1;
        
      end
       
     elseif strcmp(PF(1).(PF_names(k1,1)), PF(1).(PF_names(RowApp(k2,1),1)))
          
      if ~contains(ExpertsS(1).(ESeqNames(i,1)){j,2}, PF(1).(PF_names(NotThere(k1,1),1)))
        
        count = length(strfind(string(ExpertsS(1).(ESeqNames(i,1)){j,2}), PF(1).(PF_names(NotThere(k1,1),1))));
        if count > CountStart
         CountMult = count - CountStart;
         ScoresE(1).(ScoresE_names(i,1))(1,j) = ScoresE(1).(ScoresE_names(i,1))(1,j) - (Wf(1).(Wf_names(NotThere(k1,1),1))*CountMult);
        
         Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,j} = PF(1).(PF_names(NotThere(k1,1),1));
        
         k3 = k3+1;
        end
        
      end
          
      
     end
     
    end
     
   end
     
  end
     
 end
  
end

%Put Scores and ScoreTrack in tables: 
%Novices: 
for j = 1:numN
    
  numSurgeries = size(NovicesS.(NSeqNames(j,1)),1); 
  Variables = {};
      
  for i = 1:numSurgeries
          
   my_variables1 = sprintf('S%dP1', i);
   Variables(1,i) = {my_variables1};
   
  end

  DeductionReason = {};
  colcountT = 1; 
  for i = 1:size(Scores_TrackN.(Scores_TrackN_names(j,1)),1)
      
      DeductionReason(1,1) = {'LevDistIntDeduction'};
      
      if (size(Scores_TrackN.(Scores_TrackN_names(j,1)),1) > 1) && (i > 1)
          
        DeductionReason(1,i) = {sprintf('DeductionReason%d',i-1)};
        
      end
      
  end
  
  Variables = string(Variables);
    
  T_ScoreN.(T_ScoreN_names(j,1)) = array2table(ScoresN.(ScoresN_names(j,1)), 'VariableNames', Variables, 'RowNames', {sprintf('ScoresN%d:',j)});
    
  T_TrackN.(T_TrackN_names(j,1)) = array2table(Scores_TrackN.(Scores_TrackN_names(j,1)), 'VariableNames', Variables, 'RowNames', DeductionReason);
    
end

%Experts:
for j = 1:numE
    
  numSurgeries = size(ExpertsS.(ESeqNames(j,1)),1); 
  Variables = {};
      
  for i = 1:numSurgeries
          
   my_variables1 = sprintf('S%dP1', i);
   Variables(1,i) = {my_variables1};
   
  end
  
  DeductionReason = {};
  colcountT = 1; 
  for i = 1:size(Scores_TrackE.(Scores_TrackE_names(j,1)),1)
      
      DeductionReason(1,1) = {'LevDistIntDeduction'};
      
      if (size(Scores_TrackE.(Scores_TrackE_names(j,1)),1) > 1) && (i > 1)
          
        DeductionReason(1,i) = {sprintf('DeductionReason%d',i-1)};
        
      end
      
  end
  
  Variables = string(Variables);
    
  T_ScoreE.(T_ScoreE_names(j,1)) = array2table(ScoresE.(ScoresE_names(j,1)), 'VariableNames', Variables, 'RowNames', {sprintf('ScoresE%d:',j)});
    
  T_TrackE.(T_TrackE_names(j,1)) = array2table(Scores_TrackE.(Scores_TrackE_names(j,1)), 'VariableNames', Variables, 'RowNames', DeductionReason);
    
end
