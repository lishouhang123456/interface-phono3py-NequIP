close all
clear all
clc
%%
N_ATOMS_UNIT=2;
SUPERCELL=[4 4 4];
N_ATOMS_TOT=SUPERCELL(1)*SUPERCELL(2)*SUPERCELL(3)*N_ATOMS_UNIT;
N_LINE_FRAME=N_ATOMS_TOT+2;
N_CONFIGS=1000;
POPULATION=1;
FILEOUT="tmp.xyz";
fid = fopen(FILEOUT, 'r');
energy = zeros(N_CONFIGS,1);
energy_file = sprintf('./data/energies_supercell_population%d.dat', POPULATION);
force_char = "     Forces acting on atoms (Ry/au):\n\n";
atm_index = 1:N_ATOMS_TOT;
type_index = 1;
for N = 1:N_CONFIGS
    force_file = sprintf('./data/forces_population%d_%d.dat', POPULATION, N);
    stress_file = sprintf('./data/pressures_population%d_%d.dat', POPULATION, N);
    fgetl(fid); % 读取并丢弃第一行
    sed_line = fgetl(fid);
    % 使用正则表达式提取 stress 部分
    pattern = 'stress="([^"]+)"'; % 匹配 stress="..." 之间的内容
    matches = regexp(sed_line, pattern, 'tokens'); % 提取匹配的内容

    % 提取的字符串（存储为 cell array）
    stress_str = matches{1}{1};

    % 将空格分隔的数字转为数组
    stress_values = str2num(stress_str)/-91.8158;
    s1 = stress_values(1:3);
    s2 = stress_values(4:6);
    s3 = stress_values(7:9);
    stress_values = [s1;s2;s3];
    % dlmwrite(stress_file, stress_values, 'delimiter', ' ', 'precision', '%.8f');


    % 使用正则表达式提取 energy 后的数值
    pattern = 'energy=([\-+]?[0-9]*\.?[0-9]+)';  % 匹配 energy= 后的数字
    matches = regexp(sed_line, pattern, 'tokens');  % 提取匹配的内容

    % 提取的字符串（存储为 cell array）
    energy_str = matches{1}{1};

    % 将字符串转换为数字
    energy_value = str2double(energy_str)/ 13.6057;
    energy(N) = energy_value;

    L1 = (N - 1) * N_LINE_FRAME + 1;
    lines = cell(N_ATOMS_TOT, 1);  % 创建一个用于存储结果的单元格数组

    for i = 3:N_LINE_FRAME
        line = fgetl(fid);  % 读取每一行
        if ischar(line)
            % 去除每行的第一个字符
            line = line(3:end);  % 从第二个字符到行尾
            lines{i-2} = line;  % 存储处理后的行
        end
    end
    lines = cell2mat(lines);
    lines = str2num(lines);
    force = lines(:,5:7)/25.7110;
    % force_file=[".data/forces_population",num2str(POPULATION),num2str(i),".dat"]
    % dlmwrite(force_file, force, 'delimiter', ' ', 'precision', '%.8f');
    fid_f = fopen(force_file, 'w');
    fprintf(fid_f,force_char);
    for i = 1:size(force,1)
        fprintf(fid_f, '     atom%5d type%3d   force = %14.8f %14.8f %14.8f\n', i, type_index, force(i,1), force(i,2), force(i,3));
    end
    fclose(fid_f);
end
fclose(fid);
%%
% dlmwrite(energy_file, energy, 'delimiter', ' ', 'precision', '%.8f');
