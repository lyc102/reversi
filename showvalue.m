function showvalue(validPosition,value,color)
%% SHOWVALUE plot values on each empty points
%
%  showvalue(value,color) display values at empty points for a color. The
%  size of the dots is proportional to the square of the value and the
%  color of the dots is also adapted according to the value.
%
%
% Copyright (C) Long Chen. See COPYRIGHT.txt for details.

hold on;
if color == 1
    startColor = 0.125*[1 1 1];
    endColor = 0.25*[1 1 1];
end
if color == -1
    startColor = 0.925*[1 1 1];
    endColor = 0.75*[1 1 1];
end
h = 1/8;
[x,y] = meshgrid(0.5*h:h:1-0.5*h,0.5*h:h:1-0.5*h);
minValue = min(value);
if minValue < 0
    value = value - minValue +1; % shift the value to be positive
end
maxValue = max(value(:));
for i = 1:length(value)
    p = validPosition(i);
    t = value(i)/maxValue;
    c = t*startColor + (1-t)*endColor;
    plot(x(p),y(p),'o','LineWidth',2,'MarkerEdgeColor',1-endColor,...
             'MarkerSize', ceil(t^2*20+4),'MarkerFaceColor',c);
end    