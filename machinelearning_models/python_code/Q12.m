%random data

N = 201;
xdata = linspace(-1,1,N)';
err = normrnd(0,0.3,[N,1]);
W = [-1.3; 4];

xs = [xdata, ones(N,1)];
ys = xs*W + err;



% prior values
mu = [0 0];
sigma = [1 0;0 1];

xgrid = linspace(-5,5,251);
ygrid = xgrid;
[Xgrid, Ygrid] = meshgrid(xgrid,ygrid);

Z = mvnpdf([Xgrid(:), Ygrid(:)], mu, sigma);
Z = reshape(Z, size(Xgrid));

% plot a bunch of random possible lines from prior
numlines = 50;
W2 = mvnrnd(mu, sigma, numlines)';
y2 = xs*W2;


% rand point to test likelihood
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Important Number to change acc %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num = 200;                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
randindex = randi(N,[num,1]);
randcoord = [xs(randindex,:), ys(randindex)];

%likelihood
precision = 1/0.3;
xx = randcoord(:,1:2);
yy = randcoord(:,3);

%posterior values
Sugma =inv(precision*(xx'*xx) + inv(sigma));
Mu = (precision*Sugma*(xx'*yy))';


%plot posterior like prior before
Zpost = mvnpdf([Xgrid(:), Ygrid(:)], Mu, Sugma);
Zpost = reshape(Zpost, size(Xgrid));

W3 = mvnrnd(Mu, Sugma, numlines)';
y3 = xs*W3;



suba = 2;
subb = 3;

figure
subplot(suba,subb,1)
plot(xdata,ys,'bx');
title("Original Data")
xlabel("X")
ylabel("Y")


subplot(suba,subb,2)
contour(Xgrid,Ygrid,Z,5,'r')
title("Prior with no data")
xlabel("w_0")
ylabel("w_1")


subplot(suba,subb,3)
plot(xdata,y2);
title("Possible lines from no data points")

subplot(suba,subb,4)
contour(Xgrid,Ygrid,Zpost,5,'b')
hold on
plot([-1.3,-1.3],[-5,5],'r',[-5,5],[4,4],'r')
title(["Posterior with ",num," data points"])
xlabel("w_0")
ylabel("w_1")

subplot(suba,subb,[5 6])
plot(xdata,y3,xdata(randindex),ys(randindex),'b.','MarkerSize',20);
title(["Possible lines from ",num," data points"])