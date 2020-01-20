%% Import data from text file

function S1 = importfile1(filename)

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["DoctorPatient", "Sequences"];
opts.VariableTypes = ["string", "string"];
opts = setvaropts(opts, [1, 2], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [1, 2], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
S1 = readtable(filename, opts);

%% Convert to output type
S1 = table2cell(S1);
numIdx = cellfun(@(x) ~isnan(str2double(x)), S1);
S1(numIdx) = cellfun(@(x) {str2double(x)}, S1(numIdx));

end