clear all;
clc;
close all;

%% Load Training Data
t = cputime;
fprintf('Loading and Visualizing Data\n')

load('./dataset/normal_heartbeat_dataset.mat');
load('./dataset/murmur_heartbeat_dataset.mat');
load('./dataset/extrastole_heartbeat_dataset.mat');


Xtrain = [normal_dataset(:, 1:80).'; murmur_dataset(:, 1:35).'; extrastole_dataset(:, 1:25).'];
Xtest = [normal_dataset(:, 81:115).'; murmur_dataset(:, 36:55).'; extrastole_dataset(:, 26:37).'];

% 0 : not normal
% 1 : normal
% one-hot encoding

Ytrain = [ones(80, 1) ; ones(60 ,1)*2;];
Ytest = [ones(35, 1); ones(32,1)*2;];

save './dataset/heartbeat_TrainTestData.mat' Xtrain Xtest Ytrain Ytest
fprintf('Save complete : heartbeat_TrainTestData.mat\n')