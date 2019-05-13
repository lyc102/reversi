%% Reversi
%
% This is a script to play Reversi (Heibai Qi). For the rules on this game,
% please check https://en.wikipedia.org/wiki/Reversi
%
% Click outside of the board. Double pass ends the game.
%
% State values   0: empty;   1: black;   -1: white
%
% Long Chen 2019. May. 12.


%% Initialize the game and draw the center stones
plotboard; 
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
    if u(i,j) == 0 % no stone
        % put the stone and reverse stones captured
        [u,currentColor] = putstone(u,p,currentColor);
        pass = 0;
    end
end

%% Count 
switch sign(sum(u(:)))
    case 1
        msgbox('Black Wins!')
    case -1
        msgbox('White Wins')
    case 0
        msgbox('Tie')
end
