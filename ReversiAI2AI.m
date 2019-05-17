%% ReversiAI
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
gif('reversitree.gif') 

%% Play the game
currentColor = 1; % start from black 
h = 1/8;
pass = 0; 
while pass < 2 % exit with pass = 1
    % put the stone and reverse stones captured
%     [u,currentColor,pass] = AIrand(u,currentColor,pass); 
    [u,currentColor,pass] = AItree(u,currentColor,pass,3);  
    pause(0.25)
    gif;
%     [u,currentColor,pass] = AIrand(u,currentColor,pass);    
    [u,currentColor,pass] = AItree(u,currentColor,pass,2);  
    pause(0.25)
    gif;
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
