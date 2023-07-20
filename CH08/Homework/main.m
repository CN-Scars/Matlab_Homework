% 初始参数
A = [2, 1, 1; 
     1, 1, 0;
     0, 1, 2];
B = [1, 2;
     3, 1;
     1, 1];
C = [1, 0, 0;
     0, 0, 1];
x = zeros(3, 1);
r = [1; 1];

% 计算反馈增益K 和 参考增益F
EmuD1 = 0;
EmuD2 = 0;
[K,F] = Axui_FeedbackGain(EmuD1, EmuD2);

T = 0.01;
num_steps = 1000;

% 用于存储每个时间步的输出
y = zeros(2, num_steps);

% 模拟
for k = 1:num_steps
    % 使用控制器计算输入
    u = -K*x + F*r;
    % 更新系统状态
    x = T * (A * x + B * u) + x;
    % 计算并存储输出
    y(:, k) = C * x;
end

% 创建时间向量
t = (0:num_steps-1) * T;

% 绘制输出
figure;
plot(t, y(1, :), 'DisplayName', 'y1');
hold on;
plot(t, y(2, :), 'DisplayName', 'y2');
hold off;
title('Outputs y1 and y2 over time');
xlabel('Time');
ylabel('Output');
legend;
