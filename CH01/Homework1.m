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
