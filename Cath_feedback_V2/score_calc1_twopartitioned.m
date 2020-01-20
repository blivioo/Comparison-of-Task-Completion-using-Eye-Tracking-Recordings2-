%% Score_calculation with two partitioned surgery:

%since the crucial performance feedback steps differ for each surgery the
%user needs to provide some information about his surgery-steps he defined
%to be crucial for the score calculation. 
disp(seqPF{1,1});

%First save the number of steps provided by the user's PF data-files 
prompt = 'How many crucial feedback steps/definitions does your PF1 data-file have?(INPUT:Number of rows in Crucial_Feedback_Cath_Steps1-file; ENTER)\n';
  
numPF1 = input(prompt); 
  
disp(seqPF{2,1});
  
prompt = 'How many crucial feedback steps/definitions does your PF2 data-file have?(INPUT:Number of rows in Crucial_Feedback_Cath_Steps2-file; ENTER)\n';
  
numPF2 = input(prompt); 

%generate the variables needed for the score calculation with the crucial
%surgery steps: 
  for j =1:numPF1

   %to understand what happens here take a look at the comment in
   %score_calc1.m
   my_variablesPF1 = sprintf('PF1_%d', j);
   PF1(1).(my_variablesPF1) = string(seqPF{1,1}(j,2));
   PF1_names(j,1) = convertCharsToStrings(my_variablesPF1);
   
   my_variablesWf1 = sprintf('Wf1_%d', j);
   Wf1(1).(my_variablesWf1) = [];
   Wf1_names(j,1) = convertCharsToStrings(my_variablesWf1);
   
  end

  for j =1:numPF2

   my_variablesPF2 = sprintf('PF2_%d', j);
   PF2(1).(my_variablesPF2) = string(seqPF{2,1}(j,2));
   PF2_names(j,1) = convertCharsToStrings(my_variablesPF2);
   
   my_variablesWf2 = sprintf('Wf2_%d', j);
   Wf2(1).(my_variablesWf2) = [];
   Wf2_names(j,1) = convertCharsToStrings(my_variablesWf2);
   
  end

%First PF1: 
disp(seqPF{1,1});
%There are three possible cases the program can distinguish from: 
% - does a step appear? 
% - does a step not appear? 
% - how many times does a step appear? 
%to define how the user wants the program to treat the provided steps, he
%is ask to define the possibilities for each step: 
prompt = 'From your PF1-steps how many shall the programm treat as: if they do NOT APPEAR execute a deduction in the score?(INPUT:Number of pf-steps; ENTER)\n';  
numNotThere1 = input(prompt);

if numNotThere1 ~= 0

disp('Type the row number of the specific step, then hit Enter and do so for each step:(INPUT:Row number; ENTER)');  
for i = 1:numNotThere1
     
prompt = 'Row number of step:';
%NotThere1 stores the row numbers of the steps the programm shall make a
%deduction in the score if the step does not appear in a sequence
NotThere1(i,1) = input(prompt);

end

end
  
numThere1 = numPF1 - numNotThere1;
if numNotThere1 ~= 0

disp('Type the specific row number of the steps you want the program to treat as: if they DO APPEAR execute a deduction in the score.(INPUT:Row number; ENTER)');
for i = 1:numThere1
    
prompt = 'Row number of step:';
%There1 stores the row numbers of the steps the programm shall make a
%deduction in the score if the step does appear in a sequence
There1(i,1) = input(prompt);

end

end

%with NumWdif1 the user can define a weighting for each step which he
%wishes to be different from the minimal deduction -0.5.
prompt = 'From your PF1-steps how many do you wish to weight stronger then -0.5?(INPUT:Number; ENTER)\n';  
NumWdif1 = input(prompt);

%number of steps which have the minimal deduction factor assigned: 
NumWIn1 = numPF1 - NumWdif1;

disp('First type the row number of the specific step. Secondly the weighting factor of the specific step.');
disp('Do so for each step!(INPUT:Row number; ENTER; factor for weighting; ENTER)');

%WIn is the minimal deduction factor 
WIn = 0.5;
 
for i = 1:NumWdif1
    
prompt = 'Row number of step:'; 
%RowWdif1 stores the rows of the steps the user defines a stronger
%weighting factor for in the first column and respectively the weighting factor 
%in the second column 
RowWdif1(i,1) = input(prompt);

