function [u,currentColor,flipNum] = putstone(u,p,currentColor,flag)
%% PUTSTONE check if it is a valid move and put stone
%
% u is 8 x 8 and p = [i,j] is the sub. currentColor is 1 or -1. flag = 0
% is used to count the possible number of flip stones.
%
% Long Chen 2019. May. 12.

global searchNum
searchNum = searchNum + 1;
%% Double check if the location is empty
if abs(u(p)) > 0
    beep
    return
end
%% Set up    
h = 1/8;
[i,j] = ind2sub([8,8],p);
if ~exist('flag','var')  % flag = 0 is used to count the possible flip
    flag = 1;     
end
    
%% Check if some stones of the opponent are reversed
isflip = false(8,8);
% line to the right
flipIdx = findflipstone(u(i,j+1:end),currentColor);
isflip(i,j+flipIdx) = true;
% line to the left
flipIdx = findflipstone(u(i,j-1:-1:1),currentColor);
isflip(i,j-flipIdx) = true;
% line to the top
flipIdx = findflipstone(u(i+1:end,j),currentColor);
isflip(i+flipIdx,j) = true;
% line to the bottom
flipIdx = findflipstone(u(i-1:-1:1,j),currentColor);
isflip(i-flipIdx,j) = true;
% line to the north-east
lineIdx = 1:min([8-i,8-j]);
lineIdx = mysub2ind([8,8],i+lineIdx,j+lineIdx);
flipIdx = findflipstone(u(lineIdx),currentColor);
isflip(lineIdx(flipIdx)) = true;
% line to the south-west
lineIdx = 1:min([i-1,j-1]);
lineIdx = mysub2ind([8,8],i-lineIdx,j-lineIdx);
flipIdx = findflipstone(u(lineIdx),currentColor);
isflip(lineIdx(flipIdx)) = true;
% line to the south-east
lineIdx = 1:min([i-1,8-j]);
lineIdx = mysub2ind([8,8],i-lineIdx,j+lineIdx);
flipIdx = findflipstone(u(lineIdx),currentColor);
isflip(lineIdx(flipIdx)) = true;
% line to the north-west
lineIdx = 1:min([8-i,j-1]);
lineIdx = mysub2ind([8,8],i+lineIdx,j-lineIdx);
flipIdx = findflipstone(u(lineIdx),currentColor);
isflip(lineIdx(flipIdx)) = true;

%% draw the stone
flipNum = sum(isflip(:));
if any(isflip(:)) % the current position is allowed
    isflip(i,j) = true;   % draw the current one together
    u(isflip) = currentColor;
    if flag
        [i,j] = find(isflip);
        x = (j-0.5)*h;
        y = (i-0.5)*h;
        hold on;
        if currentColor == 1
            plot(x,y,'o','LineWidth',1,'MarkerEdgeColor','k',...
            'MarkerFaceColor','k','MarkerSize',36); 
        else
            plot(x,y,'o','LineWidth',1,'MarkerEdgeColor','k',...
            'MarkerFaceColor','w','MarkerSize',36);             
        end
    end
    % exchange the color
    currentColor = -currentColor;
end
