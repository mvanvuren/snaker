# Snaker

## Introduction

Based on an arcade action game, I wrote a [ZX Spectrum](https://en.wikipedia.org/wiki/ZX_Spectrum) version of it in [ZX Basic](https://worldofspectrum.org/ZXBasicManual/) way back in 1985. The game was bought by the UK magazine Spectrum Computing, and the [ROM](https://spectrumcomputing.co.uk/entry/4590/ZX-Spectrum/Snaker) can still be found on the internet.

Recently I discovered you can program for the ZX Spectrum within Visual Studio by using the integrated ZX Spectrum IDE called [SpectNet IDE](https://dotneteer.github.io/spectnetide/) using a slighlty modified version of [ZX Basic](https://zxbasic.readthedocs.io/en/docs/).

So I did...

## Play it

Using the Javascript ZX Spectrum emulator [JSSpeccy](https://github.com/gasman/jsspeccy3) you can play the game [here](https://snaker.mvanvuren.nl/).

![Snaker!](/assets/sss.png "Snaker")

## The original code

Getting the most performance out of the ZX Spectrum, every trick out of the book was used:

````BASIC
1 LET s=0: LET w=0: LET t=0: LET sl=3: LET bl=1: GO TO (10 AND PEEK 65507 <>243)+(9000 AND PEEK 65507=243)
2 LET x=20: LET y=30: DIM x(1005): DIM y(1005): LET l=bl+1: LET a=l: LET t=550-10*a: LET c$="7": FOR f=1 TO bl: LET x(f)=x: LET y(f)=(y-bl)+f: PRINT AT x(f),y(f); INK 3;"\O": LET u= USR 65232: NEXT f
3 LET xt=0: LET yt=0: LET xt=2*(c$="6")-2*(c$="7"): LET yt=2*(c$="8")-2*(c$="5")
4 IF x+xt<0 OR x+xt>20 OR y+yt<0 OR y+yt>30 THEN GO TO 9
5 LET x=x+xt: LET y=y+yt: LET x(a)=x+(xt=-2)-(xt=2): LET y(a)=y+(yt=-2)-(yt=2): LET x(a+1)=x: LET y(a+1)=y: LET a=a+2: LET l=l+1
6 IF ATTR (x,y)=242 THEN LET u= USR 65232: LET p=p+1: IF p=20 THEN GO TO 10
7 IF ATTR (x,y)=67 OR t <=0 THEN GO TO 14
8 PRINT AT x(a-l),y(a-l);" "; AT x(a-2),y(a-2); INK 3;"\O"; AT x,y;"\O"
9 LET c$= INKEY$: LET t=t-1: PRINT AT 21,5;t;" ": GO TO 3+(c$="")
10 LET p=0: LET w=w+1: LET bl=bl+3*(bl<31): LET s=s+t*w: CLS 
11 FOR f=0 TO 18 STEP 2: LET q=( INT ( RND*14)*2)+2: LET o= INT ( RND*16)*2: LET q=q-2*(q=o): PRINT AT f,q; INK 2; PAPER 6; FLASH 1;"\A"; AT f,o;"\A": NEXT f
12 FOR f=1 TO 19 STEP 2: PRINT AT f,1;"\A \A \A \A \A \A \A \A \A \A \A \A \A \A \A": NEXT f
13 PRINT AT 21,0;,,; AT 21,0;"TIME:"; AT 21,9;"SCORE:";s; AT 21,22;"WAVE:";w; AT 21,30;"\O" AND sl >=2;"\O" AND sl=3: GO TO 2
14 PRINT AT x(a-2),y(a-2);"\O": LET u= USR 65200: FOR f=a-l TO a-2: PRINT AT x(f),y(f);" ": NEXT f: LET sl=sl-1: LET s=s+w*(550-t): GO TO 13+2*(sl=0)
15 CLS : PRINT AT 2,12; INK 3;"SNAKER": IF s>h(10) THEN PRINT AT 4,7;"CONGRATULATIONS!!!": INPUT "YOUR INITIALS,PLEASE!!!"; LINE n$: FOR f=10 TO 2 STEP -1: LET h(f)=h(f-(h(f-1)<s)): LET h$(f)=h$(f-(h(f-1)<s)): IF h(f)<s THEN LET h(f-1)=s: LET h$(f-1, TO 4)=n$
16 NEXT f: PRINT AT 6,4;"HI-SCORE:"; AT 6,21;"INITIALS:": FOR f=8 TO 17: PRINT AT f,2;f-7; AT f,6;h(f-7); AT f,21;h$(f-7): NEXT f: PRINT AT 20,8;"DO YOU REQUIRE"'" PLAYING INSTRUCTIONS?(Y or N)": PRINT #1;"     Or Press 'Q' to QUIT": LET x=0: LET y=0: LET xl=255: LET yl=175
17 OVER 1: PLOT x,y: DRAW xl,0: DRAW 0,yl: DRAW -xl,0: DRAW 0,-yl+1: LET x=x+1: LET y=y+1: LET xl=xl-2: LET yl=yl-2: OVER 0: GO TO 17+(yl=-1 OR INKEY$="Y")-16*( INKEY$="N")+13*( INKEY$="Q")
18 CLS : FOR f=7 TO 4 STEP -1: INK f: PRINT AT 2,12;"SNAKER"; AT 4,0;"Move snake with the CURSOR keys","and munch the dots in the field","Try to avoid a crash with the","body of the snake","When you come further into the","game the snake starts longer","while your time","is less"; AT 13,11;"Good luck!": LET u= USR 65232: NEXT f
19 GO TO 19*( INKEY$="")
20 GO SUB 100: BORDER 0: PAPER 0: INK 4: BRIGHT 1: CLEAR 65199: RESTORE 
21 FOR f=1 TO 2: READ b$: FOR a=0 TO 7: READ x: POKE USR b$+a,x: NEXT a: NEXT f
22 DATA "\O",60,126,126,255,255,126,126,60
23 DATA "\A",0,0,60,60,60,60,0,0
24 CLEAR 65199: FOR f=65200 TO 65254: READ x: POKE f,x: NEXT f
25 DATA 58,72,92,31,31,31,230,7,225,229,95,14,0,22,15,126,230,16,131,211,254,65,16,254,35,21,32,243,13,32,238,201,1,80,0,33,0,5,237,66,17,1,0,229,197,205,181,3,193,225,124,167,32,240,201
26 DIM h(10): DIM h$(10,4): LET s=10000: FOR f=1 TO 10: LET h(f)=s: LET h$(f)="MF ": LET s=s-1000: NEXT f: POKE 23658,8
27 GO TO 15
30 POKE 23658,0: BRIGHT 0: INK 9: CLEAR : PRINT AT 11,4;"END OF PROGRAM"
35 LIST 9e3: STOP 
100 LET a= PEEK 65535: POKE 65535,96: IF PEEK 65535 <>96 THEN CLS : PRINT ''''"  SORRY - SNAKER REQUIRES 48K"''"                         ": GO TO 35
110 POKE 65535,a: POKE 23733,255: POKE 23676,255
120 RETURN 
9000 SAVE "Snaker" LINE 20: PRINT USR 65507
````

It does not follow all software design principles we know nowadays, but it did the job...

## 2021

Refactoring the original code was a lot of fun and in the process of it I even discovered a couple of bugs. I'm not sure if the [new code](https://github.com/mvanvuren/snaker/blob/master/snaker2021/snaker2021/ZxBasicFiles/snaker2021.zxbas) in it's current state is better understandable than the original ;-)

## Links

- [Snaker ROM](https://spectrumcomputing.co.uk/entry/4590/ZX-Spectrum/Snaker)
- [ZX Spectrum 4.net](https://www.zxspectrum4.net/)
- [Fuse](http://fuse-emulator.sourceforge.net/)
- [SpecNet IDE](https://dotneteer.github.io/spectnetide/)
- [ZX Basic](https://zxbasic.readthedocs.io/en/docs/)
- [Spectrum ROM Disassembly](http://www.primrosebank.net/computers/zxspectrum/docs/CompleteSpectrumROMDisassemblyThe.pdf)
- [T-Shirt](https://www.wish.com/product/5d81fbae530d9325de37bb93?hide_login_modal=true&from_ad=goog_shopping&_display_country_code=NL&_force_currency_code=EUR&pid=googleadwords_int&c={campaignId}&ad_cid=5d81fbae530d9325de37bb93&ad_cc=NL&ad_curr=EUR&ad_price=6.00&campaign_id=8182633582&exclude_install=true&gclid=EAIaIQobChMI4KjY7Ork8QIVis13Ch0h8AWnEAQYASABEgJamvD_BwE&share=web){:target="_blank"}
