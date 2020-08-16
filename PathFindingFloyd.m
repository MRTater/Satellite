function PathFindingFloyd(input, num_of_satellites_each, s, e)
%PathFindingFloyd 
%
%  find path from u to v
%  
%  input : network adjacency matrix, recording the distance
%  s, e :  pairs of number [i, j], denoting staring S and the end S.
%  N : matrix size
%  
%  pathVector is set to be a global variable, recording satellites along
%  the path. It records their indexes in the adjacency matrix networkM.

global pathVector;

         

[~,N] = size(input);
map = zeros(N,N);
% get the size of the input matrix. construct a N*N matrix "map" used to
% record intermediate nodes on the shortest path between two satellites

for k = 1 : N
    if mod(k, 50) == 0 || k == N
        print = ['constructing : waiting ', num2str(k), ...
                          ' of ',num2str(N), ' in total.'];
        disp(print)
    end
   for i = 1 : N
       for j = 1 : N
           if(input(i,j) > input(i,k) + input(k,j) && input(i,k) ~= -1 && input(k,j) ~= -1)
               input(i,j) = input(i,k)+ input(k,j);
               map(i,j) = k;
               map(j,i) = k;
           elseif(input(i,j) == -1 && input(i,k) ~= -1 && input(k,j) ~= -1)
               input(i,j) = input(i,k) + input(k,j);
               map(i,j) = k;
               map(j,i) = k;
           end
       end
   end       
end
% time complexity : O(n^3). 
% map : recording the intermediate nodes on the shortest path between two 
% satellites. hereafter, we can get the shortest path between u and v by 
% recurrence.

% u : index of the starting point. v : index of the end point.
u = num_of_satellites_each * (s(1) - 1) + s(2);
v = num_of_satellites_each * (e(1) - 1) + e(2);

pathVector = [ ];
path(u,v,map);
pathVector = [u,pathVector,v];

pathVector

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
