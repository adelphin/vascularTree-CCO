function [spaceDimensions, perfPosition, Qperf, Pperf, Pterm, Nterm, Lmin, Lmax] = readTreeParameters(filePath)

% Reads .txt file to create toDo structure, containing instructions for dico simulation
% filePath is the path to the txt file to read

%% Check if file exists
if ~exist(filePath,'file')
    filePath = which(filePath); % Try to find m-file on the Matlab path
    if isempty(filePath)
        error('Parameter file does not exist.\n');
    end
end

%% Read lines
fid = fopen(filePath,'rt');
if fid > 0
    txtFile = textscan(fid, '%s', 'Delimiter',''); txtFile = txtFile{1};
    fclose(fid);
else
    error('Cannot open Parameter file\n');
    return
end

% evaluate parameters
for i=1:numel(txtFile)
    eval(txtFile{i});
end

end