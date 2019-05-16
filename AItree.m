function [u,currentColor,pass] = AItree(u,currentColor,pass,depth)
%% AItree put a stone by tree search
%
%
% Long Chen 2019. May. 16.

%% Get all possible location and value
[validPosition,value,tempPass] = positionvalue(u,currentColor,depth);
% showvalue(validPosition,value,currentColor);
if tempPass % no valid position, then pass
   pass = pass + 1;
   currentColor = - currentColor;
   return
end
%% Put the stone in the best position
[flipNum,bestpt] = max(value);
[u,currentColor] = putstone(u,validPosition(bestpt),currentColor); 
pass = 0;