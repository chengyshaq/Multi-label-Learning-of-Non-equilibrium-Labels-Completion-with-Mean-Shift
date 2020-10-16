function [result,Outputs,Pre_Labels] = matrixtest(train_data,test_data,test_target,Weights,clustering,matrix_fai)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is designed to test. 
%
%   Syntax
%
%   INPUT:  train_data        - training sample features, N-by-D matrix.
%           test_data         - testing sample features, N_test-by-D matrix.
%           test_target       - testing sample labels, l-by-N row vector.
%           Weights           - N x L matrix of train Weights.
%           Clustering        - N x 1 cell of cluster centers.
%           matrix_fai        - N x N matrix of feature.
%   OUTPUT: result            - this is a result of evaluation indexes.
%           Predict_Labels    - predicted labels, num_label-by-N_test row vector.
%           Outputs           - L x N_test data matrix of scores
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [num_test,~]=size(test_data);   
    [num_class,~]=size(test_target);
    Outputs=zeros(num_class,num_test);
    Pre_Labels=zeros(num_class,num_test);
    
    [~,num_cluster] = size(matrix_fai);
    for i=1:num_test
        if(mod(i,100)==0)
             disp(strcat('Computing distance for test data:',num2str(i)));
        end
        vector1 = test_data(i,:);
        for j=1:num_cluster
            index=clustering{j,1};        
            vector2=train_data(index,:);
            dist_matrix(i,index)=sqrt(sum((vector1-vector2).^2));               % 计算第i，j两个样本的欧几里得距离 实质上就是求取相似度
            dist_matrix(index,i)=dist_matrix(i,index);                              % 相似度矩阵
            tempvec(1,j)=dist_matrix(index,i)';
        end
            Outputs(:,i)=(tempvec*Weights)'; 
    end
 
     for i=1:num_test
         for j=1:num_class
             if(Outputs(j,i)>=0)
                 Pre_Labels(j,i)=1;
             else
                 Pre_Labels(j,i)=-1;
             end
         end
     end
     
     result.HammingLoss=Hamming_loss(Pre_Labels,test_target);
    
     result.RankingLoss=Ranking_loss(Outputs,test_target);
     result.OneError=One_error(Outputs,test_target);
     result.Coverage=coverage(Outputs,test_target);
     result.Average_Precision=Average_precision(Outputs,test_target);
end



