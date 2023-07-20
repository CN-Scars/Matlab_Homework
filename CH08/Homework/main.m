clc; clear all; close all;

% 初始参数
num_iterations = 200;  % 迭代次数
num_teams = 20;  % 种群数量
num_dims = 2;  % 问题的维度
w = 0.8;  % 惯性因子
c1 = 2;  % 学习因子1
c2 = 2;  % 学习因子2
search_space_lower_bound = [-1, -1];  % 搜索空间的下界
search_space_upper_bound = [1, 1];  % 搜索空间的上界

% PSO优化
[gbest, gbest_value] = PSO_optimize(num_iterations, num_teams, num_dims, @error_function, w, c1, c2, search_space_lower_bound, search_space_upper_bound);

% 输出最佳控制增益
fprintf('最佳控制增益 EmuD1 = %f, EmuD2 = %f\n', gbest(1), gbest(2));
fprintf('最小误差 = %f\n', gbest_value(end));

% 使用最佳控制增益运行系统模拟并绘制y1和y2
A = [2, 1, 1; 
     1, 1, 0;
     0, 1, 2];
B = [1, 2;
     3, 1;
     1, 1];
C = [1, 0, 0;
     0, 0, 1];
x = zeros(3, 1);
r = [1; 1];

[K, F] = Axui_FeedbackGain(gbest(1), gbest(2));

T = 0.01;
num_steps = 1000;
y = zeros(2, num_steps);
for k = 1:num_steps
    u = -K*x + F*r;
    x = T * (A * x + B * u) + x;
    y(:, k) = C * x;
end

t = (0:num_steps-1) * T;
figure;
plot(t, y(1, :), 'DisplayName', 'y1');
hold on;
plot(t, y(2, :), 'DisplayName', 'y2');
hold off;
title('使用最优增益的y1和y2随时间变化图');
xlabel('时间');
ylabel('输出');
legend('y1', 'y2');
