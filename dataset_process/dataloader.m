clear all;
clc;
close all;

%% Load Training Data
t = cputime;
fprintf('Loading and Visualizing Data\n')

load('normal_heartbeat_dataset.mat');
load('murmur_heartbeat_dataset.mat');
load('extrastole_heartbeat_dataset.mat');


Xtrain = [normal_dataset(:, 1:180).'; murmur_dataset(:, 1:40).'; extrastole_dataset(:, 1:30).'];
Xtest = [normal_dataset(:, 181:223).'; murmur_dataset(:, 41:68).'; extrastole_dataset(:, 31:48).'];

% 1 : normal
% 2 : murmur
% 3 : extrastole

Ytrain = [ones(180, 1) ; ones(40,1)*2; ones(30,1)*3;];
Ytest = [ones(43, 1); ones(28,1)*2; ones(18,1)*3;];

save 'heartbeat_TrainTestData.mat' Xtrain Xtest Ytrain Ytest
fprintf('Save complete : heartbeat_TrainTestData.mat\n')