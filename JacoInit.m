syms C1 C2 C3 C4 C5 C6 S1 S2 S3 S4 S5 S6 d1 a2 d3 d4 d5 d6 q1 q2 q3 q4 q5 q6 dx dy dz wx wy wz J
Sal = 0.8192;
Cal = 0.5736;
digits(5);

%Simbolicke matrice transformacije
T01=[C1 0 S1 0; S1 0 -C1 0; 0 1 0 d1; 0 0 0 1];
T12=[C2 S2 0 a2*C2; S2 -C2 0 a2*S2; 0 0 -1 0; 0 0 0 1];
T23=[C3 0 S3 0; S3 0 -C3 0; 0 1 0 d3; 0 0 0 1];
T34  =[C4 -Cal*S4 Sal*S4 0; S4 Cal*C4 -Sal*C4 0; 0 Sal Cal d4; 0 0 0 1];
T45  =[C5 -Cal*S5 Sal*S5 0; S5 Cal*C5 -Sal*C5 0; 0 Sal Cal d5; 0 0 0 1];
T56  =[C6 S6 0 0; S6 -C6 0 0; 0 0 -1 d6; 0 0 0 1];

%Simbolicke matrice transformacije kao funkcije zakreta zglobova
T01 = subs(T01,[C1 S1],[cos(q1) sin(q1)]);
T12 = subs(T12,[C2 S2],[cos(q2) sin(q2)]);
T23 = subs(T23,[C3 S3],[cos(q3) sin(q3)]);
T34  = subs(T34,[C4 S4],[cos(q4) sin(q4)]);
T45  = subs(T45,[C5 S5],[cos(q5) sin(q5)]);
T56  = subs(T56,[C6 S6],[cos(q6) sin(q6)]);

%Matrice transformacije koristene u sintezi matrice Jakobijana
T02 = T01*T12;
T03 = T02*T23;
T04 = T03*T34;
T05 = T04*T45;
T06 = T05*T56;

%Sinteza matrice Jakobijana
R01 = T01(1:3,1:3);
R02 = T02(1:3,1:3);
R03 = T03(1:3,1:3);
R04 = T04(1:3,1:3);
R05 = T05(1:3,1:3);
R06 = T06(1:3,1:3);

O01 = T01(1:3,4);
O02 = T02(1:3,4);
O03 = T03(1:3,4);
O04 = T04(1:3,4);
O05 = T05(1:3,4);
O06 = T06(1:3,4);

z0 = [0; 0; 1];
z1 = R01*[0; 0; 1];
z2 = R02*[0; 0; 1];
z3 = R03*[0; 0; 1];
z4 = R04*[0; 0; 1];
z5 = R05*[0; 0; 1];

%Rotacijski dio matrice Jakobijana
Jw = [z0 z1 z2 z3 z4 z5];

Jv1=cross(z0, O06);
Jv2=cross(z1, O06 - O01);
Jv3=cross(z2, O06 - O02);
Jv4=cross(z3, O06 - O03);
Jv5=cross(z4, O06 - O04);
Jv6=cross(z5, O06 - O05);

%Translacijski dio matrice Jakobijana
Jv = [ Jv1 Jv2 Jv3 Jv4 Jv5 Jv6];

%Matrica Jakobijana kao funkcija zakreta zglobova
J = vpa(subs([Jv;Jw], [ d1 a2 d3 d4 d5 d6],[0.2755 0.41 -0.0098 -0.249182 -0.08376448 -0.21058224]));
