clc; clear all; close all;

func_num = input('输入 1 到 5 之间的数字以选择函数： ');
num_runs = 30;
num_iterations = 30;
num_team = 40;
num_dims = 2;
w = 0.5;
c1 = 1.0;
c2 = 1.5;

% 运行性能分析函数，并将结果保存到 "results.mat" 文件中
result = PSO_performance_analysis(func_num, num_runs, num_iterations, num_teams, num_dims, w, c1, c2);

% 打印本次运行的结果
disp('本次运行的结果：');
disp(['最优值: ', num2str(result(1))]);
disp(['平均值: ', num2str(result(2))]);
disp(['标准差: ', num2str(result(3))]);

if exist('results.mat', 'file')
    load('results.mat');
    disp('所有运行的结果：');
    disp('最优值、平均值、标准差：');
    disp(results);
end
