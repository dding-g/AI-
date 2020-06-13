clear all;
clc;
close all;

%% Load Training Data
t = cputime;
fprintf('Loading and Visualizing Data\n')

load('./dataset/normal_heartbeat_dataset.mat');
load('./dataset/murmur_heartbeat_dataset.mat');
load('./dataset/extrastole_heartbeat_dataset.mat');

%normal_dataset = normal_dataset(:, randperm(size(normal_dataset, 2)));
%murmur_dataset = murmur_dataset(:, randperm(size(murmur_dataset, 2)));
%extrastole_dataset = extrastole_dataset(:, randperm(size(normal_dataset, 2)));

Xtrain = [normal_dataset(:, 1:184).'; murmur_dataset(:, 1:80).'; extrastole_dataset(:, 1:52).'];
Xtest = [normal_dataset(:, 184:231).'; murmur_dataset(:, 81:100).'; extrastole_dataset(:, 52:65).'];

% 1 : normal
% 2 : murmur
% 3 : extrastole
Ytrain = [ones(184, 1) ; ones(80 ,1)*2; ones(52 ,1)*3;];
Ytest = [ones(48, 1); ones(20,1)*2; ones(14,1)*3;];

save './dataset/heartbeat_TrainTestData.mat' Xtrain Xtest Ytrain Ytest
fprintf('Save complete : heartbeat_TrainTestData.mat\n')