blackwin = 0;
whitewin = 0;
for k = 1:20
    ReversiAI2AI;
    switch sign(win)
        case 1
            blackwin = blackwin + 1;
        case -1
            whitewin = whitewin + 1;
    end
    pause(1);
    close all    
end