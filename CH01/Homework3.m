% Homework 03:
% 试用 Help 指令了解 randperm 与 sort 两指令的用法，利用两指令产生 1x15 的 1~15 
% 随机不重复排列矩阵 aa，再通过 sort 指令将 aa 矩阵由小排到大以及由大排到小。

% 使用 randperm 函数生成一个 1x15 的 1 到 15 的随机不重复排列矩阵 aa
aa = randperm(15);

% 显示原始随机矩阵
disp('原始的随机矩阵aa:');
disp(aa);

% 使用 sort 函数将 aa 矩阵从小到大排序
[aa_sorted_asc, ~] = sort(aa);

% 显示从小到大排序的矩阵
disp('将aa矩阵按照升序排序的结果:');
disp(aa_sorted_asc);

% 使用 sort 函数将 aa 矩阵从大到小排序
[aa_sorted_desc, ~] = sort(aa, 'descend');

% 显示从大到小排序的矩阵
disp('将aa矩阵按照降序排序的结果:');
disp(aa_sorted_desc);
