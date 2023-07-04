% Homework 01:
% 产生两个 10x1 的随机矩阵，命名为 a 与 b。当 a 的第 i 行个数值大于 b 的第 i 行个
% 数值时，将 a 的第 i 行个数值取代 b 的第 i 行个数值。

a = rand(10, 1);
b = rand(10, 1);

for i = 1:10
    if a(i) > b(i)
        b(i) = a(i);
    end
end

disp('矩阵a:');
disp(a);

disp('矩阵b:');
disp(b);
