function [output] = PathFindingFloyd()
%GOMORYHU_TREE 此处显示有关此函数的摘要
%  输入出发点卫星的编号和结尾点卫星的编号，输入总卫星个数，以及连接矩阵
%  N是
input = [0 2 3
         2 0 6
         3 6 0];
[~,N] = size(input);
for k = 1 : N
   for i =1 : N
       for j = 1 : N
           if(input(i,j) > input(i,k) + input(k,j))
               input(i,j) = input(i,k)+ input(k,j);
           end
       end
   end       
end

output = input;
end

