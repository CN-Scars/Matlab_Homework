clc; clear all; close all;

% 初始化
num_iterations = 100;  % 迭代次数
num_teams = 50;  % 团队数
pset = zeros(num_iterations, num_teams, 2);  % 粒子集
pset(1, :, :) = rand(num_teams, 2)*6 - 3;  % 初始位置
water_level = zeros(num_iterations, num_teams);  % 水位
velocity = zeros(num_teams, 2);  % 初始速度为0

% 计算初始水位
for i = 1:num_teams
    water_level(1, i) = peaks(pset(1, i, 1), pset(1, i, 2));
end

% 初始个体最优和全局最优
pbest = squeeze(pset(1, :, :));
gbest_idx = find(water_level(1, :) == max(water_level(1, :)), 1);
gbest = pbest(gbest_idx, :);

w = 0.3;  % 惯性权重
c1 = 0.5;  % 参数c1
c2 = 0.7;  % 参数c2

% 迭代
for t = 2:num_iterations
    for n = 1:num_teams
        % 更新位置
        for v = 1:2
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
    [a, b] = find(water_level(1 : t, :) == max(max(water_level(1 : t, :))), 1);
    gbest = squeeze(pset(a, b, :));
end

% 线条和标记样式
line_styles = {'-', '--', ':', '-.'};
marker_styles = {'o', '+', '*', '.'};

% 绘图
figure; % 5个子图
subplot(num_teams+1, 1, 1);
plot(max(water_level, [], 2), 'k-^');
title('找到的最高水位');
xlabel('迭代次数');
ylabel('水位');
for i = 1:num_teams
    subplot(num_teams+1, 1, i+1);
    plot(water_level(:, i), line_styles{mod(i-1,4)+1}, 'Marker', marker_styles{mod(i-1,4)+1});
    title(['团队 ', num2str(i)]);
    xlabel('迭代次数');
    ylabel('水位');
end

figure; % 合成图
hold on;
plot(max(water_level, [], 2), 'k-^', 'DisplayName','最高水位');
for i = 1:num_teams
    plot(water_level(:, i), line_styles{mod(i-1,4)+1}, 'Marker', marker_styles{mod(i-1,4)+1}, 'DisplayName',['团队 ', num2str(i)]);
end
title('团队搜寻水位变化');
xlabel('迭代次数');
ylabel('水位');
legend('Location','eastoutside'); % 显示图例，并放到图形的外右边
hold off;
