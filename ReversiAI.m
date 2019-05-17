%% ReversiAI
%
% This is a script to play Reversi (Heibai Qi) against AIs. For the rules on
% this game, please check https://en.wikipedia.org/wiki/Reversi
%
% Click outside of the board. Double pass ends the game.
%
% State values   0: empty;   1: black;   -1: white
%
% Long Chen 2019. 
% - May 13.  AI random
% - May 14.  AI position value
% - May 15.  AI tree search (two steps)
% - May 15.  AI tree search (depth > 2)
% - May 16.  AI tree search with top N pruning


%% Initialize the game and draw the center stones
% plotboard; 
u = zeros(8,8);
u(4,4) = 1;
u(5,5) = 1;
u(4,5) = -1;
u(5,4) = -1;
plotgame(u);
%% Play the game
currentColor = 1; % start from black 
h = 1/8;
pass = 0; 
searchN = zeros(64,1);
global searchNum
searchNum = 0;
k = 1;
while pass < 2 % exit with two consective pass 
    [x,y] = myginput(1,'circle');    
    j = round(x/h-0.5)+1;
    i = round(y/h-0.5)+1;
    if (i<1) || (i>8)|| (j<1) || (j>8) % click out of the board is pass
        pass = pass + 1;
        currentColor = - currentColor;
        continue;
    end
    p = sub2ind([8,8],i,j);
    if u(i,j) == 0 || pass == 1 % no stone or pass
        % put the stone and reverse stones captured
        [u,currentColor,flipNum] = putstone(u,p,currentColor);
        if flipNum || pass == 1
            pass = 0;
            pause(0.5);
%             [u,currentColor,pass] = AIrand(u,currentColor,pass); 
%             [u,currentColor,pass] = AIpositionvalue(u,currentColor,pass);            
%             [u,currentColor,pass] = AItree2level(u,currentColor,pass);    
%             [u,currentColor,pass] = AItree(u,currentColor,pass,3);            
            [u,currentColor,pass] = AItreetop3(u,currentColor,pass,3,4+floor(k/5));            
            searchN(k) = searchNum;
            searchNum = 0;
            k = k + 1;
        end
    end
end
searchN = searchN(1:k-1,1);
figure; plot(searchN,'-*');
%% Count 
switch sign(sum(u(:)))
    case 1
        msgbox('Black Wins!')
    case -1
        msgbox('White Wins')
    case 0
        msgbox('Tie')
end
