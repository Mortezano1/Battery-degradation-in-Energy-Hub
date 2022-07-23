sets
t         /1*24/
s         /1*20/
**************************
**************************
**********SUMMER**********
parameters
P_load(s,t)
H_load(s,t)
C_load(s,t)

Pr(s)/        1        0.036        ,
        2        0.072333333        ,
        3        0.055666667        ,
        4        0.041        ,
        5        0.027        ,
        6        0.070333333        ,
        7        0.036        ,
        8        0.072        ,
        9        0.048666667        ,
        10        0.055666667        ,
        11        0.037        ,
        12        0.061        ,
        13        0.075333333        ,
        14        0.052333333        ,
        15        0.029333333        ,
        16        0.051333333        ,
        17        0.075333333        ,
        18        0.029666667        ,
        19        0.033        ,
        20        0.041        /



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
Cd(t)/        1        31.73475833        ,
        2        31.73975901        ,
        3        1.598926648        ,
        4        0.613161041        ,
        5        0.306088058        ,
        6        0.170273678        ,
        7        0.098877376        ,
        8        0.098802256        ,
        9        0.054126847        ,
        10        0.053988726        ,
        11        0.083416753        ,
        12        0.096140916        ,
        13        0.052552775        ,
        14        0.05258453        ,
        15        0.052648455        ,
        16        0.020594254        ,
        17        0.02067717        ,
        18        0.020682382        ,
        19        0.020682382        ,
        20        0.040500222        ,
        21        0.110920258        ,
        22        0.271827057        ,
        23        0.85984981        ,
        24        31.77402507        /





$call gdxxrw P_load.xlsx par=P_load rng=sheet1!a1 Cdim=1 Rdim=1
$gdxin P_load.gdx
$load P_load
$gdxin

$call gdxxrw H_load.xlsx par=H_load rng=sheet1!a1 Cdim=1 Rdim=1
$gdxin H_load.gdx
$load H_load
$gdxin

$call gdxxrw C_load.xlsx par=C_load rng=sheet1!a1 Cdim=1 Rdim=1
$gdxin C_load.gdx
$load C_load
$gdxin
**************************
**************************
positive variable
NG(s,t)
NG_boiler(s,t)
NG_chp(s,t)
NG_chiller(s,t)
P_ehp(s,t)
P_eesch(s,t)
P_eesdch(s,t)
P_chp(s,t)
P(s,t)
E_ees(s,t)
C_ehp(s,t)
C_chiller(s,t)
H_boiler(s,t)
H_chp(s,t)
H_ehp(s,t)
E_pu(s,t)
L_Epu(s,t)
L_Temp(t)
H_chploss(s,t)
**************************
**************************
binary variable
I_ch(s,t)
I_dch(s,t)
I_H(s,t)
I_C(s,t)
**************************
**************************
variable
Z
PG(s,t)
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
;

of.. Z=e=sum((s,t),Pr(s)*(CNG*NG(s,t)+CE*PG(s,t)+Cd(t)*E_ees(s,t)));
c1(s,t)..NG(s,t)=e=NG_boiler(s,t)+NG_chiller(s,t)+NG_chp(s,t);
c2(s,t)..PG(s,t)=e=P_load(s,t)+P_ehp(s,t)+P_eesch(s,t)-P_eesdch(s,t)-P_chp(s,t);
c3(s,t)..P_load(s,t)=e=P_eesdch(s,t)+P_chp(s,t)+P(s,t);
c4(s,t)..E_ees(s,t+1)=e=E_ees(s,t)+P_eesch(s,t)*n_ch-P_eesdch(s,t)/n_dch;
c5(s)..E_ees(s,'1')=e=E_ees(s,'24');
c5a(s)..E_ees(s,'1')=e=19;
c6(s,t)..P_eesch(s,t)=l=P_eeschmax*I_ch(s,t);
c7(s,t)..P_eesdch(s,t)=l=P_eesdchmax*I_dch(s,t);
c8(s,t)..E_ees(s,t)=l=E_eesmax;
c9(s,t)..I_ch(s,t)+I_dch(s,t)=l=1;
c10(s,t)..P_chp(s,t)=l=P_chpmax;
c11(s,t)..H_chp(s,t)=l=H_chpmax ;
c12(s,t)..H_boiler(s,t)=l=H_boilermax;
c13(s,t)..H_ehp(s,t)=l=P_ehpmax*I_H(s,t);
c14(s,t)..C_ehp(s,t)=l=P_ehpmax*I_C(s,t);
c15(s,t)..I_C(s,t)+I_H(s,t)=l=1;
c16(s,t)..C_chiller(s,t)=l=C_chillermax;
c17(s,t)..H_chp(s,t)+H_chploss(s,t)=e=.75*P_chp(s,t);
c18(s,t)..n_chp*(12*NG_chp(s,t))=e=(H_chp(s,t)+H_chploss(s,t)+P_chp(s,t));
c19(s,t)..n_chiller*(12*NG_chiller(s,t))=e=C_chiller(s,t);
c20(s,t)..n_boiler*(12*NG_boiler(s,t))=e=H_boiler(s,t);
c21(s,t)..COP_ehp*P_ehp(s,t)=e=(C_ehp(s,t)+H_ehp(s,t));
c22(s,t)..C_load(s,t)=e=C_ehp(s,t)+C_chiller(s,t);
c23(s,t)..H_load(s,t)=e=H_chp(s,t)+H_boiler(s,t)+H_ehp(s,t);
c24(s,t)..E_pu(s,t)*E_eesmax=e=E_ees(s,t);



Model opt /all/;
Solve opt us MIP min Z;
execute_unload "Winter_S.gdx" ;
