% Demo to show graph-based slam

%% Create ground truth
x = [0];
y = [0];
t = [0];

xe = [0];
ye = [0];
te = [0];


ds = 0.3;
dt = 0.2;

lm1 = [0 0.3];
lm2 = [1.5 2];
lm3 = [-1 3];

pg = poseGraph();
pg

clc
for ct = 1:30
    
    t(end+1) = t(end) + dt;
    x(end+1) = x(end) + ds*cos(t(end));
    y(end+1) = y(end) + ds*sin(t(end));    
    
    dte = (1 + 0.3*randn)*dt;
    dxe = (1 + 0.3*randn)*ds*cos(t(end));
    dye = (1 + 0.3*randn)*ds*sin(t(end));
    
    te(end+1) = te(end) + dte;
    xe(end+1) = xe(end) + dxe;
    ye(end+1) = ye(end) + dye;
    
    
    pg.addRelativePose([dxe, dye, dte]);
    
    if norm([x(end) y(end)]-lm1) < .6
        disp([num2str(ct), ' I see landmark 1'])
        % compute relative pose
        pg.addRelativePose(lm1-[x(end) y(end)])
    end
    
    if norm([x(end) y(end)]-lm2) < .6
        disp([num2str(ct), ' I see landmark 2'])
        pg.addRelativePose(lm2-[x(end) y(end)])
    end
    
    if norm([x(end) y(end)]-lm3) < .6
        disp([num2str(ct), ' I see landmark 3'])
        pg.addRelativePose(lm3-[x(end) y(end)])
    end
        
end



plot(x,y, 'o', ...
     xe,ye, 'r*', ...
     lm1(1), lm1(2), 'r^', lm2(1), lm2(2), 'b^', lm3(1), lm3(2), 'k^');
axis equal
shg

axis([-3 3 -1 5])



