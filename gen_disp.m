% 示例数据矩阵（多行数据）
close all
clear all
clc
%%
N_config = 1000;
for i = 1:N_config
    u_i = load(['./data/u_population1_',num2str(i),'.dat']);
    fileID = fopen(['./data/ph3_u_',num2str(i),'.dat'], 'w');
    fprintf(fileID, '    - [   % .16f,   % .16f,   % .16f ]\n', u_i');
    fclose(fileID);
end
%%
