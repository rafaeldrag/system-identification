x = csvRead('teste3.csv')
omega = x(1,:)
gain = x(2,:)
angle = x(3,:)

x = log10(omega);
y =  20*log10(gain);

clf();
scatter(x, y, mcolors='scilab green2');

newX = unique(x)
newY = [];
importantAngle = [];
for (i = newX)
    a = angle(find(x==i));
    w = y(find(x==i));
    m = median(w);
    a = median(a);
    newY = [newY,m]
    importantAngle = [importantAngle, a];
end

importantX = 10^newX;
importantY = 10^(newY/20);

good = find(newX > 1.6)
newX = newX(good)
newY = newY(good)




scatter(newX, newY, "fill");

n = 20*mean(newY/20 + 2*newX)
m = -40
lineX = 0:0.01:3.6
lineY = m*lineX + n;



plot(lineX, lineY, 'k--');

x0 = x(find(x > 1.3))(1)
y0 = y(find(x > 1.3))(1)
scatter([x0,x0], [y0,y0],msizes = 72, mcolors='scilab red2', "fill", marker="filled diamond");

b1=10^(mean(newY/20 + 2*newX))
w0 = 10^x(find(x > 1.3))(1);
b2 = b1*w0^2
