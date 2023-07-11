clc; clear all; close all;

% 初始化
num_iterations = 100;  % 迭代次数
num_teams = 50;  % 团队数
pset = zeros(num_iterations, num_teams, 2);  % 粒子集
pset(1, :, :) = rand(num_teams, 2)*6 - 3;  % 初始位置
water_level = zeros(num_iterations, num_teams);  % 水位
velocity = zeros(num_teams, 2);  % 初始速度为0
gbest_value = zeros(num_iterations, 1);  % 全局最优解的值

% 计算初始水位
for i = 1:num_teams
    water_level(1, i) = peaks(pset(1, i, 1), pset(1, i, 2));
end

% 初始个体最优和全局最优
pbest = squeeze(pset(1, :, :));
gbest_idx = find(water_level(1, :) == max(water_level(1, :)), 1);
gbest = pbest(gbest_idx, :);
gbest_value(1) = water_level(1, gbest_idx);  % 存储全局最优解的值

w = 0.3;  % 惯性权重
c1 = 0.5;  % 参数c1
c2 = 0.7;  % 参数c2

% 绘制初始3D图
figure;
[X,Y] = meshgrid(-3:0.1:3);
Z = peaks(X,Y);
mesh(X,Y,Z);
hold on;

% 迭代
for t = 2:num_iterations
    for n = 1:num_teams
        % 更新位置
        for v = 1:size(pset, 3) % 使代码更加通用，能够处理任何维度的情况
            r1 = rand();  % 随机数r1
            r2 = rand();  % 随机数r2
            velocity(n, v) = w * velocity(n, v) + c1 * r1 * (pbest(n, v) - pset(t-1, n, v)) + c2 * r2 * (gbest(v) - pset(t-1, n, v));
            pset(t, n, v) = pset(t-1, n, v) + velocity(n, v);
            % 边界条件
            pset(t, n, v) = min(max(pset(t, n, v), -3), 3);
        end
        % 计算水位
        water_level(t, n) = peaks(pset(t, n, 1), pset(t, n, 2));
        % 更新个体最优
        if water_level(t, n) > max(water_level(1 : t-1, n))
            pbest(n, :) = squeeze(pset(t, n, :));
        end
    end
    % 更新全局最优
    [max_value, max_idx] = max(water_level(t, :));
    if max_value > gbest_value(t-1)
        gbest_value(t) = max_value;
        gbest = squeeze(pset(t, max_idx, :));
    else
        gbest_value(t) = gbest_value(t-1);
    end

    % 更新3D图
    clf;  % 清除当前figure窗口
    mesh(X,Y,Z);
    hold on;
    plot3(pset(t,:,1), pset(t,:,2), water_level(t,:), 'r*');
    pause(0.02);
end

figure; % 收敛曲线图
hold on;
plot(gbest_value, 'k-^', 'DisplayName','全局最优水位');
title('全局最优水位变化');
xlabel('迭代次数');
ylabel('水位');
legend('Location','eastoutside'); % 显示图例，并放到图形的外右边
hold off;
