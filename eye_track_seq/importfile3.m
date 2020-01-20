%% Import data from text file

function S3 = importfile3(filename, VariableNames, numCol)

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", numCol);

for i = 1:numCol 
    
   VariableTypes(1,i) = ["string"];
   
end

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = VariableNames;
opts.VariableTypes = VariableTypes;
opts = setvaropts(opts, [1, 2], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [1, 2], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
S3 = readtable(filename, opts);

%% Convert to output type
S3 = table2cell(S3);
numIdx = cellfun(@(x) ~isnan(str2double(x)), S3);
S3(numIdx) = cellfun(@(x) {str2double(x)}, S3(numIdx));

end