prompt = 'Weighting factor of step:';
RowWdif1(i,2) = input(prompt);
Wf1(1).(Wf1_names((RowWdif1(i,1)),1)) = RowWdif1(i,2)*WIn;

end

prompt = 'Of how many PF1-steps would you like to know the number of appearances?(INPUT:Number; ENTER)\n';
NumApp1 = input(prompt);
disp('Type the row number of these steps respectively.(INPUT:Row number; ENTER)'); 

for i = 1:NumApp1
    
prompt = 'Row number of step:';
%RowApp1 stores the row numbers of the steps for which the user wishes the program to
%get the number of appearances
RowApp1(i,1) = input(prompt);

%the user can then define after which count of the step/steps he wants the
%program to undertake a deduction for each further count
prompt = 'After which count do you want the program to deduct -0.5 per further count?(INPUT:Number; ENTER)\n';
CountStart1(i,1) = input(prompt);

end

%As a last input the user needs to provide the row numbers of the steps he
%wants to assign a minimal weighting factor of -0.5
disp('From your PF1-steps which ones do you wish to weight with -0.5?(INPUT:Row number; ENTER)');
for i = 1:NumWIn1
    
 prompt = 'Row number of step:';
 RowWIn1(i,1) = input(prompt);  
 Wf1(1).(Wf1_names((RowWIn1(i,1)),1)) = WIn;
 
end

%Second PF2:

%The same user inputs as described above are aksed from the user and saved
%for the second PF2 file

disp(seqPF{2,1});
prompt = 'From your PF2-steps how many shall the programm treat as: if they do NOT APPEAR execute a deduction in the score?(INPUT:Number of pf-steps; ENTER)\n';  
numNotThere2 = input(prompt);

if numNotThere2 ~= 0

disp('Type the row number of the specific step, then hit enter and do so for each step:(INPUT:Row number; ENTER)');  
for i = 1:numNotThere2
    
prompt = 'Row number of step:';
NotThere2(i,1) = input(prompt);

end

end
  
numThere2 = numPF2 - numNotThere2;
if numNotThere2 ~= 0

disp('Type the specific row number of the steps you want the program to treat as: if they DO APPEAR execute a deduction in the score.(INPUT:Row number; ENTER)');
for i = 1:numThere2
    
prompt = 'Row number of step:'; 
There2(i,1) = input(prompt);

end

end

prompt = 'From your PF2-steps how many do you wish to weight stronger then -0.5?(INPUT:Number; ENTER)\n';  
NumWdif2 = input(prompt);
NumWIn2 = numPF2 - NumWdif2;

disp('First type the row number of the specific step. Secondly the weighting factor of the specific step.');
disp('Do so for each step!(INPUT:Row number; ENTER; factor for weighting; ENTER)');
WIn = 0.5;
 
for i = 1:NumWdif2
    
prompt = 'Row number of step:'; 
RowWdif2(i,1) = input(prompt);

prompt = 'Weighting factor of step:';
RowWdif2(i,2) = input(prompt);
Wf2(1).(Wf2_names((RowWdif2(i,1)),1)) = RowWdif2(i,2)*WIn;

end

prompt = 'Of how many PF2-steps would you like to know the number of appearances?(INPUT:Number; ENTER)\n';
NumApp2 = input(prompt);
disp('Type the row number of these steps respectively.(INPUT:Row number; ENTER)'); 

for i = 1:NumApp2
    
prompt = 'Row number of step:';
RowApp2(i,1) = input(prompt);

prompt = 'After which count do you want the program to deduct -0.5 per further count?(INPUT:Number; ENTER)\n';
CountStart2(i,1) = input(prompt);

end

disp('From your PF2-steps which ones do you wish to weight with -0.5?(INPUT:Row number; ENTER)');
for i = 1:NumWIn2
    
prompt = 'Row number of step:';
RowWIn2(i,1) = input(prompt);  
Wf2(1).(Wf2_names((RowWIn2(i,1)),1)) = WIn;
 
end

%calculate score with this information:
%Novices: 

for i = 1:numN
    
  k4 = 1; 
    
  for j = 1:size(NovicesS(1).(NSeqNames(i,1)),1)

