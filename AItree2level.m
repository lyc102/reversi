function [u,currentColor,pass] = AItree2level(u,currentColor,pass)
%% AIPOSITIONVALUE put a stone by a position value
%
% This is the simplest move strategy: randomly chose a valid location.
%
% Long Chen 2019. May. 15.

%% Get all possible location and value
[validPosition,value,tempPass] = positionvalue(u,currentColor,0);
% plotgame(u);
% showvalue(validPosition,value,currentColor);
if tempPass % no valid position, then pass
   pass = pass + 1;
   currentColor = - currentColor;
   return
end
%% Compute the value of the opponent and subtract max
for i = 1:length(validPosition)
    [tempu,tempColor] = putstone(u,validPosition(i),currentColor,0); 
    [tempPosition,tempValue,tempPass] = positionvalue(tempu,tempColor,0);
%     figure(1); clf; 
%     plotgame(tempu); 
%     showvalue(tempPosition,tempValue,tempColor);
    if ~tempPass
        value(i) = value(i) - max(tempValue(:));
    end
end
%% Put the stone in the best position
[flipNum,bestpt] = max(value);
[u,currentColor] = putstone(u,validPosition(bestpt),currentColor); 
pass = 0;