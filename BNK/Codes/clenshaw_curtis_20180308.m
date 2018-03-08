% 假定要对方程f(x)在[-1,1]求积
x = chebfun('x');
f = @(x) x.*sin(2*exp(2*sin(2*exp(2*x)))); 
% 输入help @查询命令
% .* 表示按元素相乘 *表示矩阵乘
fc = chebfun(f);
LW = 'linewidth';
FS = 'fontsize';
MS = 'markersize';
figure, plot (fc, LW, 1.2)
title('Function f', FS, 16)

% 输出积分的数值近似值
format  long
Ichebfun = sum(fc)

% 求积近似过程中，使用了多少插值点
Npts = length(fc)

[s,w] = chebpts(Npts); % 使用chebshev points
% s 是在[-1,1]之间插值的若干点(N)
% w 是对应的权重矩阵
% 两个矩阵相乘，得到求积的值，命名为Iclenshawcurtis，等同于sum(fc)的命令
Iclenshawcurtis = w * f(s)

% 也可以尝试用Legendre points (gauss-legendre求积算法)
[s,w] = legpts(Npts);
Igauss = w * f(s)

figure, tic, err = [];
NN = 10:10:500 % 在[10,500]之间以10为单位，创建一个矢量
for Npts = NN
    [s,w] = legpts(Npts);
    Igauss = w*f(s);
    err = [err abs(Igauss-Ichebfun)];
end

% 绘出采用Gauss-legendre算法，误差项的收敛情况. semilogy与plot命令类似，除了similogy输出log形式的值
semilogy(NN, err, '.-', LW, 1, MS, 16), grid on
ylim([1e-18 1])
xlabel('Npts', FS, 12), ylabel('Error', FS, 12)
title('Gauss quadrature convergence', FS, 16), toc % toc 输出计算时间

% 现在将Gauss-Legendre算法和Clenshaw-Curtis算法的误差收敛情况都绘制出来
hold on, tic, err = [];
for Npts = NN
    [s,w] = chebpts(Npts);
    Iclenshawcurtis = w * f(s);
    err = [err abs(Iclenshawcurtis-Ichebfun)];
end
semilogy(NN, err, '.-r', LW, 1, MS, 16)
title('Gauss-Legendre and Clenshaw-Curtis', FS, 16)
legend('Gauss-Legendre', 'Clenshaw-Curtis', 'location', 'southwest'), toc