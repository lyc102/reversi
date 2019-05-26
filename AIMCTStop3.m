function  [u,currentColor,pass] = AIMCTStop3(u,currentColor,pass,N,switchNum,topN)
%% AIMCTS Monte Carlo Tree Search
%
%  [u,currentColor,pass] = AIMCTS(u,currentColor,pass,N,switchNum)
%  implements Monte Carlo Tree Search (MCTS) algorithm. 
%
% - N is the upper bound for the rollout number and nodes. 
% - swtichNum is used to swtich from AItree and AIMCTS since rollout in the early stage is too costly. 
% - pweigth is the weight used in the initialization of winning rate.
%  winning rate = pweight*positionvalue/sum(sum(positionvalue))
%  Larger pweight will emphasize more on the position value. 
%  
% [u,currentColor,pass] = AIMCTS(u,currentColor,pass,3000+k*10,40,1.2);
%
% Long Chen 2019. May. 24.

%%
if ~exist('pweight','var')
    pweight = 1;     
end
p = find(u(:) == 0);
emptyNum = length(p);
if isempty(emptyNum)
    pass = pass + 1;
    return;
end
%% Use AItree for the first siwtchNum steps
if emptyNum > switchNum
   [u,currentColor,pass] = AItreetop3(u,currentColor,pass,3,6);  
%    [u,currentColor,pass] = AItree(u,currentColor,pass,3); 
   return
end
%% initilization
N = min([N, 100+ceil(factorial(emptyNum))]);
node2child = zeros(N,2,'uint32');
node2dad = zeros(N,1,'uint32');
nodeVisitNum = ones(N,1);
nodeBlackWinNum = zeros(N,1);
nodePosition = zeros(N,1,'uint8');
%% Add the first level of nodes
[validPosition,value,nextPass] = positionvalue(u,currentColor,0);
if nextPass == 1
    pass = pass + nextPass;
    currentColor = -currentColor;
    return;
end
if length(nodePosition) == 1 && nextPass == 0 % only one valide move
    [u,currentColor] = putstone(u,nodePosition(1),currentColor); 
    pass = 0;
    return
end
%% Pruning
% top3 pruning
[value,idx] = sort(value,1,'descend');
reducedTopN = min([length(idx) topN]);
value = value(1:reducedTopN);
validPosition = validPosition(idx(1:reducedTopN));
%% Initilization
firstLevelIdx = 2:(length(value)+1);
nodePosition(firstLevelIdx) = validPosition;
node2child(1,1) = 2;
node2child(1,2) = length(value)+1;
node2dad(firstLevelIdx) = 1;
nodeBlackWinNum(firstLevelIdx) = pweight*value/sum(value);
if currentColor == -1
    nodeBlackWinNum(firstLevelIdx) = 1 - nodeBlackWinNum(firstLevelIdx);
end
lastIdx = firstLevelIdx(end);
%% MCTS
rolloutNum = 1;
selectIdx = 1; % start from the root
score = zeros(20,1);
while rolloutNum <= N && lastIdx <= N && max(nodeVisitNum(firstLevelIdx)) < N/3
    if selectIdx == 1 % root
        % compute scores
        if currentColor == 1 % black
            score(firstLevelIdx) = nodeBlackWinNum(firstLevelIdx)./nodeVisitNum(firstLevelIdx);  
        else % white -- chose min value
            score(firstLevelIdx) = 1-nodeBlackWinNum(firstLevelIdx)./nodeVisitNum(firstLevelIdx);  
        end
        score(firstLevelIdx) = score(firstLevelIdx) + ...
                           2*sqrt(log(nodeVisitNum(node2dad(2)))./nodeVisitNum(firstLevelIdx));
        [~,selectIdx] = max(score(firstLevelIdx)); % chose one from the first level 
        selectIdx = firstLevelIdx(selectIdx);
        [unow,unowColor] = putstone(u,nodePosition(selectIdx),currentColor,0);  
%         plotgame(unow);
    end
    if nodeVisitNum(selectIdx) == 1 || node2child(selectIdx,1) == 0 
        % not visit before or leaf
        win = rollout(unow,unowColor); % one simulation
        rolloutNum = rolloutNum + 1;
        % update visit number and number of black wins
        nodeVisitNum(selectIdx) = nodeVisitNum(selectIdx) + 1;
        if win == 1 
            nodeBlackWinNum(selectIdx) = nodeBlackWinNum(selectIdx) + win;
        end
        % add all children nodes       
        [validPosition,value,nextPass] = positionvalue(unow,unowColor,0);
        if (nextPass==1) && ~isempty(validPosition) && nodePosition(selectIdx)>0
        % - nextPass && isempty(validPosition) is no empty space
        % - nextPass && nodePosition(selectIdx) == 0: the current is already pass
        % without adding more child nodes sets selectIdx as a leaf
            nodePosition(lastIdx+1) = 0;
            node2dad(lastIdx+1) = selectIdx;
            node2child(selectIdx,1) = lastIdx+1;
            node2child(selectIdx,2) = lastIdx+1;
            lastIdx = lastIdx + 1;
            % above: add a node for one pass
        elseif any(validPosition)
            % below: add all valid moves as child nodes
            childNum = length(value);
            nodePosition(lastIdx+1:lastIdx+childNum) = validPosition;
            node2dad(lastIdx+1:lastIdx+childNum) = selectIdx;
            node2child(selectIdx,1) = lastIdx+1;
            node2child(selectIdx,2) = lastIdx+childNum;
            nodeBlackWinNum(lastIdx+1:lastIdx+childNum) = pweight*value/sum(value);
            if unowColor == - 1
                nodeBlackWinNum(lastIdx+1:lastIdx+childNum) = 1-nodeBlackWinNum(lastIdx+1:lastIdx+childNum);
            end
            lastIdx = lastIdx + childNum;
        end
        % update visit and win numbers of parent nodes up to the root
        while selectIdx > 1
            % move up
            selectIdx = node2dad(selectIdx);
            unowColor = -unowColor;
            % update dad node
            nodeVisitNum(selectIdx) = nodeVisitNum(selectIdx) + 1;
            if win == 1 
                nodeBlackWinNum(selectIdx) = nodeBlackWinNum(selectIdx) + win;
            end
        end
    else % visited before, 
        if node2child(selectIdx,1) ~= 0 % not leaf, then chose one from its children
            child = node2child(selectIdx,1):node2child(selectIdx,2);
            childNum = length(child);
            % compute scores
            if unowColor == 1 % black
                score(1:childNum) = nodeBlackWinNum(child)./nodeVisitNum(child);  
            else % white -- chose min value
                score(1:childNum) = 1-nodeBlackWinNum(child)./nodeVisitNum(child);  
            end                           
            score(1:childNum) = score(1:childNum) + ...
                               2*sqrt(log(nodeVisitNum(selectIdx))./nodeVisitNum(child));
            [~,selectIdx] = max(score(1:childNum));
            selectIdx = child(selectIdx);
            if nodePosition(selectIdx)~=0 % 0 is pass
                [unow,unowColor] = putstone(unow,nodePosition(selectIdx),unowColor,0); 
            else % pass
                unowColor = -unowColor;
            end
        end
    end
end
%% Chose the first level node with max visit
[~,bestpt] = max(nodeVisitNum(firstLevelIdx));
bestpt = firstLevelIdx(bestpt);
[u,currentColor] = putstone(u,nodePosition(bestpt),currentColor); 
pass = 0;