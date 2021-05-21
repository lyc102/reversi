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
% - May 18.  AI tree search and MC simulation in the last 20 steps
% - May 22.  AI MCTS

prompt = {'Enter a difficulty level'};
dlgtitle = 'Difficulty Level';
definput = {'3'};
dims = [1 40];
opts.Interpreter = 'tex';
answer = inputdlg(prompt,dlgtitle,dims,definput,opts);
hardlevel = str2double(cell2mat(answer));

%% Initialize the game and draw the center stones
u = zeros(8,8,'int8');
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
% tree = [];
while pass < 2 % exit with two consective pass 
    [x,y] = myginput(1,'circle');    
    j = round(x/h-0.5)+1;
    i = round(y/h-0.5)+1;
    if (i<1) || (i>8)|| (j<1) || (j>8) % click out of the board is pass
        pass = pass + 1;
        currentColor = - currentColor;
        flipNum = 1;
    else % inside the board
        flipNum = 0;
        p = sub2ind([8,8],i,j);
        if u(i,j) == 0 % no stone
            % put the stone and reverse stones captured
            [u,currentColor,flipNum] = putstone(u,p,currentColor);
            if flipNum
                pass = 0;
            end
        end        
    end
    if flipNum % flip (pass = 0) or pass (pass = 1)
        pause(0.5);
        switch hardlevel
            case 0
                [u,currentColor,pass] = AIrand(u,currentColor,pass); 
            case 1 
                [u,currentColor,pass] = AIpositionvalue(u,currentColor,pass);            
            case 2
                [u,currentColor,pass] = AItree2level(u,currentColor,pass);    
            case 3
                [u,currentColor,pass] = AItreetop3(u,currentColor,pass,3,6);   
            case 4
                [u,currentColor,pass] = AItree(u,currentColor,pass,3);   
            case 5
%         [u,currentColor,pass] = AIMCTS(u,currentColor,pass,3000+k*10,40,1);
                [u,currentColor,pass] = AIMCTStop3(u,currentColor,pass,3000+k*10,40,8);       
        end
        searchN(k) = searchNum;
        searchNum = 0;
        k = k + 1;    
    end
end
% searchN = searchN(1:k-1,1);
% figure; plot(searchN,'-*');

%% Count 
win = int8(sum(u(:)));
switch sign(win)
    case 1
        msgbox(['Black wins  ' int2str(win)]); 
        disp(compose('Black Wins %d',win));
    case -1
        msgbox(['White Wins  ' int2str(-win)]); 
        disp(compose('White Wins %d',-win));
    case 0
        msgbox('Tie'); disp('Tie');
end