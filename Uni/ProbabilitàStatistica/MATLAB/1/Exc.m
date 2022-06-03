% 1)
v1_1 = 1:10;
v1_2 = linspace(1,10,10);

v2_1 = 2:5:12;
v2_2 = linspace(2,12,3);

% 2)
mymat = zeros(4,2);
vector = [3 6];
mymat(2,:) = vector;

% 3)
% x = linspace(-pi,pi,20);
% y = sin(x);

% 4)
mat = randi([-5 5],4,6);
mat_1 = abs(mat);

% 5)
x = -2:0.1:2;
y = exp(x);
plot(x, y, '*');
xlabel('exp(x)');
ylabel('-2:2');
title('Appropriate Title');

% 6)
x = 1:5:100;
y = sqrt(x);
figure(1);
plot(x,y,'*');
title('sqrt(x)');
figure(2);
bar(x,y);
title('sqrt(x)');