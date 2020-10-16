function dist_matrix = matrixtrain(train_target,train_data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is designed to train. 
%
%   Syntax
%
%   INPUT:  train_data        - training sample features, N-by-D matrix.
%           train_target      - training sample labels, l-by-N row vector.
%   OUTPUT: dist_matrix       - this is a distance of train_data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [~,num_train]=size(train_target);                            % train_target为一列表示一个样本的类别
    dist_matrix=zeros(num_train,num_train);
     for i=1:(num_train-1)
         if(mod(i,100)==0)
             disp(strcat('Computing distance for train data:',num2str(i)));
         end
         vector1=train_data(i,:); 
         for j=(i+1):num_train
            vector2=train_data(j,:);
            dist_matrix(i,j)=sqrt(sum((vector1-vector2).^2));               % 计算第i，j两个样本的欧几里得距离 实质上就是求取相似度
            dist_matrix(j,i)=dist_matrix(i,j);                              % 相似度矩阵
         end
     end
    dist_matrix=dist_matrix+dist_matrix';
end



