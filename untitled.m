% 假设文件名为 'data.txt'
file_name = '2d.txt';

% 打开文件
fid = fopen(file_name, 'r');

%        PositionX        PositionY        PositionZ        MomentumX        MomentumY        MomentumZ             Mass      ChargeMacro             Time       ParticleID       EmissionID          Current     SEEGeneratio
%              [m]              [m]              [m]               []               []               []              [g]              [C]              [s]               []               []              [A]               []


planes = [];

line = 0;
segment = [];
plane_num = 0;


while ~feof(fid)
    line = line + 1;
    str = fgetl(fid);
    if contains(str, "%")
        segment(end+1) = line;
        plane_num = plane_num + 1;
    end        
end
segment(end+1) = line;




for index = 1:plane_num
    fid = fopen(file_name, 'r');
    context_sup = segment(index) + 1; % 上确界
    context_inf = segment(index + 1) - 1; % 下确界
    line = 0;
    temp = [];
    if (context_inf - context_sup) >= 0
        while ~feof(fid)
            str = fgetl(fid);
            line = line + 1;
            
            if (context_sup <= line) && (line <= context_inf)
                split_str = strsplit(str);
                numbers = str2double(split_str);
                result = numbers(2:3);
                temp(end+1,:) = result;
            end        
        end
        % 提取 x 和 y 坐标
        x = temp(:, 1);  % 第一列是 x 坐标
        y = temp(:, 2);  % 第二列是 y 坐标

        % 绘制散点图
        figure;
        scatter(x, y,1, 'filled');  % 'filled' 使得散点为实心圆

        % 添加标题和轴标签
        title_str = 'particle distribution on plane ';
        index_str = num2str(index - 1);
        title(strcat(title_str, index_str));
        xlabel('X-axis');
        ylabel('Y-axis');
        grid on;  % 显示网格
        xticks(-1:0.0001:1);  % 设置 x 轴的刻度间隔
        yticks(-1:0.0001:1);  % 设置 y 轴的刻度间隔
        
    end

end






