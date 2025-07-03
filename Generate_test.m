% Add path for csi_tool_box and clear workspace
addpath('./csi_tool_box');
savepath;
clear all;
clc;

% Define the folder path containing the .dat files
inputFolder = './Data_room3/Sweep/';
outputFolder = './Raw_room3/Sweep/';

% Define the pattern for the filenames (e.g., 'user6-1-*.dat')
filePattern = fullfile(inputFolder, 'user3-2-*.dat');
datFiles = dir(filePattern); % List all files matching the pattern

% Loop through each .dat file and process it
for i = 1:length(datFiles)
    % Construct full filename for the .dat file
    datFilename = fullfile(datFiles(i).folder, datFiles(i).name);
    
    % Load features from the .dat file
    [feature] = csi_get_all(datFilename);

    % Extracting metadata from the filename
    [~, name, ~] = fileparts(datFilename); % Get the filename without extension
    parts = strsplit(name, '-'); % Split the filename by '-'

    % Extracting the components from the filename
    userID = str2double(parts{1}(end)); % Last character of userID
    gestureType = str2double(parts{2}); % Gesture type
    torsoLocation = str2double(parts{3}); % Torso location
    faceOrientation = str2double(parts{4}); % Face orientation
    repetitionNumber = str2double(parts{5}); % Repetition number
    receiverID = str2double(parts{6}(end)); % Last character of receiverID

    % Constructing the cond vector
    room = 2; % Default room number
    cond = [room, gestureType, torsoLocation, faceOrientation, receiverID, userID];

    % Create the corresponding .mat filename
    outputFilename = fullfile(outputFolder, [name '.mat']);
    
    % Save the feature and cond variables to a .mat file
    save(outputFilename, 'feature', 'cond');
    
    % Display success message for each file
    disp(['Data saved to ' outputFilename]);
end

% Display final success message
disp('All files processed successfully.');
