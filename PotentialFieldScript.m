%
% PotentialFieldScript.m
%

%% Generate some points

nrows = 500;
ncols = 600;

obstacle = false(nrows, ncols);

[x, y] = meshgrid (1:ncols, 1:nrows);

%% Generate some obstacle

obstacle (300:end, 100:250) = true;
obstacle (150:200, 400:500) = true;
% 
 t = ((x - 250).^2 + (y - 200).^2) < 50^2;
 obstacle(t) = true;
% 
 t = ((x - 100).^2 + (y - 150).^2) < 25^2;
 obstacle(t) = true;

% obstacle (1:100, 350) = true;
% obstacle (200, 350:600) = true;
% obstacle (1:150, 250) = true;
% obstacle (250,100:250) = true;
% obstacle (350,1:100) = true;

% obstacle (1:150, 100) = true;
% obstacle (250:500, 100) = true;
% obstacle (350, 50) = true;
% obstacle (350:500, 250) = true;
% 
% obstacle (1:500, 1) = true;
% obstacle (1,1:end) = true;
% obstacle (1:end,600) = true;
% obstacle (500,1:end) = true;

% obstacle (350:400, 250) = true;
% obstacle (350:400, 350) = true;
% obstacle (350, 250:350) = true;
% obstacle (400, 250:350) = true;

% obstacle (350:400, 250) = true;
% obstacle (350:400, 350) = true;
% obstacle (250, 150:450) = true;
% obstacle (150, 150:450) = true;
% 
% obstacle (150:250, 150) = true;
% obstacle (150:250, 450) = true;
% obstacle (350, 250:350) = true;
% obstacle (400, 250:350) = true;

%% Compute distance transform

d = bwdist(obstacle);

% Rescale and transform distances

d2 = (d/100) + 1;

d0 = 2;
nu = 800;

repulsive = nu*((1./d2 - 1/d0).^2);

repulsive (d2 > d0) = 0;

size(repulsive)
%% Display repulsive potential

figure;
m = mesh (repulsive);
m.FaceLighting = 'phong';
axis equal;

title ('Repulsive Potential');

%% Compute attractive force

goal = [400, 50];

xi = 1/700;

attractive = xi * ( (x - goal(1)).^2 + (y - goal(2)).^2 );
figure;
m = mesh (attractive);
m.FaceLighting = 'phong';
axis equal;

title ('Attractive Potential');

%% Display 2D configuration space

figure;
imshow(~obstacle);

hold on;
plot (goal(1), goal(2), 'r.', 'MarkerSize', 25);
hold off;

axis ([0 ncols 0 nrows]);
axis xy;
axis on;

xlabel ('x');
ylabel ('y');

title ('Configuration Space');

%% Combine terms

f = attractive + repulsive;

figure;
m = mesh (f);
m.FaceLighting = 'phong';
axis equal;

title ('Total Potential');

%% Plan route
start = [50, 350];

route = GradientBasedPlanner (f, start, goal, 1000);

%% Plot the energy surface

figure;
m = mesh (f);
axis equal;

%% Plot ball sliding down hill

[sx, sy, sz] = sphere(20);

scale = 20;
sx = scale*sx;
sy = scale*sy;
sz = scale*(sz+1);

hold on;
p = mesh(sx, sy, sz);
p.FaceColor = 'red';
p.EdgeColor = 'none';
p.FaceLighting = 'phong';
hold off;

for i = 1:size(route,1)
    P = round(route(i,:));
    z = f(P(2), P(1));
    
    p.XData = sx + P(1);
    p.YData = sy + P(2);
    p.ZData = sz + f(P(2), P(1));
    
    drawnow;
    
    drawnow;
    
end

%% quiver plot
[gx, gy] = gradient (-f);
skip = 20;

figure;

xidx = 1:skip:ncols;
yidx = 1:skip:nrows;

quiver (x(yidx,xidx), y(yidx,xidx), gx(yidx,xidx), gy(yidx,xidx), 0.4);

axis ([1 ncols 1 nrows]);

hold on;

ps = plot(start(1), start(2), 'r.', 'MarkerSize', 30);
pg = plot(goal(1), goal(2), 'g.', 'MarkerSize', 30);
p3 = plot (route(:,1), route(:,2), 'r', 'LineWidth', 2);
