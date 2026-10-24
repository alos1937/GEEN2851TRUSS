perpTL = 0.5 * 0.756;
perpTR = 0.52 * 0.75;
perpBL = 0.52 * 0.765;
perpBR = 0.5 * 0.765;
paraTL = 0.54 * 0.745;
paraTR = 0.51 * 0.72;
paraBL = 0.53 * 0.770;
paraBR = 0.495 * 0.725;
perpA = perpTL + perpTR + perpBL + perpBR;
paraA = paraTL + paraTR + paraBL + paraBR;
paraTestData = readtable("Parallel glue shear test TheJointChiefs.csv");
perpTestData = readtable("Perpendicular glue shear test TheJointChiefs.csv");
perpShear = perpTestData.Load*0.224809/perpA*2;
%multiple of 2 comes from averaging shear stress at all 4 areas, the top
%portion feels load/2 per area and the bottom could fail first so it is
%also included with the correction factor.
perpPos = perpTestData.Crosshead*0.03937008;
paraShear = paraTestData.Load*0.224809/paraA*2;
paraPos = paraTestData.Crosshead*0.03937008;
[maxV1,idx11] = max(perpShear);
maxX11 = perpPos(idx11);
[maxV2,idx21] = max(paraShear);
maxX21 = paraPos(idx21);
max(perpTestData.Load)
max(paraTestData.Load)

bendData1 = readtable("TJC_4points_sample1.csv");
bendData2 = readtable("TJC_4points_sample2.csv");
bendLoad1 = bendData1.Load*0.224809;
bendLoad2 = bendData2.Load*0.224809;
bendPos1 = bendData1.Crosshead*0.03937008;
bendPos2 = bendData2.Crosshead*0.03937008;
h1 = 0.495;
h2 = 0.5;
b1 = 0.746;
b2 = 0.76;
I1 = b1*h1^3/12;
I2 = b2*h2^3/12;
c1 = h1/2;
c2 = h2/2;
M1 = bendLoad1*(3+7/8)/2;
M2 = bendLoad2*(3+7/8)/2;
s1 = M1*c1/I1;
s2 = M2*c2/I2;
[maxS1,idx1] = max(s1);
maxX1 = bendPos1(idx1);
[maxS2,idx2] = max(s2);
maxX2 = bendPos2(idx2);
[maxP1,idx1P] = max(bendLoad1);
maxXP1 = bendPos1(idx1P);
[maxP2,idx2P] = max(bendLoad2);
maxXP2 = bendPos2(idx2P);

figure(1)
    hold on;
    fontname("Cambria Math");
    fontsize(14,'points');
    ylim([0,1.1*max([paraShear;perpShear])]);
    xlim([0,1.1*max([paraPos;perpPos])]);
    xlabel("Crosshead Position (in)");
    ylabel("Shear Stress (psi)");
    title("Shear Stress vs Crosshead Position")
    grid on;
    plot(perpPos,perpShear,LineWidth=2);
    plot(paraPos,paraShear,LineWidth=2);
    legend("Perpendicular Test","Paralell Test","Location","northwest");
    text(maxX11,maxV1,sprintf(' Max: (%.2f, %.2f)',maxX11,maxV1),'VerticalAlignment','bottom');
    text(maxX21,maxV2,sprintf(' Max: (%.2f, %.2f)',maxX21,maxV2),'VerticalAlignment','bottom');
    hold off;
figure(2)
    hold on;
    fontname("Cambria Math");
    fontsize(14,'points');
    ylim([0,1.1*max([s1;s2])]);
    xlim([0,1.1*max([bendPos1;bendPos2])]);
    xlabel("Crosshead Position (in)");
    ylabel("Bending Stress (psi)");
    title("Bending Stress vs Crosshead Position")
    grid on;
    plot(bendPos1,s1,LineWidth=2);
    plot(bendPos2,s2,LineWidth=2);
    legend("Sample 1","Sample 2","Location","northwest");
    text(maxX1,maxS1,sprintf(' Max: (%.2f, %.2f)',maxX1,maxS1),'VerticalAlignment','bottom');
    text(maxX2,maxS2,sprintf(' Max: (%.2f, %.2f)',maxX2,maxS2),'VerticalAlignment','bottom');
    hold off;
figure(3)
    hold on;
    fontname("Cambria Math");
    fontsize(30,'points');
    ylim([0,1.1*max([bendLoad1;bendLoad2])]);
    xlim([0,1.1*max([bendPos1;bendPos2])]);
    xlabel("Deflection (in)");
    ylabel("Applied Loading (lb)");
    title("Applied Loading vs Deflection")
    grid on;
    plot(bendPos1,bendLoad1,LineWidth=2);
    plot(bendPos2,bendLoad2,LineWidth=2);
    legend("Sample 1","Sample 2","Location","northwest");
    %text(maxXP1,maxP1,sprintf(' Max: (%.2f, %.2f)',maxXP1,maxP1),'VerticalAlignment','bottom');
    %text(maxXP2,maxP2,sprintf(' Max: (%.2f, %.2f)',maxXP2,maxP2),'VerticalAlignment','bottom');
    hold off;
figure(4)
    hold on;
    fontname("Cambria Math");
    fontsize(30,'points');
    ylim([0,1.1*max([perpShear;paraShear])]);
    xlim([0,1.1*max([perpPos;paraPos])]);
    xlabel("Deflection (in)");
    ylabel("Shear Loading (lb)");
    title("Shear Loading vs Deflection")
    grid on;
    plot(perpPos,perpShear,LineWidth=2);
    plot(paraPos,paraShear,LineWidth=2);
    legend("Perpendicular Sample","Paralell Sample","Location","northwest");
    %text(maxXP1,maxP1,sprintf(' Max: (%.2f, %.2f)',maxXP1,maxP1),'VerticalAlignment','bottom');
    %text(maxXP2,maxP2,sprintf(' Max: (%.2f, %.2f)',maxXP2,maxP2),'VerticalAlignment','bottom');
    hold off;