%% Generate data


%% Initialize the game and draw the center stones
u = zeros(8,8,'int8');
u(4,4) = 1;
u(5,5) = 1;
u(4,5) = -1;
u(5,4) = -1;
move = zeros(64,1,'int8');
move([1,3]) = sub2ind([8,8],[4 5],[4 5]);
move([2,4]) = -sub2ind([8,8],[4 5],[5 4]);

%% Play the game
flag = 0;
currentColor = 1; % start from black 
h = 1/8;
pass = 0; 
lastIdx = 5;
tic;
while pass < 2 && lastIdx <= 64 % exit with pass = 2
    % put the stone and reverse stones captured
%     [u,currentColor,pass] = AIrand(u,currentColor,pass,flag); 
%     [u,currentColor,pass] = AIpositionvalue(u,currentColor,pass,flag);            
    [u,currentColor,pass,bestpt] = AItree2level(u,currentColor,pass,flag);   
%     [u,currentColor,pass,bestpt] = AItreetop3(u,currentColor,pass,3,6,flag);    
    move(lastIdx) = sign(-currentColor)*bestpt;
    lastIdx = lastIdx + 1;
%     [u,currentColor,pass] = AItree(u,currentColor,pass,3,flag);  
%     [u,currentColor,pass] = AIMCTS(u,currentColor,pass,3000,40,flag);
%     [u,currentColor,pass] = AIMCTStop3(u,currentColor,pass,3000,40,10,flag);
end
toc;