function Y = cost_function(x,b1,b2,omega,G_data,Kp,Ki)
a1=x(1);
a2=x(2);
a3=x(3);
G = minreal(tf([b2, 0, b1, 0],[1, a3, (a2 + Kp*b2), (a1 + Ki*b2), Kp*b1, Ki*b1]));
[gain_est,phase_est] = bode(G,omega);
gain_est = squeeze(gain_est)';
phase_est = squeeze(phase_est)'/180*pi;% radに変換
G_est=gain_est.*exp(1i*phase_est);
Y1 = norm(log( abs(G_data - G_est) + 1 ) );% 近さ
pole_max = max(real(pole(G)));% 極の実部の最大値が負でなければならない
Kp = 10; Ki=10; % 別のゲインでも極の実部の最大値が負でなければならない
G = tf([b2, 0, b1, 0],[1, a3, (a2 + Kp*b2), (a1 + Ki*b2), Kp*b1, Ki*b1]);
pole_max2 = max(real(pole(G)));
if (pole_max >= 0) || (pole_max2 >= 0)
Y = Y1 + 10^10;
else
Y = Y1;
end
endfunction


% データの読み込み（ここでは data_struct_test.mat）

gain=[0.58667499980824145,0.58166999578798972,0.57508999295762397,0.56692491248841759,0.55854997708351939,0.54659499814762302,0.53217949932330155,0.51534427405376293,0.49586998023675527,0.47456492601118344,0.45115996797145019,0.4238594545365244,0.39558472670213141,0.36412472808091467,0.33381499696688288,0.30373999983538552,0.27333991146555969,0.24517999979606819,0.21699499855987464,0.1911097799695243,0.1663698797859757,0.14356493652699465,0.12158499989719125,0.10106497909760831,0.081179986394431039,0.061225483828223008,0.040222990254330925,0.017020388890974267,0.0082919441495948338,0.027887983864022872,0.037237999516622808,0.037372479125688203,0.033598980713706164,0.028403488553344989,0.023312988654396079,0.018847963683114425,0.015107499329803062,0.012093999999999994,0.0095820491441027458,0.0075654999993390974,0.0059491469237194011,0.0046138998688744891,0.0031200994807858281,0.0028451402461038716,0.0022983499994561314,0.0017798998623518112,0.0014086499991126254,0.0010923499897011043,0.00084006975621075692,0.0006336292575315637,0.00046709493574647112,0.00034515498402891415,0.00026947429821784518,0.00019957981736638648,0.00014176911828744668,9.3931750925871661e-05,5.426518974443926e-05,5.1738362894471246e-05,3.2151718880955595e-05,2.1460850635517697e-05
]; % ゲインデータの読み込み
phase=[-0.280615,-0.31810499999999997,-0.35860999999999998,-0.404225,-0.45423999999999998,-0.50854500000000002,-0.56940499999999994,-0.63543499999999997,-0.70597500000000002,-0.77976000000000001,-0.85894999999999999,-0.94073000000000007,-1.02525,-1.11175,-1.2012,-1.28755,-1.3792,-1.4703499999999998,-1.56325,-1.6612,-1.75935,-1.8681999999999999,-1.984,-2.1153,-2.2638499999999997,-2.4366500000000002,-2.6421000000000001,-2.8369999999999997,-0.69614500000000001,-0.85587000000000002,-1.2447499999999998,-1.5771000000000002,-1.8433999999999999,-2.0536500000000002,-2.22715,-2.3772500000000001,-2.5090000000000003,-2.6291500000000001,-2.7439499999999999,-2.8528500000000001,-2.9613499999999999,-3.0861499999999999,2.9701500000000003,-3.0068999999999999,3.0686499999999999,2.9280499999999998,2.8161499999999999,2.68445,2.5634999999999999,2.40015,2.2282000000000002,2.3519000000000001,2.0458999999999996,1.8811,1.6919,1.5062,1.3168500000000001,1.1026500000000001,0.66456500000000007,-0.952291
]; % 位相データの読み込み
omega=[0.62831999999999999,0.71314999999999995,0.80942999999999998,0.91871000000000003,1.0427,1.1835,1.3432999999999999,1.5246999999999999,1.7304999999999999,1.9641999999999999,2.2294,2.5303,2.8719999999999999,3.2597,3.6998000000000002,4.1993,4.7663000000000002,5.4097999999999997,6.1401999999999992,6.969199999999999,7.9100999999999981,8.9779999999999998,10.189999999999996,11.565999999999997,13.126999999999999,14.9,16.910999999999998,19.194999999999993,21.786000000000005,24.727,28.065999999999995,31.855,36.155999999999999,41.036999999999999,46.577999999999996,52.866,60.003999999999991,68.105000000000018,77.300000000000011,87.735999999999962,99.582000000000008,113.02999999999999,128.28999999999999,145.61000000000004,165.25999999999999,187.58000000000004,212.90000000000003,241.64999999999984,274.27000000000004,311.2999999999999,353.32999999999976,401.02999999999975,455.18000000000012,516.62999999999988,586.38000000000022,665.54999999999961,755.40999999999963,857.38999999999999,973.14999999999986,1104.4999999999991
]; % 角周波数データの読み込み

