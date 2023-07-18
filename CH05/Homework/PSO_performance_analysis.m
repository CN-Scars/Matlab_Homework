function result = PSO_performance_analysis(func_num, num_runs, num_iterations, num_teams, num_dims, w, c1, c2)
    % 检查是否存在已有的结果矩阵，如果不存在则创建一个新的空矩阵
    if exist('results.mat', 'file')
        load('results.mat');
    else
        results = [];
    end
    
    [target_func, search_space_lower_bound, search_space_upper_bound, optim_type] = select_func(func_num);
    
    % 存储每次运行的最优值
    best_values = zeros(num_runs, 1);
    
    % 运行 PSO 算法指定次数
    for i = 1:num_runs
        best_values(i) = PSO_optimize(num_iterations, num_teams, num_dims, target_func, w, c1, c2, search_space_lower_bound, search_space_upper_bound, optim_type);
    end
    
    % 计算最优值、平均值和标准差，并将它们添加到结果矩阵
    best = min(best_values);
    mean_value = mean(best_values);
    std_value = std(best_values);
    
    results = [results; [best, mean_value, std_value]];
    
    % 保存结果矩阵
    save('results.mat', 'results');

    figure
    plot(sort(best_values), 'ro-')
    
    % 返回本次运行的结果
    result = [best, mean_value, std_value];
end
