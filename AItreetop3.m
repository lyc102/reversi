function [u,currentColor,pass,bestpt] = AItreetop3(u,currentColor,pass,depth,topN,flag)
%% AITREETOP3 put a stone by tree search with width pruning
%
% [u,currentColor,pass] = AItreetop3(u,currentColor,pass,depth,topN,flag)
% find the best position by tree search with width pruning. 
%  - depth: depth of the tree
%  - topN: width of the tree
% The children nodes of one father is sorted descendly and only search the
% topN nodes.
%
% Long Chen 2019. May. 16.

if ~exist('flag','var')  % flag = 0 is used to count the possible flip
    flag = 1;     
end
%% Get all possible location and value
[validPosition,value,tempPass] = positionvaluetop3(u,currentColor,depth,topN);
% showvalue(validPosition,value,currentColor);
if tempPass % no valid position, then pass
%    pause
   pass = pass + 1;
   currentColor = - currentColor;
   bestpt = 0;
   return
end
%% Put the stone in the best position
[flipNum,bestpt] = max(value);
bestpt = validPosition(bestpt);
[u,currentColor] = putstone(u,bestpt,currentColor,flag); 
pass = 0;