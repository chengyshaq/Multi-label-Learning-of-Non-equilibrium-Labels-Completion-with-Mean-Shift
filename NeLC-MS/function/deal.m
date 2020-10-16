function [clustering,matrix_fai] = deal(clustCent,cluster2dataCell,distance_matrix)
result = [];
matrix_fai = [];
clustering = [];
[~,n] = size(clustCent);
for i = 1:n
    temp = cluster2dataCell{i,:};
    if ~isempty(temp)
        result(1,i) = temp(1,1);
    end
end

result(find(result==0)) = [];
[~,m] = size(result);

for j = 1:m
    index = result(1,j);
    matrix_fai(:,j) = distance_matrix(:,index);
end

clustering = num2cell(result');
