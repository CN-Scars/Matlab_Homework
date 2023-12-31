% Homework 02:
% 产生 1 个 10x2 的随机矩阵为 p，产生 1 个 10x1 的随机矩阵为 s1，产生 1 个 10x1 的
% 随机矩阵(范围为-0.5~0.5之间)为 s2，产生 1 个 10x2 的零矩阵为 n。命名 S2 矩阵
% 中的最大数值为 c，若 s1 的第 i 行值小于 c 时，则把 p 的第 i 行放置到 n 的第 i 行。

% 产生一个 10x2 的随机矩阵 p
p = rand(10, 2);

% 产生一个 10x1 的随机矩阵 s1
s1 = rand(10, 1);

% 产生一个 10x1 的随机矩阵 s2，范围为 -0.5 到 0.5
s2 = rand(10, 1) - 0.5;

% 找到 s2 矩阵中的最大数值
c = max(s2);

% 产生一个 10x2 的零矩阵 n
n = zeros(10, 2);

% 遍历每一行
for i = 1:10
    % 如果 s1 的第 i 行值小于 c，则把 p 的第 i 行放置到 n 的第 i 行
    if s1(i) < c
        n(i, :) = p(i, :);
    end
end

% 输出结果
disp('矩阵p:');
disp(p);

disp('矩阵s1:');
disp(s1);

disp('矩阵s2:');
disp(s2);

disp('s2的最大值c的值为:');
disp(c);

disp('矩阵n:');
disp(n);