%Part1:
   if numNotThere1 == 0
   
   k3 = 1;

    for k1 = 1:numPF1  
        
     for k2 = 1:NumApp1
         
      if ~strcmp(PF1(1).(PF1_names(k1,1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
        
       if contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF1(1).(PF1_names(k1,1)))
         
        ScoresN(1).(ScoresN_names(i,1))(1,k4) = ScoresN(1).(ScoresN_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(k1,1)));
        
        %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(k1,1));
        Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = seqPF{1,1}{k1,1};
        
        k3 = k3+1;
       
       end
       
      elseif strcmp(PF1(1).(PF1_names(k1,1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
          
       if contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF1(1).(PF1_names(k1,1)))
        
        count = length(strfind(string(NovicesS(1).(NSeqNames(i,1)){j,2}), PF1(1).(PF1_names(k1,1))));
        if count > CountStart1(k2,1)
        CountMult1 = count - CountStart1(k2,1);
        ScoresN(1).(ScoresN_names(i,1))(1,k4) = ScoresN(1).(ScoresN_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(k1,1))*CountMult1);
        
        %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(k1,1));
        Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = seqPF{1,1}{k1,1};
        
        k3 = k3+1; 
        
        end
         
       end
          
      
      end
     
     end
     
    end
    
   end

%Part2:
   if numNotThere2 == 0
       
   k3 = 1;
   
    for k1 = 1:numPF2  
        
     for k2 = 1:NumApp2
         
      if ~strcmp(PF2(1).(PF2_names(k1,1)), PF2(1).(PF2_names(RowApp2(k2,1),1)))
        
       if contains(NovicesS(1).(NSeqNames(i,1)){j,3}, PF2(1).(PF2_names(k1,1)))
         
        ScoresN(1).(ScoresN_names(i,1))(1,k4+1) = ScoresN(1).(ScoresN_names(i,1))(1,k4+1) - (Wf2(1).(Wf2_names(k1,1)));
        
        %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4+1} = PF2(1).(PF2_names(k1,1));
        Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4+1} = seqPF{2,1}{k1,1};
        
        k3 = k3+1; 
       
       end
       
      elseif strcmp(PF2(1).(PF2_names(k1,1)), PF2(1).(PF2_names(RowApp2(k2,1),1)))
          
       if contains(NovicesS(1).(NSeqNames(i,1)){j,3}, PF2(1).(PF2_names(k1,1)))
        
        count = length(strfind(string(NovicesS(1).(NSeqNames(i,1)){j,3}), PF2(1).(PF2_names(k1,1))));
        if count > CountStart2(k2,1)
        CountMult2 = count - CountStart2(k2,1);
        ScoresN(1).(ScoresN_names(i,1))(1,k4+1) = ScoresN(1).(ScoresN_names(i,1))(1,k4+1) - (Wf2(1).(Wf2_names(k1,1))*CountMult2);
        
        %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4+1} = PF2(1).(PF2_names(k1,1));
        Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4+1} = seqPF{2,1}{k1,1};
        
        k3 = k3+1; 
        
        end
         
       end
          
      
      end
     
      end
     
    end
    
   end
 
  if numNotThere1 >= 1
      
   k3 = 1;
         
   %Part1:   
   for k1 = 1:numThere1
        
     for k2 = 1:NumApp1

       if ~strcmp(PF1(1).(PF1_names(There1(k1,1),1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
        
        if contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF1(1).(PF1_names(There1(k1,1),1)))
         
         ScoresN(1).(ScoresN_names(i,1))(1,k4) = ScoresN(1).(ScoresN_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(There1(k1,1),1)));
         
         %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(There1(k1,1),1));
         Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = seqPF{1,1}{There1(k1,1),1};
         
         k3 = k3+1; 
       
        end
       
       elseif strcmp(PF1(1).(PF1_names(There1(k1,1),1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
          
        if contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF1(1).(PF1_names(There1(k1,1),1)))
        
         count = length(strfind(string(NovicesS(1).(NSeqNames(i,1)){j,2}), PF1(1).(PF1_names(There1(k1,1),1))));
         if count > CountStart1(k2,1)
         CountMult1 = count - CountStart1(k2,1);
         ScoresN(1).(ScoresN_names(i,1))(1,k4) = ScoresN(1).(ScoresN_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(There1(k1,1),1))*CountMult1);
         
         %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(There1(k1,1),1));
         Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = seqPF{1,1}{There1(k1,1),1};
         
         k3 = k3+1;
         
         end
         
        end
          
      
       end
     
     end
     
   end
  
   for k1 = 1:numNotThere1
    
    for k2 = 1:NumApp1
    
     if ~strcmp(PF1(1).(PF1_names(NotThere1(k1,1),1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
        
      if ~contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF1(1).(PF1_names(NotThere1(k1,1),1)))
         
        ScoresN(1).(ScoresN_names(i,1))(1,k4) = ScoresN(1).(ScoresN_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(NotThere1(k1,1),1)));
        
        %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(NotThere1(k1,1),1));
        Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = seqPF{1,1}{NotThere1(k1,1),1};
         
        k3 = k3+1;        
       
      end
       
     elseif strcmp(PF1(1).(PF1_names(NotThere1(k1,1),1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
          
      if ~contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF1(1).(PF1_names(NotThere1(k1,1),1)))
        
        count = length(strfind(string(NovicesS(1).(NSeqNames(i,1)){j,2}), PF1(1).(PF1_names(NotThere1(k1,1),1))));
        if count > CountStart1(k2,1)
        CountMult1 = count - CountStart1(k2,1);
        ScoresN(1).(ScoresN_names(i,1))(1,k4) = ScoresN(1).(ScoresN_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(NotThere1(k1,1),1))*CountMult1);
        
        %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(NotThere1(k1,1),1));
         Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = seqPF{1,1}{NotThere1(k1,1),1};
         
        k3 = k3+1;      
        
        end
        
      end
          
      
     end
     
    end
     
   end
     
  end
  
  if numNotThere2 >= 1
      
  k3 = 1;
  
   %Part2:   
   for k1 = 1:numThere2
        
     for k2 = 1:NumApp2

       if ~strcmp(PF2(1).(PF2_names(There2(k1,1),1)), PF2(1).(PF2_names(RowApp2(k2,1),1)))
        
        if contains(NovicesS(1).(NSeqNames(i,1)){j,3}, PF2(1).(PF2_names(There2(k1,1),1)))
         
         ScoresN(1).(ScoresN_names(i,1))(1,k4+1) = ScoresN(1).(ScoresN_names(i,1))(1,k4+1) - (Wf2(1).(Wf2_names(There2(k1,1),1)));
         
         %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4+1} = PF2(1).(PF2_names(There2(k1,1),1));
         Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4+1} = seqPF{2,1}{There2(k1,1),1};
         
         k3 = k3+1;         
       
        end
       
       elseif strcmp(PF2(1).(PF2_names(There2(k1,1),1)), PF2(1).(PF2_names(RowApp2(k2,1),1)))
          
        if contains(NovicesS(1).(NSeqNames(i,1)){j,3}, PF2(1).(PF2_names(There2(k1,1),1)))
        
         count = length(strfind(string(NovicesS(1).(NSeqNames(i,1)){j,3}), PF2(1).(PF2_names(There2(k1,1),1))));
         if count > CountStart2(k2,1)
         CountMult2 = count - CountStart2(k2,1);
         ScoresN(1).(ScoresN_names(i,1))(1,k4+1) = ScoresN(1).(ScoresN_names(i,1))(1,k4+1) - (Wf2(1).(Wf2_names(There2(k1,1),1))*CountMult2);
         
         %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4+1} = PF2(1).(PF2_names(There2(k1,1),1));
         Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4+1} = seqPF{2,1}{There2(k1,1),1};
         
         k3 = k3+1;      
         
         end
         
        end
          
      
       end
     
     end
     
   end
  
   for k1 = 1:numNotThere2
    
    for k2 = 1:NumApp2
    
     if ~strcmp(PF2(1).(PF2_names(NotThere2(k1,1),1)), PF2(1).(PF2_names(RowApp2(k2,1),1)))
        
      if ~contains(NovicesS(1).(NSeqNames(i,1)){j,3}, PF2(1).(PF2_names(NotThere2(k1,1),1)))
         
        ScoresN(1).(ScoresN_names(i,1))(1,k4+1) = ScoresN(1).(ScoresN_names(i,1))(1,k4+1) - (Wf2(1).(Wf2_names(NotThere2(k1,1),1)));
        
        %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4+1} = PF2(1).(PF2_names(NotThere2(k1,1),1));
         Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4+1} = seqPF{2,1}{NotThere2(k1,1),1};
         
        k3 = k3+1;   
       
      end
       
     elseif strcmp(PF2(1).(PF2_names(NotThere2(k1,1),1)), PF2(1).(PF2_names(RowApp2(k2,1),1)))
          
      if ~contains(NovicesS(1).(NSeqNames(i,1)){j,3}, PF2(1).(PF2_names(NotThere2(k1,1),1)))
        
        count = length(strfind(string(NovicesS(1).(NSeqNames(i,1)){j,3}), PF2(1).(PF2_names(NotThere2(k1,1),1))));
        if count > CountStart2(k2,1)
        CountMult2 = count - CountStart2(k2,1);
        ScoresN(1).(ScoresN_names(i,1))(1,k4+1) = ScoresN(1).(ScoresN_names(i,1))(1,k4+1) - (Wf2(1).(Wf2_names(NotThere2(k1,1),1))*CountMult2);
        
        %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4+1} = PF2(1).(PF2_names(NotThere2(k1,1),1));
         Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4+1} = seqPF{2,1}{NotThere2(k1,1),1};
         
        k3 = k3+1;    
       
        end
        
      end
          
      
     end
     
    end
     
   end
     
  end
    
  k4 = k4+2;
  
 end
  
