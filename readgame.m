% plotboard;
u = zeros(8,8,'int8');
u(4,4) = 1;
u(5,5) = 1;
u(4,5) = -1;
u(5,4) = -1;
plotgame(u);
for k = 5:64
    currentColor = sign(move(k));
    pause(0.1);
   [u,currentColor] = putstone(u,abs(move(k)),currentColor);  
end