function flipIdx = findflipstone(ul,currentColor)
%% FINDFLIPSTONE find flip stones
% 
% ul is a vector representing stones in a line. flipIdx is the index where
% the stone can be fliped. 
%
% Long Chen 2019. May. 12.

flipIdx = [];
team = find(ul==currentColor,1); % find a stone with the same color
if ~isempty(team) && team > 1 % team = 1 is next to it, no flip stone in between
    gap = find(ul(1:team)==0,1);
    if isempty(gap)  % no empty space between two stones of the same color
        flipIdx = 1:(team-1);
    end
end