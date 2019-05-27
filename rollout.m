function win = rollout(u,currentColor)

%% Auto play the game
pass = 0; 
[u,currentColor,pass] = AIpositionvalue(u,currentColor,pass,0);
[u,currentColor,pass] = AIpositionvalue(u,currentColor,pass,0);
while pass < 2 % exit with pass = 1    
    [u,currentColor,pass] = AIrand(u,currentColor,pass,0);   
%     [u,currentColor,pass] = AIpositionvalue(u,currentColor,pass,0);   
end
% plotgame(u);
win = sign(sum(u(:)));