% 示例数据矩阵（多行数据）
close all
clear all
clc
%%
N_atm = 128;
fileID = fopen('super_pos_sscha_frac','w');
load super_pos_frac
%%
for i = 1:N_atm
    fprintf(fileID, '  - symbol: Si # %d\n',i);
    fprintf(fileID, '    coordinates: [ % .15f, % .15f, % .15f ]\n',(super_pos_frac(i,:))');
    fprintf(fileID, '    mass: 28.085500\n');
    fprintf(fileID, '    reduced_to: 1\n');
end
fclose(fileID);
% N_config = 5000;
% for i = 1:N_config
%     u_i = load(['./data/u_population1_',num2str(i),'.dat']);
%     u_i = u_i / 0.529177210544; % in unit of bohr
%     fileID = fopen(['./data/ph3_u_',num2str(i),'.dat'], 'w');
%     fprintf(fileID, '    - [   % .16f,   % .16f,   % .16f ]\n', u_i');
%     fclose(fileID);
% end
%%
