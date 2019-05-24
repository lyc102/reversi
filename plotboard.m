%% PLOTBOARD
%
% plot 8 x 8 board.
%
% Long Chen 2019. May. 12.


figure('rend','painters','pos',[18 18 666 666]); % larger board
%% Background
clf;
patch('Faces', [1,2,3,4], 'facecolor',[225 150 75]/255, ...
      'Vertices', [-0.075,-0.075; 1.075,-0.075; 1.075,1.075; -0.075,1.075]);
hold on
%% Generate vertices and elements  
h = 1/8;
[x,y] = meshgrid(0:h:1,0:h:1);
ni = size(x,1); 
nj = size(x,2);
N = length(x(:));
nodeidx = reshape(1:N,ni,nj);
t2nidxMap = nodeidx(1:ni-1,1:nj-1);
k = t2nidxMap(:);
elem = [k k+ni k+ni+1 k+1];
%% Draw the board
patch('Faces', elem, 'Vertices', [x(:),y(:)],'Facecolor',[250 180 100]/255,...
      'Linewidth',1.125);
view(2); axis equal; axis tight; axis off;
% hold off;