
function PathFindingFloyd(input, num_of_satellites_each, a, b)
%PathFindingFloyd 
%
%  find path from u to v
%  
%  input : network adjacency matrix, recording the distance
%  a, b :  pairs of number [i, j], denoting staring S and the end S.
%  N : matrix size
%  
%  pathVector is set to be a global variable, recording satellites along
%  the path. It records their indexes in the adjacency matrix networkM.

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
% time complexity : O(n^3) 最终得到output图 表示两两卫星之间最短权重距离
% map图表示两两卫星之间最短路径至少通过哪个点，随后可以用递归函数得到最短路径

% u : index of the starting point. v : index of the end point.
u = num_of_satellites_each * (a(1) - 1) + a(2);
v = num_of_satellites_each * (b(1) - 1) + b(2);

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
