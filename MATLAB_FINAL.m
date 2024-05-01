
%%
%	Example 1.3-1 Paper Airplane Flight Path
%	Copyright 2005 by Robert Stengel
%	August 23, 2005

	global CL CD S m g rho	
	S		=	0.017;			% Reference Area, m^2
	AR		=	0.86;			% Wing Aspect Ratio
	e		=	0.9;			% Oswald Efficiency Factor;
	m		=	0.003;			% Mass, kg
	g		=	9.8;			% Gravitational acceleration, m/s^2
	rho		=	1.225;			% Air density at Sea Level, kg/m^3	
	CLa		=	3.141592 * AR/(1 + sqrt(1 + (AR / 2)^2));
							% Lift-Coefficient Slope, per rad
	CDo		=	0.02;			% Zero-Lift Drag Coefficient
	epsilon	=	1 / (3.141592 * e * AR);% Induced Drag Factor	
	CL		=	sqrt(CDo / epsilon);	% CL for Maximum Lift/Drag Ratio
	CD		=	CDo + epsilon * CL^2;	% Corresponding CD
	LDmax	=	CL / CD;			% Maximum Lift/Drag Ratio
	Gam		=	-atan(1 / LDmax);	% Corresponding Flight Path Angle, rad
	V		=	sqrt(2 * m * g /(rho * S * (CL * cos(Gam) - CD * sin(Gam))));
							% Corresponding Velocity, m/s
	Alpha	=	CL / CLa;			% Corresponding Angle of Attack, rad
	
    %% part 2
%	a) Equilibrium Glide at Maximum Lift/Drag Ratio
	H		=	2;			% Initial Height, m
	R		=	0;			% Initial Range, m
	to		=	0;			% Initial Time, sec
	tf		=	6;			% Final Time, sec
	tspan	=	[to tf];
	xo		=	[V;Gam;H;R];
	[ta,xa]	=	ode23('EqMotion',tspan,xo);
    
    figure 
    subplot(2,1,1)
    
    xo		=	[2;Gam;H;R];
	[ta,xa]	=	ode23('EqMotion',tspan,xo);
    xo		=	[7.5;Gam;H;R];
    [tb,xb] =	ode23('EqMotion',tspan,xo);
    xo		=	[V;Gam;H;R];
    [tc,xc] =	ode23('EqMotion',tspan,xo);
    plot(xa(:,4),xa(:,3),'red',xb(:,4),xb(:,3),'green',xc(:,4),xc(:,3),'black')
    title('change velocity')
    ylabel('height'); xlabel('range');

    subplot(2,1,2)
 
    xo		=	[V;-0.5;H;R];
	[ta,xa]	=	ode23('EqMotion',tspan,xo);
    xo		=	[V;0.4;H;R];
    [tb,xb] =	ode23('EqMotion',tspan,xo);
    xo		=	[V;-0.18;H;R];
    [tc,xc] =	ode23('EqMotion',tspan,xo);
    plot(xa(:,4),xa(:,3),'red',xb(:,4),xb(:,3),'green',xc(:,4),xc(:,3),'black')
       title('change flight path angle')
    ylabel('height'); xlabel('range');
  %% part 3

  Vmin = 2;
  Vmax = 7.5;
  GamMin = -.5;
  GamMax = .4;

  figure 
  for i = 1:100
      V = Vmin + (Vmax-Vmin)*rand(1);
      Gam = GamMin + (GamMax-GamMin)*rand(1);
    xo		=	[V;Gam;H;R];
	[ta,xa]	=	ode23('EqMotion',tspan,xo);
   
    plot(xa(:,4), xa(:,3), 'black')
    hold on

  end
xlabel('range'); ylabel('height'); title('Monte Carlo Simulation')

  %% part 4
xavg = 0;
for i = 1:100
    V = Vmin + (Vmax-Vmin)*rand(1);
    Gam = GamMin + (GamMax-GamMin)*rand(1);
    [ta,xa]	=	ode23('EqMotion',tspan,xo);   
    xavg = (xa+xavg);

end
xavg = xavg/i;

%make it take time as an input?
p = polyfit(ta, xavg(:,3),10);
y1 = polyval(p,ta);
q = polyfit(ta,xavg(:,4),10);
y2 = polyval(q,ta);


%% part 5

A = diff(y2)/ta;
B = diff(y1);



















