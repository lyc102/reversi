function [u,currentColor,pass] = AIrand(u,currentColor,pass)
%% AIRAND randomly put a stone
%
% This is the simplest move strategy: randomly chose a valid location.
%
% Long Chen 2019. May. 12.

%% Find all empty space
p = find(u(:) == 0); % find empty space
if isempty(p) % no empty space
    pass = 2;
    return
end
%% Permute location and randomly put astone
p = p(randperm(length(p)));
pass = pass + 1;
for i = 1:length(p)
    [~,~,flipNum] = putstone(u,p(i),currentColor,0); 
    if flipNum
        [u,currentColor,flipNum] = putstone(u,p(i),currentColor); 
        pass = 0;
        return
    end
end
%% Pass
% No valid move, pass = 1 and reverse the color
currentColor = - currentColor;