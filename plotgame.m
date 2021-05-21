function fig = plotgame(u,varargin)
%% PLOTGAME plot stones for a game
%
% The stone state is given by the 8 x 8 matrix u.
%
% State values   0: no stone;   1: black;   -1: white
%
% Long Chen 2019. May. 12.

plotboard;
h = 1/8;
[x,y] = meshgrid(0.5*h:h:1-0.5*h,0.5*h:h:1-0.5*h);
isBlack = (u(:) == 1);
plot(x(isBlack),y(isBlack),'ko','LineWidth',1,'MarkerEdgeColor','k',...
            'MarkerFaceColor','k','MarkerSize',36)
isWhite = (u(:) == -1);
fig = plot(x(isWhite),y(isWhite),'ko','MarkerFaceColor','w','MarkerSize',36);
if nargin>2
    set(fig,varargin{1:end});
end
ax = gca;
disableDefaultInteractivity(ax);