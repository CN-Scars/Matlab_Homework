clc; clear all; close all;

func_num = input('输入 1 到 5 之间的数字以选择函数： ');
[target_func, search_space_lower_bound, search_space_upper_bound] = select_func(func_num);
[gbest, gbest_value] = PSO_optimize(30, 40, 2, target_func, 0.3, 0.5, 0.7, search_space_lower_bound, search_space_upper_bound);
