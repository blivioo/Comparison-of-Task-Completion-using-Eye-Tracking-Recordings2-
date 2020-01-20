%% function for Damerau-Levenshtein distance

function [D,d] = damerau_levenshtein(str1,str2)

%save length of strings to compare

m = length(str1); 
n = length(str2); %template

%% set up matrix 

% two extra rows and collums to save high cost at first row/column 
% and minimum distance for each character at second row/column

m2 = m+2;
n2 = n+2;

d = zeros(n2,m2); 

%define high cost higher than maximum distance possible between both strings, 
%it helps to simplify logic of the algorithm; 

%for further explanation see below

max_dist = m + n; 

for i=1:n2
    
    d(i,1) = max_dist;
    
end

 for j=1:n 
     
        d(j+2,2) = j;
 end
    
 for k=1:m2
    
    d(1,k) = max_dist;
    
end

 for l=1:m 
     
        d(2,l+2) = l;
 end
 
 %% set up array for 'row remembering' of specific character from str1 at ASCII as index 
 % 1 stays for no match yet, which would lead directly to row or column 1
 % --> max_dist value
 
 last_row_ch_str2 = ones(1,256);
 
%  for f = 1:256
%      
%      last_row_ch_str1(f) = 1;
% 
%  end
 
 
 %% calculate distances insertion/deletion/replacement/transposition
 
 % i is the running variable for the row
for i = 1:n
    
    %assign ASCII of i-th character from str1
   ch_str2 = double(str2(i));
    
    %stores the column where the j-th character of str2 was seen last 
    %set last_match_col as well to 1 --> no match yet
    last_match_col = 1; 
    
    % j is the running variable for the column
    for j = 1:m
    
        %assign ASCII of j-th character from str2
        ch_str1 = double(str1(j));
    
        %assign row of last appearance of j-th character
        last_matching_row = last_row_ch_str2(ch_str1);
    
        %matching characters?
        if (ch_str2 == ch_str1) 
        
            cost = 0;
        
        else cost = 1;
        
        end   
            
        dist_ins = d(i+1,j+2) + 1;  %insertion of character 
        dist_del = d(i+2,j+1) + 1;  %deletion of character 
        dist_rep = d(i+1,j+1) + cost;  %replacement of character 
        
        %% Tansposition
        
        %Transposition cost is: (cost before transposition) + (distance
        %between rows) + (distance between columns) + 1
        
        %once the algorithm realices with last_matching_row and
        %last_match_col if there was a matching char like str2(j) in a row before and
        %in which column the last general match was respectively, it
        %automatically finds a low 'cost before transposition' since
        %last_matching_row and last_match_col are larger than 1. 
        
        %--> get away from first row/column with max_dist values 
        
        %because all char between the transposition are treated like
        %insertions or deletions, and damerau_levenshtein only allows for
        %either one of them, one can check this with the following: 
        
        %i-last_matching_row: must be zero if no addition of a char is
        %needed
        
        %j-last_match_col: must be zero if no deletion of a char is
        %needed
        
        %--> if neither one of them is zero both would be required and
        %adding togheter both will couse a total cost of a transposition
        %much larger than other operations.
    
        dist_transp = d(last_matching_row,last_match_col) + (i-last_matching_row) + (j-last_match_col) +1; %transposition of two characters
        
        %% Assign minimum distance to current cell
        
        %min_dist = min(min(min(dist_ins,dist_del),dist_rep),dist_transp);
        
        d(i+2,j+2) = min(min(min(dist_ins,dist_del),dist_rep),dist_transp); 
        
        %if there was a general match in the current row = i, the column needs to be
        %stored in last_match_col; 
        
        %last_match_col and last_matching_row are 1 lower than they should 
        %be to simplify logic 
        
        if (cost == 0)
            
            last_match_col = j+1;
            
        end
        
    end    
   
    %when one steps a row = i further, the row of the current char from
    %str1(i) must be stored at its ASCII position since one wants to know
    %in which row what character was
    
        last_row_ch_str2(ch_str2) = i+1; 
        
          
end

D = d(n2,m2);
end





