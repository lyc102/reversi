function [u,currentColor,pass] = AIrand(u,currentColor)
%% AIRAND randomly put a stone
%
% This is the simplest move strategy: randomly chose a valid location.
%
% Long Chen 2019. May. 12.

p = find(u(:) == 0);
if isempty(p) % no empty space
    pass = 2;
    return
end
p = p(randperm(length(p)));
pass = 1;
for i = 1:length(p)
    [~,~,flipNum] = putstone(u,p(i),currentColor,0); 
    if flipNum
        [u,currentColor,flipNum] = putstone(u,p(i),currentColor); 
        pass = 0;
        break
    end
end