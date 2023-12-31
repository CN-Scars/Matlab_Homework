function [func, search_space_lower_bound, search_space_upper_bound, optim_type] = select_func(func_num)
    switch func_num
        case 1
            func = @(x) michalewicz(x);
            search_space_lower_bound = [0, 0];
            search_space_upper_bound = [pi, pi];
            optim_type = 'min';
        case 2
            func = @(x) beale(x);
            search_space_lower_bound = [-4.5, -4.5];
            search_space_upper_bound = [4.5, 4.5];
            optim_type = 'min';
        case 3
            func = @(x) easom(x);
            search_space_lower_bound = [-100, -100];
            search_space_upper_bound = [100, 100];
            optim_type = 'min';
        case 4
            func = @(x) rastrigin(x);
            search_space_lower_bound = [-5.12, -5.12];
            search_space_upper_bound = [5.12, 5.12];
            optim_type = 'max';
        case 5
            func = @(x) schwefel(x);
            search_space_lower_bound = [-500, -500];
            search_space_upper_bound = [500, 500];
            optim_type = 'max';
        otherwise
            error('Invalid function number! Please select a number between 1 and 5.');
    end
end

function y = michalewicz(x)
    m = 10;
    d = numel(x);
    sum = 0;
    for ii = 1:d
        xi = x(ii);
        new = sin(xi) * (sin(ii*xi^2/pi))^(2*m);
        sum  = sum + new;
    end
    y = -sum;
end

function y = beale(x)
    x1 = x(1);
    x2 = x(2);
    y = (1.5 - x1 + x1*x2)^2 + (2.25 - x1 + x1*x2^2)^2 + (2.625 - x1 + x1*x2^3)^2;
end

function y = easom(x)
    x1 = x(1);
    x2 = x(2);
    y = -cos(x1)*cos(x2)*exp(-((x1-pi)^2+(x2-pi)^2));
end

function y = rastrigin(x)
    n = numel(x);
    A = 10;
    y = A*n + sum(x.^2 - A*cos(2*pi*x));
end

function y = schwefel(x)
    n = numel(x);
    y = 418.9829*n - sum(x.*sin(sqrt(abs(x))));
end
