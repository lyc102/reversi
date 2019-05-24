function [u,currentColor,pass] = AIMC(u,currentColor,pass,rollNum,switchNum)
%% AIMC Monte Carlo method
%
% Generate position value by rollout 
%
% Long Chen 2019. May. 18.

p = find(u(:) == 0);
emptyNum = length(p);
%% Get all possible location and value from tree search
if emptyNum > switchNum
    [validPosition,value,tempPass] = positionvaluetop3(u,currentColor,3,5);
else
    [validPosition,value,tempPass] = positionvalue(u,currentColor,0);
end
% showvalue(validPosition,value,currentColor);
if tempPass % no valid position, then pass
   pass = pass + 1;
   currentColor = - currentColor;
   return
end
%% Value from the roll out
rolloutValue = zeros(length(validPosition),1);
if emptyNum < switchNum % the last 20 use MCTS
    for i = 1:length(validPosition)
        [tempu,tempColor] = putstone(u,validPosition(i),currentColor,0); 
        windiff = 0;
        for r = 1:min(rollNum,factorial(emptyNum))
            windiff = windiff + rollout(tempu,tempColor);
        end
        if currentColor == 1 
            rolloutValue(i) = 0.5*windiff/rollNum + 0.5; % probability of black wins
        else
            rolloutValue(i) = 0.5-0.5*windiff/rollNum; % probability of white wins
        end
    end
end
if emptyNum < switchNum
%     [flipNum,bestpt1] = max(value);
    [flipNum,bestpt] = max(rolloutValue+0.001*value);
%     if bestpt1~=bestpt
%         plotgame(u);
%         showvalue(validPosition,value,currentColor);
%         plotgame(u);
%         showvalue(validPosition,rolloutValue,currentColor);
%     end
else
    [flipNum,bestpt] = max(value);
end
if flipNum     
   [u,currentColor] = putstone(u,validPosition(bestpt),currentColor); 
   pass = 0;
else
% it is possible all empty space are not valid, then pass
   pass = pass + 1;
   currentColor = - currentColor;
end