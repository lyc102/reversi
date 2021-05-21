function [u,currentColor,pass] = AIpositionvalue(u,currentColor,pass,flag)
%% AIPOSITIONVALUE put a stone by a position value
%
%
% Long Chen 2019. May. 14.

if ~exist('flag','var')  % flag = 0 is used to count the possible flip
    flag = 1;     
end
%% Get all possible location and value
[validPosition,value,tempPass] = positionvalue(u,currentColor,0);
% plotgame(u);
% showvalue(validPosition,value,currentColor);
% oldvalue = value;
if tempPass % no valid position, then pass
   pass = pass + 1;
   currentColor = - currentColor;
   return
end
%% Put the stone in the best position
[flipNum,bestpt] = max(value);
if flipNum >0
    [u,currentColor] = putstone(u,validPosition(bestpt),currentColor,flag); 
    pass = 0;
end