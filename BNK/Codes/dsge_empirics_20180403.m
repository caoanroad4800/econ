% 从excel中读取数据
temp = xlsread("~/Soft/econ/econ/BNK/data/20180403-empirics.xls", "total");
optgrowth = temp(:,2);
lsh = temp(:,3);
inf = temp(:,4);
intrt = temp(:,4);
mtx = temp(:,2:5);
mtx_autocov = xcov(mtx)

%[aic,bic]=aicbic(temp(:,2), [1,2,3,4])
%Mdl = varm(4,2)

plot(mtx_autocov(90:102,4))
dk = xcov(optgrowth, lsh);
plot(dk(90:102))