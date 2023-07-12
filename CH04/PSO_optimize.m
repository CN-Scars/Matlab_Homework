function [gbest, gbest_value] = PSO_optimize(num_iterations, num_teams, num_dims, target_func, w, c1, c2, search_space_lower_bound, search_space_upper_bound)
% 初始化
pset = zeros(num_iterations, num_teams, num_dims);  % 粒子集
pset(1, :, :) = rand(num_teams, num_dims) * (search_space_upper_bound - search_space_lower_bound) + search_space_lower_bound;  % 初始位置
value = zeros(num_iterations, num_teams);  % 函数值
velocity = zeros(num_teams, num_dims);  % 初始速度为0
gbest_value = zeros(num_iterations, 1);  % 全局最优解的值

% 计算初始函数值
for i = 1:num_teams
    value(1, i) = target_func(pset(1, i, :));
end

% 初始个体最优和全局最优
pbest = squeeze(pset(1, :, :));
gbest_idx = find(value(1, :) == max(value(1, :)), 1);
gbest = pbest(gbest_idx, :);
gbest_value(1) = value(1, gbest_idx);  % 存储全局最优解的值

% 绘制初始3D图
figure(1);
[X,Y] = meshgrid(search_space_lower_bound:0.1:search_space_upper_bound);
Z = arrayfun(@(x,y) target_func([x,y]), X, Y);
mesh(X,Y,Z);
hold on;

% 迭代
for t = 2:num_iterations
    for n = 1:num_teams
        % 更新位置
        for v = 1:num_dims
            r1 = rand();  % 随机数r1
            r2 = rand();  % 随机数r2
            velocity(n, v) = w * velocity(n, v) + c1 * r1 * (pbest(n, v) - pset(t-1, n, v)) + c2 * r2 * (gbest(v) - pset(t-1, n, v));
            pset(t, n, v) = pset(t-1, n, v) + velocity(n, v);
            % 边界条件
            pset(t, n, v) = min(max(pset(t, n, v), search_space_lower_bound), search_space_upper_bound);
        end
        % 计算函数值
        value(t, n) = target_func(squeeze(pset(t, n, :)));
        % 更新个体最优
        if value(t, n) > max(value(1 : t-1, n))
            pbest(n, :) = squeeze(pset(t, n, :));
        end
    end
    % 更新全局最优
    [max_value, max_idx] = max(value(t, :));
    if max_value > gbest_value(t-1)
        gbest_value(t) = max_value;
        gbest = squeeze(pset(t, max_idx, :));
    else
        gbest_value(t) = gbest_value(t-1);
    end

    % 更新3D图
    figure(1);
    clf;  % 清除当前figure窗口
    mesh(X,Y,Z);
    hold on;
    plot3(pset(t,:,1), pset(t,:,2), value(t,:), 'r*');
    hold off;

    % 绘制等高线图
    figure(2);  % 指定图形窗口2
    clf;  % 清除当前figure窗口
    contour(X,Y,Z);
    hold on;
    plot(pset(t,:,1), pset(t,:,2), 'r*');
    hold off;
    
    % 更新收敛曲线图
    figure(3);  % 指定图形窗口3
    clf;  % 清除当前figure窗口
    plot(gbest_value(1:t), 'k-^', 'DisplayName','全局最优值');
    title('全局最优值变化');
    xlabel('迭代次数');
    ylabel('函数值');
    legend('Location','eastoutside'); % 显示图例，并放到图形的外右边
    pause(0.02);
end

end