end
 
%Experts: 

for i = 1:numE
    
 k4 = 1; 
    
  for j = 1:size(ExpertsS(1).(ESeqNames(i,1)),1)
   
   if numNotThere1 == 0
       
    k3 = 1;
    
    %Part1:  
    for k1 = 1:numPF1  
        
     for k2 = 1:NumApp1
         
      if ~strcmp(PF1(1).(PF1_names(k1,1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
        
       if contains(ExpertsS(1).(ESeqNames(i,1)){j,2}, PF1(1).(PF1_names(k1,1)))
         
        ScoresE(1).(ScoresE_names(i,1))(1,k4) = ScoresE(1).(ScoresE_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(k1,1)));
        
        %Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(k1,1));
        Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4} = seqPF{1,1}{k1,1};
        
        k3 = k3+1;
       
       end
       
      elseif strcmp(PF1(1).(PF1_names(k1,1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
          
       if contains(ExpertsS(1).(ESeqNames(i,1)){j,2}, PF1(1).(PF1_names(k1,1)))
        
        count = length(strfind(string(ExpertsS(1).(ESeqNames(i,1)){j,2}), PF1(1).(PF1_names(k1,1))));
        if count > CountStart1(k2,1)
        CountMult1 = count - CountStart1(k2,1);
        ScoresE(1).(ScoresE_names(i,1))(1,k4) = ScoresE(1).(ScoresE_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(k1,1))*CountMult1);
        
        %Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(k1,1));
        Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4} = seqPF{1,1}{k1,1};
        
        k3 = k3+1;
        
        end
         
       end
          
      
      end
     
      end
     
    end
    
   end
   
   %Part2:
   if numNotThere2 == 0
       
    k3 = 1;
    
    for k1 = 1:numPF2  
        
     for k2 = 1:NumApp2
         
      if ~strcmp(PF2(1).(PF2_names(k1,1)), PF2(1).(PF2_names(RowApp2(k2,1),1)))
        
       if contains(ExpertsS(1).(ESeqNames(i,1)){j,3}, PF2(1).(PF2_names(k1,1)))
         
        ScoresE(1).(ScoresE_names(i,1))(1,k4+1) = ScoresE(1).(ScoresE_names(i,1))(1,k4+1) - (Wf2(1).(Wf2_names(k1,1)));
        
        %Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4+1} = PF2(1).(PF2_names(k1,1));
        Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4+1} = seqPF{2,1}{k1,1};
        
        k3 = k3+1; 
       
       end
       
      elseif strcmp(PF2(1).(PF2_names(k1,1)), PF2(1).(PF2_names(RowApp2(k2,1),1)))
          
       if contains(ExpertsS(1).(ESeqNames(i,1)){j,3}, PF2(1).(PF2_names(k1,1)))
        
        count = length(strfind(string(ExpertsS(1).(ESeqNames(i,1)){j,3}), PF2(1).(PF2_names(k1,1))));
        if count > CountStart2(k2,1)
        CountMult2 = count - CountStart2(k2,1);
        ScoresE(1).(ScoresE_names(i,1))(1,k4+1) = ScoresE(1).(ScoresE_names(i,1))(1,k4+1) - (Wf2(1).(Wf2_names(k1,1))*CountMult2);
        
        %Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4+1} = PF2(1).(PF2_names(k1,1));
        Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4+1} = seqPF{2,1}{k1,1};
        
        k3 = k3+1; 
        
        end
         
       end
          
      
      end
     
      end
     
    end
    
   end
    
  if numNotThere1 >= 1
      
   k3 = 1;
   
    %Part1:  
   for k1 = 1:numThere1
        
     for k2 = 1:NumApp1

       if ~strcmp(PF1(1).(PF1_names(There1(k1,1),1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
        
        if contains(ExpertsS(1).(ESeqNames(i,1)){j,2}, PF1(1).(PF1_names(There1(k1,1),1)))
         
         ScoresE(1).(ScoresE_names(i,1))(1,k4) = ScoresE(1).(ScoresE_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(There1(k1,1),1)));
         
         %Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(There1(k1,1),1));
         Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4} = seqPF{1,1}{There1(k1,1),1};
         
         k3 = k3+1; 
       
        end
       
       elseif strcmp(PF1(1).(PF1_names(There1(k1,1),1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
          
        if contains(ExpertsS(1).(ESeqNames(i,1)){j,2}, PF1(1).(PF1_names(There1(k1,1),1)))
        
         count = length(strfind(string(ExpertsS(1).(ESeqNames(i,1)){j,2}), PF1(1).(PF1_names(There1(k1,1),1))));
         if count > CountStart1(k2,1)
         CountMult1 = count - CountStart1(k2,1);
         ScoresE(1).(ScoresE_names(i,1))(1,k4) = ScoresE(1).(ScoresE_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(There1(k1,1),1))*CountMult1);
         
         %Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(There1(k1,1),1));
         Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4} = seqPF{1,1}{There1(k1,1),1};
         
         k3 = k3+1; 
         
         end
         
        end
          
      
       end
     
     end
     
   end
  
   for k1 = 1:numNotThere1
    
    for k2 = 1:NumApp1
    
     if ~strcmp(PF1(1).(PF1_names(NotThere1(k1,1),1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
        
      if ~contains(ExpertsS(1).(ESeqNames(i,1)){j,2}, PF1(1).(PF1_names(NotThere1(k1,1),1)))
         
        ScoresE(1).(ScoresE_names(i,1))(1,k4) = ScoresE(1).(ScoresE_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(NotThere1(k1,1),1)));
        
        %Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(NotThere1(k1,1),1));
        Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4} = seqPF{1,1}{NotThere1(k1,1),1};
        
        k3 = k3+1;  
       
      end
       
     elseif strcmp(PF1(1).(PF1_names(NotThere1(k1,1),1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
          
      if ~contains(ExpertsS(1).(ESeqNames(i,1)){j,2}, PF1(1).(PF1_names(NotThere1(k1,1),1)))
        
        count = length(strfind(string(ExpertsS(1).(ESeqNames(i,1)){j,2}), PF1(1).(PF1_names(NotThere1(k1,1),1))));
        if count > CountStart1(k2,1)
        CountMult1 = count - CountStart1(k2,1);
        ScoresE(1).(ScoresE_names(i,1))(1,k4) = ScoresE(1).(ScoresE_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(NotThere1(k1,1),1))*CountMult1);
        
        %Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(NotThere1(k1,1),1));
        Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4} = seqPF{1,1}{NotThere1(k1,1),1};
         
        k3 = k3+1;
        
        end
        
      end
          
      
     end
     
    end
     
   end
     
  end
  
  if numNotThere2 >= 1
      
   k3 = 1;
   
  %Part2:  
   for k1 = 1:numThere2
        
     for k2 = 1:NumApp2

       if ~strcmp(PF2(1).(PF2_names(There2(k1,1),1)), PF2(1).(PF2_names(RowApp2(k2,1),1)))
        
        if contains(ExpertsS(1).(ESeqNames(i,1)){j,3}, PF2(1).(PF2_names(There2(k1,1),1)))
         
         ScoresE(1).(ScoresE_names(i,1))(1,k4+1) = ScoresE(1).(ScoresE_names(i,1))(1,k4+1) - (Wf2(1).(Wf2_names(There2(k1,1),1)));
         
         %Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4+1} = PF2(1).(PF2_names(There2(k1,1),1));
         Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4+1} = seqPF{2,1}{There2(k1,1),1};
         
         k3 = k3+1;    
       
        end
       
       elseif strcmp(PF2(1).(PF2_names(There2(k1,1),1)), PF2(1).(PF2_names(RowApp2(k2,1),1)))
          
        if contains(ExpertsS(1).(ESeqNames(i,1)){j,3}, PF2(1).(PF2_names(There2(k1,1),1)))
        
         count = length(strfind(string(ExpertsS(1).(ESeqNames(i,1)){j,3}), PF2(1).(PF2_names(There2(k1,1),1))));
         if count > CountStart2(k2,1)
         CountMult2 = count - CountStart2(k2,1);
         ScoresE(1).(ScoresE_names(i,1))(1,k4+1) = ScoresE(1).(ScoresE_names(i,1))(1,k4+1) - (Wf2(1).(Wf2_names(There2(k1,1),1))*CountMult2);
         
         %Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4+1} = PF2(1).(PF2_names(There2(k1,1),1));
         Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4+1} = seqPF{2,1}{There2(k1,1),1};
         
         k3 = k3+1;    
         
         end
         
        end
          
      
       end
     
     end
     
   end
  
   for k1 = 1:numNotThere2
    
    for k2 = 1:NumApp2
    
     if ~strcmp(PF2(1).(PF2_names(NotThere2(k1,1),1)), PF2(1).(PF2_names(RowApp2(k2,1),1)))
        
      if ~contains(ExpertsS(1).(ESeqNames(i,1)){j,3}, PF2(1).(PF2_names(NotThere2(k1,1),1)))
         
        ScoresE(1).(ScoresE_names(i,1))(1,k4+1) = ScoresE(1).(ScoresE_names(i,1))(1,k4+1) - (Wf2(1).(Wf2_names(NotThere2(k1,1),1)));
        
        %Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4+1} = PF2(1).(PF2_names(NotThere2(k1,1),1));
        Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4+1} = seqPF{2,1}{NotThere2(k1,1),1};
        
        k3 = k3+1; 
       
      end
       
     elseif strcmp(PF2(1).(PF2_names(NotThere2(k1,1),1)), PF2(1).(PF2_names(RowApp2(k2,1),1)))
          
      if ~contains(ExpertsS(1).(ESeqNames(i,1)){j,3}, PF2(1).(PF2_names(NotThere2(k1,1),1)))
        
        count = length(strfind(string(ExpertsS(1).(ESeqNames(i,1)){j,3}), PF2(1).(PF2_names(NotThere2(k1,1),1))));
        if count > CountStart2(k2,1)
        CountMult2 = count - CountStart2(k2,1);
        ScoresE(1).(ScoresE_names(i,1))(1,k4+1) = ScoresE(1).(ScoresE_names(i,1))(1,k4+1) - (Wf2(1).(Wf2_names(NotThere2(k1,1),1))*CountMult2);
        
        %Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4+1} = PF2(1).(PF2_names(NotThere2(k1,1),1));
         Scores_TrackE(1).(Scores_TrackE_names(i,1)){k3+1,k4+1} = seqPF{2,1}{NotThere2(k1,1),1};
         
        k3 = k3+1; 
        
        end
        
      end
          
      
     end
     
    end
     
   end
     
  end
  
  k4 = k4+2;
     
 end
  
