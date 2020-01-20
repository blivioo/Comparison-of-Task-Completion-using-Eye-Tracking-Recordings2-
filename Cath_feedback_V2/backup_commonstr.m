%% Find (longest) common subsequence between novice and expert 

%let user decide if he desires to find longest sseq or not

%use first while expression to be able to jump back to start of following while expression
Proceed1 = true;
while(Proceed1 == true)

  prompt = 'Would you like to find the longest common-subsequence or search for subsequences with a self-defined length?(yes or no)\n';

  go_nogo = 'yes';

  UserDecision = input(prompt,'s');

  Proceed2 = true;
  while (Proceed2 == true)
    
    if strcmp(UserDecision,go_nogo)
   
    %which participant is of interest?
    prompt = 'Which Novice/Experts-Data would you like to use? Type N1;N2;N3 for Novice1/2/3 and E1;E2 for Expert1/2.\n';
    
    UserDecision2 = input(prompt,'s');
    
    choice1 = "N1";

    choice2 = "N2";
    
    choice3 = "N3";
    
    choice4 = "E1";
    
    choice5 = "E2";
    
    inputs1 = [choice1; choice2; choice3; choice4; choice5];
    
    if (~strcmp(inputs1, UserDecision2))
    
    disp('WRONG INPUT');    
    
    break;
        
    end
    
      %Novice1
      if strcmp(UserDecision2, choice1);
        
       for i=1:size(seqN1,1)
    
         %let commonsubstring find the longest sseq of N1:
        
         %Left Leg: 
         [comm_sseq_N1,loc1,loc2] = commonsubstring(TEMPL_LL,convertStringsToChars(seqN1{i,2}));
         
         %safe each sseq in coresponding cell array column 
         %(first row: LL ;second row: RL)
         
          if isempty(comm_sseq_N1)
                   
              Sseq_N1(1,i) = {'no sseq'};
               
          else
              
              Sseq_N1(1,i) = {comm_sseq_N1};
               
          end

         %Right Leg: 
    
         [comm_sseq_N1,loc1,loc2] = commonsubstring(TEMPL_RL,convertStringsToChars(seqN1{i,3}));
         
          if isempty(comm_sseq_N1)
                   
              Sseq_N1(2,i) = {'no sseq'};
               
          else
              
              Sseq_N1(2,i) = {comm_sseq_N1};
               
          end
           
       end
     
       %store and display longest common sseq in table with dynamic column
       %size, dependend on Nr. of surgeries done by the participant:
       columnsN1 = dynamic_columns(seqN1);
       TSSeqN1 = cell2table(Sseq_N1, 'VariableNames', columnsN1, 'RowNames', {'LL:' 'RL:'});
       disp(TSSeqN1);
  
  %use break to get out of while expression and ask user if he wants to analyse data of other participants; see end of section 
  break; 

      %Novice2
      elseif strcmp(UserDecision2, choice2);
        
         for i=1:size(seqN2,1)
    
         %Left Leg: 
         [comm_sseq_N2,loc1,loc2] = commonsubstring(TEMPL_LL,convertStringsToChars(seqN2{i,2}));

          if isempty(comm_sseq_N2)
                   
               Sseq_N2(1,i) = {'no sseq'};
               
           else
              
              Sseq_N2(1,i) = {comm_sseq_N2};
               
          end

         %Right Leg: 
    
         [comm_sseq_N2,loc1,loc2] = commonsubstring(TEMPL_RL,convertStringsToChars(seqN2{i,3}));
    
          if isempty(comm_sseq_N2)
                   
               Sseq_N2(2,i) = {'no sseq'};
               
           else
              
              Sseq_N2(2,i) = {comm_sseq_N2};
               
          end
    
         end
       
       columnsN2 = dynamic_columns(seqN2);
       TSSeqN2 = cell2table(Sseq_N2, 'VariableNames', columnsN2, 'RowNames', {'LL:' 'RL:'});
       disp(TSSeqN2);
       
  break;        
    
      %Novice3   
      elseif strcmp(UserDecision2, choice3);
        
       for i=1:size(seqN3,1)
    
          %Left Leg: 
          [comm_sseq_N3,loc1,loc2] = commonsubstring(TEMPL_LL,convertStringsToChars(seqN3{i,2}));

           if isempty(comm_sseq_N3)
                   
               Sseq_N3(1,i) = {'no sseq'};
               
           else
              
              Sseq_N3(1,i) = {comm_sseq_N3};
               
           end

          %Right Leg: 
    
          [comm_sseq_N3,loc1,loc2] = commonsubstring(TEMPL_RL,convertStringsToChars(seqN3{i,3}));
    
           if isempty(comm_sseq_N3)
                   
               Sseq_N3(2,i) = {'no sseq'};
               
           else
              
              Sseq_N3(2,i) = {comm_sseq_N3};
               
           end
    
       end
       
       columnsN3 = dynamic_columns(seqN3);
       TSSeqN3 = cell2table(Sseq_N3, 'VariableNames', columnsN3, 'RowNames', {'LL:' 'RL:'});
       disp(TSSeqN3);
       
  break;        
    
      %Expert1 
      elseif strcmp(UserDecision2, choice4);
        
       for i=1:size(seqE1,1)
    
          %Left Leg: 
          [comm_sseq_E1,loc1,loc2] = commonsubstring(TEMPL_LL,convertStringsToChars(seqE1{i,2}));

           if isempty(comm_sseq_E1)
                   
              Sseq_E1(1,i) = {'no sseq'};
               
           else
              
              Sseq_E1(1,i) = {comm_sseq_E1};
               
           end

          %Right Leg: 
    
          [comm_sseq_E1,loc1,loc2] = commonsubstring(TEMPL_RL,convertStringsToChars(seqE1{i,3}));
    
           if isempty(comm_sseq_E1)
                   
              Sseq_E1(2,i) = {'no sseq'};
               
           else
              
              Sseq_E1(2,i) = {comm_sseq_E1};
               
           end
    
       end
       
       columnsE1 = dynamic_columns(seqE1);
       TSSeqE1 = cell2table(Sseq_E1, 'VariableNames', columnsE1, 'RowNames', {'LL:' 'RL:'});
       disp(TSSeqE1);
       
  break;        
    
      %Expert2 
      elseif strcmp(UserDecision2, choice5);
        
       for i=1:size(seqE2,1)
    
          %Left Leg: 
          [comm_sseq_E2,loc1,loc2] = commonsubstring(TEMPL_LL,convertStringsToChars(seqE2{i,2}));

           if isempty(comm_sseq_E2)
                   
               Sseq_E2(1,i) = {'no sseq'};
               
           else
              
              Sseq_E2(1,i) = {comm_sseq_E2};
               
           end

          %Right Leg: 
    
          [comm_sseq_E2,loc1,loc2] = commonsubstring(TEMPL_RL,convertStringsToChars(seqE2{i,3}));
    
           if isempty(comm_sseq_E2)
                   
               Sseq_E2(2,i) = {'no sseq'};
               
           else
              
              Sseq_E2(2,i) = {comm_sseq_E2};
               
           end 
    
       end
       
       columnsE2 = dynamic_columns(seqE2);
       TSSeqE2 = cell2table(Sseq_E2, 'VariableNames', columnsE2, 'RowNames', {'LL:' 'RL:'});
       disp(TSSeqE2);
     
      end
    
  break;     

    %if the user does not desire to find the longest sseq, he can define with
    %lengthsseq the length of the desired common sseq he would like to find
    else 
   
    prompt = 'How long shall the searched common-subsequences be? Type a number from 2 to 8.\n';

    lengthsseq = input(prompt);
    
    if (lengthsseq > 8 || lengthsseq < 2)
    
    disp('WRONG INPUT');    
    
    break;
        
    end

    prompt = 'Which Novice/Experts-Data would you like to use? Type N1;N2;N3 for Novice1/2/3 and E1;E2 for Expert1/2.\n';

    UserDecision3 = input(prompt,'s');

    choice1 = "N1";

    choice2 = "N2";
    
    choice3 = "N3";
    
    choice4 = "E1";

    choice5 = "E2";
    
    inputs2 = [choice1; choice2; choice3; choice4; choice5];
    
    if (~strcmp(inputs2, UserDecision3))
    
    disp('WRONG INPUT');    
    
    break;
    
    end
    
    %same execution as above
    
    %Novice1
    if strcmp(UserDecision3, choice1);
        
       for i=1:size(seqN1,1)
    
          %Left Leg: 
          [comm_sseq_N1,loc1,loc2] = commonsubstring(TEMPL_LL,convertStringsToChars(seqN1{i,2}),lengthsseq);
          
          %since the user defined the desired sseq length manually, it is possible that there are no sseq with the defined lenght. 
          %Thus the cell must be filled with this information: "no sseq"
          if isempty(comm_sseq_N1)
                   
               sseq_N1_LL = {'no sseq'};
               
          else
          %if there are sseq with the desired length, the same as for the longest common sseq happens, 
          %only that now there are mutliple sseq, safed in the vector sseq_N.      
               for j = 1:size(comm_sseq_N1,1)
          
               sseq_N1_LL(j,1) = {comm_sseq_N1(j,:)};
        
               end
               
          end
               
          %Right Leg: 
          [comm_sseq_N1,loc1,loc2] = commonsubstring(TEMPL_RL,convertStringsToChars(seqN1{i,3}),lengthsseq);
             
          if isempty(comm_sseq_N1)
                   
               sseq_N1_RL = {'no sseq'};
                  
          else
                
               for j = 1:size(comm_sseq_N1,1)
            
               sseq_N1_RL(j,1) = {comm_sseq_N1(j,:)};
        
               end  
               
           end
           %because of the beforehand explained reasons, each sseq vector
           %containing the corresponding surgery sseqs gets stored in
           %an overall array, containing the found sseq for each surgery (columns) of the chosen participant  
          
           for d = 1 : max(size(sseq_N1_LL,1),size(sseq_N1_RL,1))
               
               %define which sseq belong to which half (LL/RL) of the whole
               %procedure: 
               if d == 1                                   
                    
                  sseq_N1(d,i) = {'LL:'};
                   
                  sseq_N1(d+1+size(sseq_N1_LL,1),i) = {'RL:'};
                   
               end
                  
               %assign LL sseq in first rows 
               if d <= size(sseq_N1_LL,1)
                 
                  sseq_N1(d+1,i) = sseq_N1_LL(d,:);
                   
               end  
                
               %assign RL sseq in the following rows 
               if d <= size(sseq_N1_RL,1)
                               
                  sseq_N1(d+2+size(sseq_N1_LL,1),i) = sseq_N1_RL(d,:);
                  
               end
                 
           end
       end
       
       %display length defined sseq in table:
       columnsN1 = dynamic_columns(seqN1);
       TSSeqN1 = cell2table(sseq_N1, 'VariableNames', columnsN1);
       disp(TSSeqN1);
       
  break;        
  
    %all the following steps are the same as before just for different
    %participants
    
    %Novice2
    elseif strcmp(UserDecision3, choice2);
        
        for i=1:size(seqN2,1)
    
            %Left Leg: 
            [comm_sseq_N2,loc1,loc2] = commonsubstring(TEMPL_LL,convertStringsToChars(seqN2{i,2}),lengthsseq);

            if isempty(comm_sseq_N2)
                   
               sseq_N2_LL = {'no sseq'};
                  
            else
                  
               for j = 1:size(comm_sseq_N2,1)
                          
               sseq_N2_LL(j,1) = {comm_sseq_N2(j,:)};
        
               end
               
            end
               
            %Right Leg: 
            [comm_sseq_N2,loc1,loc2] = commonsubstring(TEMPL_RL,convertStringsToChars(seqN2{i,3}),lengthsseq);
             
            if isempty(comm_sseq_N2)
                   
               sseq_N2_RL = {'no sseq'};
                  
            else 
                
               for j = 1:size(comm_sseq_N2,1)
            
               sseq_N2_RL(j,1) = {comm_sseq_N2(j,:)};
        
               end  
               
             end
               
             for d = 1 : max(size(sseq_N2_LL,1),size(sseq_N2_RL,1))
               
                if d == 1                                   
                    
                 sseq_N2(d,i) = {'LL:'};
                
                 sseq_N2(d+1+size(sseq_N2_LL,1),i) = {'RL:'};
                
                end
                
                if d <= size(sseq_N2_LL,1)
                                                
                sseq_N2(d+1,i) = sseq_N2_LL(d,:);
               
                end
                              
                if d <= size(sseq_N2_RL,1)
                               
                 sseq_N2(d+2+size(sseq_N2_LL,1),i) = sseq_N2_RL(d,:);
               
                end
               
             end
               
        end
        
       columnsN2 = dynamic_columns(seqN2);
       TSSeqN2 = cell2table(sseq_N2, 'VariableNames', columnsN2);
       disp(TSSeqN2);
        
  break;         
        
    %Novice3    
    elseif strcmp(UserDecision3, choice3);
        
       for i=1:size(seqN3,1)
    
           %Left Leg: 
           [comm_sseq_N3,loc1,loc2] = commonsubstring(TEMPL_LL,convertStringsToChars(seqN3{i,2}),lengthsseq);

            if isempty(comm_sseq_N3)
                   
               sseq_N3_LL = {'no sseq'};
                  
            else
               
               for j = 1:size(comm_sseq_N3,1)
          
               sseq_N3_LL(j,1) = {comm_sseq_N3(j,:)};
        
               end
               
            end
               
            %Right Leg: 
            [comm_sseq_N3,loc1,loc2] = commonsubstring(TEMPL_RL,convertStringsToChars(seqN3{i,3}),lengthsseq);
             
            if isempty(comm_sseq_N3)
                   
               sseq_N3_RL = {'no sseq'};
                  
            else
                
               for j = 1:size(comm_sseq_N3,1)
            
               sseq_N3_RL(j,1) = {comm_sseq_N3(j,:)};
        
               end
               
            end
               
            for d = 1 : max(size(sseq_N3_LL,1),size(sseq_N3_RL,1))
               
               if d == 1                                   
                    
                sseq_N3(d,i) = {'LL:'};
                
                sseq_N3(d+1+size(sseq_N3_LL,1),i) = {'RL:'};
                
               end
                
               if d <= size(sseq_N3_LL,1)
                                                
                sseq_N3(d+1,i) = sseq_N3_LL(d,:);
               
               end
                              
               if d <= size(sseq_N3_RL,1)
                               
                 sseq_N3(d+2+size(sseq_N3_LL,1),i) = sseq_N3_RL(d,:);
               
               end
               
             end
               
       end
       
        columnsN3 = dynamic_columns(seqN3);
       TSSeqN3 = cell2table(sseq_N3, 'VariableNames', columnsN3);
       disp(TSSeqN3);
        
  break;         
   
    %Expert1     
    elseif strcmp(UserDecision3, choice4);
        
       for i=1:size(seqE1,1)
    
           %Left Leg: 
           [comm_sseq_E1,loc1,loc2] = commonsubstring(TEMPL_LL,convertStringsToChars(seqE1{i,2}),lengthsseq);

            if isempty(comm_sseq_E1)
                   
               sseq_E1_LL = {'no sseq'};
                  
            else
               
               for j = 1:size(comm_sseq_E1,1)
          
               sseq_E1_LL(j,1) = {comm_sseq_E1(j,:)};
        
               end
               
            end
               
           %Right Leg: 
           [comm_sseq_E1,loc1,loc2] = commonsubstring(TEMPL_RL,convertStringsToChars(seqE1{i,3}),lengthsseq);
             
            if isempty(comm_sseq_E1)
                   
               sseq_E1_RL = {'no sseq'};
                  
            else
                
               for j = 1:size(comm_sseq_E1,1)
            
               sseq_E1_RL(j,1) = {comm_sseq_E1(j,:)};
        
               end
               
            end
               
            for d = 1 : max(size(sseq_E1_LL,1),size(sseq_E1_RL,1))
               
               if d == 1                                   
                    
                sseq_E1(d,i) = {'LL:'};
                
                sseq_E1(d+1+size(sseq_E1_LL,1),i) = {'RL:'};
                
               end
                
               if d <= size(sseq_E1_LL,1)
                                                
                sseq_E1(d+1,i) = {sseq_E1_LL(d,:)};
               
               end
                              
               if d <= size(sseq_E1_RL,1)
                               
                 sseq_E1(d+2+size(sseq_E1_LL,1),i) = {sseq_E1_RL(d,:)};
               
               end
               
             end
               
       end

       columnsE1 = dynamic_columns(seqE1);
       TSSeqE1 = cell2table(sseq_E1, 'VariableNames', columnsE1);
       disp(TSSeqE1);
        
  break;         
   
    %Expert2     
    else  
    
     for i=1:size(seqE2,1)
    
           %Left Leg: 
           [comm_sseq_E2,loc1,loc2] = commonsubstring(TEMPL_LL,convertStringsToChars(seqE2{i,2}),lengthsseq);

            if isempty(comm_sseq_E2)
                   
               sseq_E2_LL = {'no sseq'};
                  
            else
               
               for j = 1:size(comm_sseq_E2,1)
          
               sseq_E2_LL(j,1) = {comm_sseq_E2(j,:)};
        
               end
               
            end
               
           %Right Leg: 
           [comm_sseq_E2,loc1,loc2] = commonsubstring(TEMPL_RL,convertStringsToChars(seqE2{i,3}),lengthsseq);
             
            if isempty(comm_sseq_E2)
                   
               sseq_E2_RL = {'no sseq'};
                  
            else
                
               for j = 1:size(comm_sseq_E2,1)
            
               sseq_E2_RL(j,1) = {comm_sseq_E2(j,:)};
        
               end
               
            end
               
            for d = 1 : max(size(sseq_E2_LL,1),size(sseq_E2_RL,1))
               
               if d == 1                                   
                    
                sseq_E2(d,i) = {'LL:'};
                
                sseq_E2(d+1+size(sseq_E2_LL,1),i) = {'RL:'};
                
               end
                
               if d <= size(sseq_E2_LL,1)
                                                
                sseq_E2(d+1,i) = sseq_E2_LL(d,:);
               
               end
                              
               if d <= size(sseq_E2_RL,1)
                               
                 sseq_E2(d+2+size(sseq_E2_LL,1),i) = sseq_E2_RL(d,:);
               
               end
               
             end
               
        end
       
       columnsE2 = dynamic_columns(seqE2);
       TSSeqE2 = cell2table(sseq_E2, 'VariableNames', columnsE2);
       disp(TSSeqE2);
        
    end
   
  break; 

    end

  end

disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');
prompt = 'Would you like to find SubSequences of other Participants or did you enter a WRONG INPUT?(yes or no)\n';

UserDesicion3 = input(prompt,'s');

NOContinue = "no";

if strcmp(UserDesicion3,NOContinue)
   
    break;
    
end

end

disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');
disp('------------------------------------------------------------------------------------------------------------------------------------------------------------');