% 前処理と高周波領域で得たパラメータ
omega0= 21.786;
b2=51.424469;
Kp=1.65;
Ki = 0;
b1=b2*omega0^2;

% 周波数伝達関数
G_data = gain.*exp(1i*phase); % 実験で得られた周波数伝達関数


scatter(log10(omega),20*log10(gain))

subplot(2,1,2)
plot(real(G_data),imag(G_data), 'bo')




%% parameter estimation
k2=1;
theta0=zeros(3,1);
for k=1:50
if k==1
theta0(1) = 19763;
theta0(2) = 789.8274;
theta0(3) = 46.5562;

% theta0(1) = rand(1,1) * ((theta0(2) +Kp*b2 )* theta0(3) - Ki*b2);
[theta1,fval] = fminsearch(@(x) cost_function(x,b1,b2,omega,G_data,Kp,Ki),theta0);
fval0 = fval
theta = theta1;
else
theta0 = -abs(theta1) .* log10( rand(3,1)).^(-log10( rand(3,1)));
theta0 = abs(theta0);
% theta0(3) = (1+rand(1,1)) * Ki/Kp + theta0(3);
% theta0(1) = rand(1,1) * ((theta0(2) +Kp*b2 )* theta0(3) - Ki*b2);
[theta1,fval] = fminsearch(@(x) cost_function(x,b1,b2,omega,G_data,Kp,Ki),theta0);
if fval < fval0

fval0 = fval;
theta = theta1;

end
end
end

fval0
theta
a1 = theta(1);
a2 = theta(2);
a3 = theta(3);


G_est = tf([b2, 0, b1, 0],[1, a3, (a2+Kp*b2), (a1 + Ki*b2), Kp*b1, Ki*b1]);

%% plot
[gain_est,phase_est] = bode(G_est,omega);
gain_est = squeeze(gain_est)';
phase_est = squeeze(phase_est)';

figure
loglog(omega,gain, 'bo',omega,gain_est, 'r*')

figure
plot(real(G_data),imag(G_data), 'bo',real(gain_est.*exp(1i*phase_est/180*pi)), imag(gain_est.*exp
(1i*phase_est/180*pi)), 'r*')
legend('experiment' ,'estimate')
figure
semilogx(omega,log10(1+abs(G_data-gain_est.*exp(1i*phase_est/180*pi))), 'bo')
title('error')

figure
nyquist(G_est,omega)

Gcl = gain.*exp(1i*phase);
plot(real(Gcl),imag(Gcl),'b*');


% 記録
data_parameter = struct( 'b1',b1,'b2',b2,'a1',a1,'a2',a2,'a3',a3);
