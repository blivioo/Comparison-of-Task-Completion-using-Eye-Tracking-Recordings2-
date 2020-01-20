%% function to shorten Sequences: 

function C1 = seq_slimmmer(sequence)

%walk through sequence and compare if momentarly char1 is different from
%following char2 and if so safe char1 to SeqShort
for k = 2:length(sequence)
             
    CharChosen = sequence(k-1);
             
    NextChar = sequence(k);
             
    if CharChosen ~= NextChar 
             
       SeqShort(k-1) = CharChosen; 
                 
    end
             
end

%the last char-type of sequence is lost if it is different from the one before
%it due to the beforehand defined walk through. Therefore the last char
%must be compared singlehandly with the one before it and if different
%added at the end of SeqShort
if sequence(length(sequence)) ~= sequence(length(sequence)-1)
             
    SeqShort(length(SeqShort)+1) = sequence(length(sequence));

elseif sequence(length(sequence)) == sequence(length(sequence)-1)
    
    SeqShort(length(SeqShort)+1) = sequence(length(sequence));
    
end

%assign output as the new sequence without any spaces inbetween --> as a single "word"        
C1 = cellstr(SeqShort(find(~isspace(SeqShort))));
       
end
      
 
         