end

%Put Scores and ScoreTrack in tables: 
%Novices: 
for j = 1:numN
    
  numSurgeries = size(NovicesS.(NSeqNames(j,1)),1); 
  Variables = {};
  Variables(1,1) = {'S1P1'};
  Variables(1,2) = {'S1P2'};
  colcount = 1;
      
  for i = 1:numSurgeries
          
   my_variables1 = sprintf('S%dP1', i);
   Variables11(1,i) = {my_variables1};
   
  end
  
  for i = 1:numSurgeries
      
    my_variables2 = sprintf('S%dP2', i);
    Variables22(1,i) = {my_variables2};
      
  end

  for i = 1:2:(2*numSurgeries)

      Variables(1,i) = Variables11(1,colcount);
      Variables(1,i+1) = Variables22(1,colcount); 
  
      colcount = colcount + 1;
      
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
  Variables(1,1) = {'S1P1'};
  Variables(1,2) = {'S1P2'};
  colcount = 1;
      
  for i = 1:numSurgeries
          
   my_variables1 = sprintf('S%dP1', i);
   Variables11(1,i) = {my_variables1};
   
  end
  
  for i = 1:numSurgeries
      
    my_variables2 = sprintf('S%dP2', i);
    Variables22(1,i) = {my_variables2};
      
  end

  for i = 1:2:(2*numSurgeries)

      Variables(1,i) = Variables11(1,colcount);
      Variables(1,i+1) = Variables22(1,colcount); 
  
      colcount = colcount + 1;
      
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

