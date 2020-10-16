%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is an examplar file on how the NeLC-MS [1] program could be used.
%
% [1] CHENG Yu-sheng, ZHAO Da-wei, ZHAN Wen-fa, WANG Yi-bin.
%     Multi-label learning of non-equilibrium labels completion with mean shift.
%     Neurocomputing, 2018, 321: 92-102.
%
% Please feel free to contact me (zhaodwahu@163.com), if you have any problem about this programme.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;clc
%%load data
addpath(genpath('.'));
load('emotion.mat')
%% set parameter
bandwidth=0.5;%Suggest set to 0.5. Width.
s=1;%Suggest set to 1. Smoothing parameter.
alpha=0.4;%Suggest set to [0.1-0.5]. Non-equilibrium parameter.

%% the non-equilibrium label completion matrix construction
Conf= NeLC(train_target,alpha,s);
newtrain_target=Conf*train_target;

%%Reconstructing features using mean shift
dist_matrix = matrixtrain(train_target,train_data);
[clustCent,data2cluster,cluster2dataCell] = MeanShiftCluster(dist_matrix,bandwidth);
[clustering,matrix_fai] = deal(clustCent,cluster2dataCell,dist_matrix);
%%Calculation Weight
Weights=real(pinv(matrix_fai)*(newtrain_target'));
%%Predict
[result,Outputs,Pre_Labels] = matrixtest(train_data,test_data,test_target,Weights,clustering,matrix_fai);
rmpath(genpath('.'));