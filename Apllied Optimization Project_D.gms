sets
t         /1*24/
**************************
**************************
**********SUMMER**********
parameters
P_load(t)/        1        250        ,
        2        260        ,
        3        270        ,
        4        290        ,
        5        295        ,
        6        300        ,
        7        350        ,
        8        360        ,
        9        370        ,
        10        390        ,
        11        420        ,
        12        450        ,
        13        480        ,
        14        520        ,
        15        540        ,
        16        520        ,
        17        500        ,
        18        490        ,
        19        480        ,
        20        440        ,
        21        410        ,
        22        360        ,
        23        300        ,
        24        260        /



H_load(t)/        1        20        ,
        2        20        ,
        3        20        ,
        4        20        ,
        5        20        ,
        6        20        ,
        7        30        ,
        8        40        ,
        9        50        ,
        10        50        ,
        11        50        ,
        12        50        ,
        13        50        ,
        14        40        ,
        15        40        ,
        16        40        ,
        17        40        ,
        18        35        ,
        19        35        ,
        20        30        ,
        21        30        ,
        22        20        ,
        23        20        ,
        24        20        /

C_load(t)/        1        75        ,
        2        80        ,
        3        80        ,
        4        90        ,
        5        100        ,
        6        110        ,
        7        120        ,
        8        140        ,
        9        160        ,
        10        190        ,
        11        220        ,
        12        240        ,
        13        275        ,
        14        250        ,
        15        220        ,
        16        210        ,
        17        165        ,
        18        155        ,
        19        145        ,
        20        135        ,
        21        120        ,
        22        100        ,
        23        85        ,
        24        75        /




Temp(t)/        1        23.466        ,
        2        23.215        ,
        3        23.333        ,
        4        23.447        ,
        5        23.461        ,
        6        23.241        ,
        7        23.985        ,
        8        27.598        ,
        9        30.074        ,
        10        31.853        ,
        11        33.4        ,
        12        34.682        ,
        13        35.669        ,
        14        36.296        ,
        15        36.509        ,
        16        36.295        ,
        17        35.603        ,
        18        34.374        ,
        19        31.752        ,
        20        27.831        ,
        21        26.582        ,
        22        24.511        ,
        23        22.93        ,
        24        22.025        /

CNG /0.25/
CE/0.12/
n_ch/0.914/
n_dch/0.914/
P_eeschmax /60/
P_eesdchmax /80/
E_eesmax /400/
H_chpmax  /280/
P_chpmax /400/
H_boilermax /400/
P_ehpmax /200/
C_chillermax /75/
COP_ehp     /2.5/
n_chiller  /.5/
n_boiler   /.8/
n_chp      /.7/
L_ref   /1000/
C_battery /152181/
Cd(t)
**************************
**************************
positive variable
NG(t)
NG_boiler(t)
NG_chp(t)
NG_chiller(t)
P_ehp(t)
P_eesch(t)
P_eesdch(t)
P_chp(t)
P(t)
E_ees(t)
C_ehp(t)
C_chiller(t)
H_boiler(t)
H_chp(t)
H_ehp(t)
E_pu(t)
L_Epu(t)
L_temp(t)
H_chploss(t)
Cd(t)
**************************
**************************
binary variable
I_ch(t)
I_dch(t)
I_H(t)
I_C(t)
**************************
**************************
variable
Z
PG(t)
**************************
**************************
equation
of
c1
c2
c3
c4
c5
c5a
c6
c7
c8
c9
c10
c11
c12
c13
c14
c15
c16
c17
c18
c19
c20
c21
c22
c23
c24
c25
c26
c27
;

of.. Z=e=sum(t,(CNG*NG(t)+CE*PG(t)+Cd(t)*E_ees(t)));
c1(t)..NG(t)=e=NG_boiler(t)+NG_chiller(t)+NG_chp(t);
c2(t)..PG(t)=e=P_load(t)+P_ehp(t)+P_eesch(t)-P_eesdch(t)-P_chp(t);
c3(t)..P_load(t)=e=P_eesdch(t)+P_chp(t)+P(t);
c4(t)..E_ees(t+1)=e=E_ees(t)+P_eesch(t)*n_ch-P_eesdch(t)/n_dch;
c5..E_ees('1')=e=E_ees('24');
c5a..E_ees('1')=e=4;
c6(t)..P_eesch(t)=l=P_eeschmax*I_ch(t);
c7(t)..P_eesdch(t)=l=P_eesdchmax*I_dch(t);
c8(t)..E_ees(t)=l=E_eesmax;
c9(t)..I_ch(t)+I_dch(t)=l=1;
c10(t)..P_chp(t)=l=P_chpmax;
c11(t)..H_chp(t)=l=H_chpmax ;
c12(t)..H_boiler(t)=l=H_boilermax;
c13(t)..H_ehp(t)=l=P_ehpmax*I_H(t);
c14(t)..C_ehp(t)=l=P_ehpmax*I_C(t);
c15(t)..I_C(t)+I_H(t)=l=1;
c16(t)..C_chiller(t)=l=C_chillermax;
c17(t)..H_chp(t)+H_chploss(t)=e=.75*P_chp(t);
c18(t)..n_chp*(12*NG_chp(t))=e=(H_chp(t)+H_chploss(t)+P_chp(t));
c19(t)..n_chiller*(12*NG_chiller(t))=e=C_chiller(t);
c20(t)..n_boiler*(12*NG_boiler(t))=e=H_boiler(t);
c21(t)..COP_ehp*P_ehp(t)=e=(C_ehp(t)+H_ehp(t));
c22(t)..C_load(t)=e=C_ehp(t)+C_chiller(t);
c23(t)..H_load(t)=e=H_chp(t)+H_boiler(t)+H_ehp(t);
c24(t)..E_pu(t)*E_eesmax=e=E_ees(t);
c25(t)..Cd(t)*(L_Epu(t)*L_temp(t)*E_ees(t)*0.8)=e=(C_battery*L_ref);
c26(t)..L_Epu(t)=e=0.0057*exp(14.44*E_pu(t))+963.1*exp(2.19*E_pu(t));
c27(t)..L_temp(t)=e=.001035*Temp(t)**3-.3864*Temp(t)**2+5.13*Temp(t)+1520;

Model opt /all/;
Solve opt us MINLP min Z;
execute_unload "WinterD.gdx" ;
