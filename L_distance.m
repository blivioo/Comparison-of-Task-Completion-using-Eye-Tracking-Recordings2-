%% function for levenshtein distance 

function [D,d] = L_distance(str1,str2) 

m = length(str1); 
n = length(str2); 

d = zeros(n+1,m+1); 

for i=1:n
    d(i+1,1)=i;
end

for j=1:m
    d(1,j+1)=j;
end

for i=1:n
    for j=1:m
        if (str2(i) == str1(j))
            d(i+1,j+1)=d(i,j);
        else
            d(i+1,j+1)=1+min(min(d(i+1,j),d(i,j+1)),d(i,j));
        end
    end
end

D=d(n+1,m+1);

end

