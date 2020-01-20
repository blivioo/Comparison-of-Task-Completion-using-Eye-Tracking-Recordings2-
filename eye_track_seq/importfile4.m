%% Import data from text file

function S4 = importfile4(filename)

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["SurgerySteps", "Abbreviations"];
opts.VariableTypes = ["string", "string"];
opts = setvaropts(opts, [1, 2], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [1, 2], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
S4 = readtable(filename, opts);

%% Convert to output type
S4 = table2cell(S4);
numIdx = cellfun(@(x) ~isnan(str2double(x)), S4);
S4(numIdx) = cellfun(@(x) {str2double(x)}, S4(numIdx));

end