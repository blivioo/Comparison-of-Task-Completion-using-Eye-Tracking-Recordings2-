%% Score_calculation for catheterization surgery:

%for explanation of variables and loops see comments in
%score_calc1_twopartitioned.m

numPF1 = 5; 

numPF2 = 5; 

  for j =1:numPF1

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
numNotThere1 = 1;

NotThere1(1,1) = 3;

numThere1 = numPF1 - numNotThere1;

There1(1,1) = 1;
There1(2,1) = 2;
There1(3,1) = 4;
There1(4,1) = 5;

NumWdif1 = 3;
NumWIn1 = numPF1 - NumWdif1;

WIn = 4;
 
RowWdif1(1,1) = 1;
RowWdif1(2,1) = 3;
RowWdif1(3,1) = 4;

RowWdif1(1,2) = 4;
RowWdif1(2,2) = 4;
RowWdif1(3,2) = 2;

for i = 1:NumWdif1
Wf1(1).(Wf1_names((RowWdif1(i,1)),1)) = RowWdif1(i,2)*WIn;
end

NumApp1 = 1;

RowApp1(1,1) = 2;

CountStart1 = 1;

RowWIn1(1,1) = 2;  
RowWIn1(2,1) = 5;  
 
for i = 1:NumWIn1
 Wf1(1).(Wf1_names((RowWIn1(i,1)),1)) = WIn;
end

%Second PF2:
 
numNotThere2 = 2;

NotThere2(1,1) = 1;
NotThere2(2,1) = 3;

numThere2 = numPF2 - numNotThere2;
  
There2(1,1) = 2;
There2(2,1) = 4;
There2(3,1) = 5;

NumWdif2 = 4;
NumWIn2 = numPF2 - NumWdif2;

WIn = 4;

RowWdif2(1,1) = 1;
RowWdif2(2,1) = 3;
RowWdif2(3,1) = 4;
RowWdif2(4,1) = 5;

RowWdif2(1,2) = 8;
RowWdif2(2,2) = 3;
RowWdif2(3,2) = 2;
RowWdif2(4,2) = 4;

for i = 1:NumWdif2
Wf2(1).(Wf2_names((RowWdif2(i,1)),1)) = RowWdif2(i,2)*WIn;
end

NumApp2 = 1;

RowApp2(1,1) = 2;

CountStart2 = 1;

RowWIn2(1,1) = 2;  

 for i = 1:NumWIn2
 Wf2(1).(Wf2_names((RowWIn2(i,1)),1)) = WIn;
end

%calculate score with this information:
%Novices: 

for i = 1:numN
    
  k4 = 1; 
    
  for j = 1:size(NovicesS(1).(NSeqNames(i,1)),1)
 
  if numNotThere1 >= 1
      
   k3 = 1;
         
   %Part1:   
   for k1 = 1:numThere1
        
     for k2 = 1:NumApp1

       if ~strcmp(PF1(1).(PF1_names(There1(k1,1),1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
        
        if contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF1(1).(PF1_names(There1(k1,1),1)))
         
         ScoresN(1).(ScoresN_names(i,1))(1,k4) = ScoresN(1).(ScoresN_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(There1(k1,1),1)));
         
         Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = seqPF{1,1}{There1(k1,1),1};
         %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(There1(k1,1),1));
         
         k3 = k3+1; 
       
        end
       
       elseif strcmp(PF1(1).(PF1_names(There1(k1,1),1)), PF1(1).(PF1_names(RowApp1(k2,1),1)))
          
        if contains(NovicesS(1).(NSeqNames(i,1)){j,2}, PF1(1).(PF1_names(There1(k1,1),1)))
        
         count = length(strfind(string(NovicesS(1).(NSeqNames(i,1)){j,2}), PF1(1).(PF1_names(There1(k1,1),1))));
         if count > CountStart1
         CountMult1 = count - CountStart1;
         ScoresN(1).(ScoresN_names(i,1))(1,k4) = ScoresN(1).(ScoresN_names(i,1))(1,k4) - (Wf1(1).(Wf1_names(There1(k1,1),1))*CountMult1);
         
         Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = seqPF{1,1}{There1(k1,1),1};
         %Scores_TrackN(1).(Scores_TrackN_names(i,1)){k3+1,k4} = PF1(1).(PF1_names(There1(k1,1),1));
         
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
        if count > CountStart1
        CountMult1 = count - CountStart1;
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
         if count > CountStart2
         CountMult2 = count - CountStart2;
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
        if count > CountStart2
        CountMult2 = count - CountStart2;
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
         if count > CountStart1
         CountMult1 = count - CountStart1;
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
        if count > CountStart1
        CountMult1 = count - CountStart1;
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
         if count > CountStart2
         CountMult2 = count - CountStart2;
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
        if count > CountStart2
        CountMult2 = count - CountStart2;
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
   
    
    
    
    
    
    
    

