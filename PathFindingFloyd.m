
function PathFindingFloyd()
%PathFindingFloyd 
%  输入出发点卫星的编号和结尾点卫星的编号，输入总卫星个数，以及连接矩阵(1,2表示1号卫星和2号卫星之间的权重，-1为距离无限远）
%  N是矩阵大小
input = [0 2 3 10
         2 0 8 10
         3 8 0 1
         10 10 1 0];
%      测试输入

global pathVector;

[~,N] = size(input);
map = zeros(N,N);
output = zeros(N,N);
% 获取输入矩阵的大小 并且创建一个一样大小的用于记录路径的map

for k = 1 : N
   for i = 1 : N
       for j = i : N
           if(input(i,j) > input(i,k) + input(k,j) && input(i,k) ~= -1 && input(k,j) ~= -1)
               output(i,j) = input(i,k)+ input(k,j);
               map(i,j) = k;
           end
       end
   end       
end
% 复杂度n^3 最终得到output图 表示两两卫星之间最短权重距离
% map图表示两两卫星之间最短路径至少通过哪个点，随后可以用递归函数得到最短路径
% u为起始 v为终点
u = 2;v = 4;

pathVector = [ ];
path(u,v,map);
pathVector = [u,pathVector,v];
end

function path(u,v,map)
global pathVector;
if map(u,v) == 0
    return
end
path(u,map(u,v),map);
pathVector(end+1) = map(u,v);
path(map(u,v),v,map);
end
