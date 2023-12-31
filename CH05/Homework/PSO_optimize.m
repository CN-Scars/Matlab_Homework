function [global_gbest_value] = PSO_optimize(num_iterations, num_teams, num_dims, target_func, w, c1, c2, search_space_lower_bound, search_space_upper_bound, optim_type)
    % 初始化
    pset = zeros(num_iterations, num_teams, num_dims);  % 粒子集
    pset(1, :, :) = rand(num_teams, num_dims) .* (search_space_upper_bound - search_space_lower_bound) + search_space_lower_bound;  % 初始位置
    value = zeros(num_iterations, num_teams);  % 函数值
    velocity = zeros(num_teams, num_dims);  % 初始速度为0
    gbest_value = zeros(num_iterations, 1);  % 全局最优解的值
    
    % 计算初始函数值
    for i = 1:num_teams
        value(1, i) = target_func(pset(1, i, :));
    end

    % 根据优化类型调整value
    if strcmp(optim_type, 'max')
        value = -value;
    end
    
    % 初始个体最优和全局最优
    pbest = squeeze(pset(1, :, :));
    gbest_idx = find(value(1, :) == min(value(1, :)), 1);
    gbest = pbest(gbest_idx, :);
    gbest_value(1) = -value(1, gbest_idx);  % 存储全局最优解的值
    
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
                pset(t, n, v) = min(max(pset(t, n, v), search_space_lower_bound(v)), search_space_upper_bound(v));
            end
            % 计算函数值
            value(t, n) = target_func(squeeze(pset(t, n, :)));
            
            % 根据优化类型调整value
            if strcmp(optim_type, 'max')
                value(t, n) = -value(t, n);
            end
            
            % 更新个体最优
            if value(t, n) < min(value(1 : t-1, n))
                pbest(n, :) = squeeze(pset(t, n, :));
            end
        end
       % 更新全局最优
       [min_value, min_idx] = min(value(t, :));
       if strcmp(optim_type, 'max')
           min_value = -min_value;  % 对于“max”类型，将值反转回去
       end
       if min_value < gbest_value(t-1)
           gbest_value(t) = min_value;
           gbest = squeeze(pset(t, min_idx, :));
       else
           gbest_value(t) = gbest_value(t-1);
       end

        % 更新3D图
        clf;  % 清除当前figure窗口
        subplot(1, 3, 1)
        set(gcf, 'position', [200, 300, 1600, 400])
        mesh(X,Y,Z);
        hold on;
        if strcmp(optim_type, 'max')
            plot3(pset(t,:,1), pset(t,:,2), -value(t,:), 'r*');
        else
            plot3(pset(t,:,1), pset(t,:,2), value(t,:), 'r*');
        end
        hold off;
    
        % 绘制等高线图
        subplot(1, 3, 2)
        contour(X,Y,Z);
        hold on;
        plot(pset(t,:,1), pset(t,:,2), 'r*');
        hold off;
        
        % 更新收敛曲线图
        subplot(1, 3, 3)
        plot(gbest_value(1:t), 'k-^', 'DisplayName','全局最优值');

        title('全局最优值变化');
        xlabel('迭代次数');
        ylabel('函数值');
        legend('Location','eastoutside'); % 显示图例，并放到图形的外右边
        pause(0.02);
    end

    global_gbest_value = gbest_value(end);
end