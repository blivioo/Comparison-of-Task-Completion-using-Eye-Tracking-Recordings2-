%% Import data from text file

function S2 = importfile2(filename,UserInput)

%% Setup the Import Options

% prompt = 'Does the surgery you wish to analyse have two characteristic parts as defined by the seperation of left leg (LL) and right leg (RL) seen in the example Novice1.txt or not?(2 or 1)\n';
% 
% UserInput = input(prompt); 

if UserInput == 2 
    
    Var = 3;
    opts.VariableNames = ["Participants", "Part1", "Part2"];
    opts.VariableTypes = ["string", "string", "string"];
    
elseif UserInput == 1
   
    Var = 2;
    opts.VariableNames = ["Participants", "Sequences"];
    opts.VariableTypes = ["string", "string"];

else disp('WRONG INPUT; START AGAIN');
    
end

opts = delimitedTextImportOptions("NumVariables", Var);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = "\t";

% Specify column names and types
% opts.VariableNames = ["Novices", "SequencesLL", "SequencesRL"];
% opts.VariableTypes = ["string", "string", "string"];
opts = setvaropts(opts, [1, 2], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [1, 2], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
S2 = readtable(filename, opts);

%% Convert to output type
S2 = table2cell(S2);
numIdx = cellfun(@(x) ~isnan(str2double(x)), S2);
S2(numIdx) = cellfun(@(x) {str2double(x)}, S2(numIdx));

end