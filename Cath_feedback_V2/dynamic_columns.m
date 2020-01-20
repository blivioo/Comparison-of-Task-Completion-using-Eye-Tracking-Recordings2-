%% function to assign dynamic variable names for sseq table


function DV = dynamic_columns(seq)

sizeS = size(seq,1);


if sizeS == 1
 
    DV = {'Surgery1'};
        
end

if sizeS == 2
 
    DV = {'Surgery1' 'Surgery2'};
        
end

if sizeS == 3
 
    DV = {'Surgery1' 'Surgery2' 'Surgery3'};
        
end

if sizeS == 4
 
    DV = {'Surgery1' 'Surgery2' 'Surgery3' 'Surgery4'};
        
end

if sizeS == 5
 
    DV = {'Surgery1' 'Surgery2' 'Surgery3' 'Surgery4' 'Surgery5'};
        
end

if sizeS == 6
 
    DV = {'Surgery1' 'Surgery2' 'Surgery3' 'Surgery4' 'Surgery5' 'Surgery6'};
        
end

if sizeS == 7
 
    DV = {'Surgery1' 'Surgery2' 'Surgery3' 'Surgery4' 'Surgery5' 'Surgery6' 'Surgery7'};
        
end

if sizeS == 8
 
    DV = {'Surgery1' 'Surgery2' 'Surgery3' 'Surgery4' 'Surgery5' 'Surgery6' 'Surgery7' 'Surgery8'};
        
end

if sizeS == 9
 
    DV = {'Surgery1' 'Surgery2' 'Surgery3' 'Surgery4' 'Surgery5' 'Surgery6' 'Surgery7' 'Surgery8' 'Surgery9'};
        
end

if sizeS == 10
 
    DV = {'Surgery1' 'Surgery2' 'Surgery3' 'Surgery4' 'Surgery5' 'Surgery6' 'Surgery7' 'Surgery8' 'Surgery9' 'Surgery10'};
        
end

if sizeS == 11
 
    DV = {'Surgery1' 'Surgery2' 'Surgery3' 'Surgery4' 'Surgery5' 'Surgery6' 'Surgery7' 'Surgery8' 'Surgery9' 'Surgery10' 'Surgery11'};
        
end

if sizeS == 12
 
    DV = {'Surgery1' 'Surgery2' 'Surgery3' 'Surgery4' 'Surgery5' 'Surgery6' 'Surgery7' 'Surgery8' 'Surgery9' 'Surgery10' 'Surgery11' 'Surgery12'};
        
end

if sizeS == 13
 
    DV = {'Surgery1' 'Surgery2' 'Surgery3' 'Surgery4' 'Surgery5' 'Surgery6' 'Surgery7' 'Surgery8' 'Surgery9' 'Surgery10' 'Surgery11' 'Surgery12' 'Surgery13'};
        
end

if sizeS == 14
 
    DV = {'Surgery1' 'Surgery2' 'Surgery3' 'Surgery4' 'Surgery5' 'Surgery6' 'Surgery7' 'Surgery8' 'Surgery9' 'Surgery10' 'Surgery11' 'Surgery12' 'Surgery13' 'Surgery14'};
        
end

if sizeS == 15
 
    DV = {'Surgery1' 'Surgery1' 'Surgery2' 'Surgery3' 'Surgery4' 'Surgery5' 'Surgery6' 'Surgery7' 'Surgery8' 'Surgery9' 'Surgery10' 'Surgery11' 'Surgery12' 'Surgery13' ...
        'Surgery14' 'Surgery15'};
        
end

end


