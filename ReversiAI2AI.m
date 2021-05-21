%% ReversiAI2AI
%
% This is a script to play Reversi (Heibai Qi) by AIs. For the rules on this game,
% please check https://en.wikipedia.org/wiki/Reversi
%
% Click outside of the board. Double pass ends the game.
%
% State values   0: empty;   1: black;   -1: white
% 
% Long Chen 2019.

%% Initialize the game and draw the center stones
% plotboard; 
u = zeros(8,8,'int8');
u(4,4) = 1;
u(5,5) = 1;
u(4,5) = -1;
u(5,4) = -1;
plotgame(u);
% gif('reversitree.gif') 

%% Play the game
currentColor = 1; % start from black 
h = 1/8;
pass = 0; 
k = 1;
while pass < 2 % exit with pass = 1
    % put the stone and reverse stones captured
%     [u,currentColor,pass] = AIrand(u,currentColor,pass); 
%     [u,currentColor,pass] = AIpositionvalue(u,currentColor,pass);            
%     [u,currentColor,pass] = AItreetop3(u,currentColor,pass,5,3+floor(k/5));            
%      k = k + 1;
    pause(0.01)
    [u,currentColor,pass] = AItree(u,currentColor,pass,3);  
%     [u,currentColor,pass] = AIMCTS(u,currentColor,pass,3000+k*10,40,1);
%     [u,currentColor,pass] = AItreetop3(u,currentColor,pass,3,6);            
%     [u,currentColor,pass] = AItree2level(u,currentColor,pass);   
    pause(0.01)
%     gif;
%     [u,currentColor,pass] = AIrand(u,currentColor,pass);    
%     [u,currentColor,pass] = AItree2level(u,currentColor,pass);   
%     [u,currentColor,pass] = AItreetop3(u,currentColor,pass,3,6);            
%     [u,currentColor,pass] = AItree(u,currentColor,pass,3);  
    [u,currentColor,pass] = AIMCTStop3(u,currentColor,pass,3000+k*10,20,10);
%     [u,currentColor,pass] = AIMCTS(u,currentColor,pass,3000+k*10,40);
    k = k + 1;
%     pause;
%     gif;
end

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