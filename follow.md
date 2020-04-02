# 附录一 程序

程序如下:

```assembly
TM_NUM EQU 23H
TM_L EQU 22H
TM_H EQU 21H
DSPBUF EQU 40H
DQ BIT P2.0
FLAG BIT 00H
ORG 0000H
AJMP MAIN
ORG 000BH
AJMP __INTT0__
ORG 30H
MAIN: MOV SP,#070H
      MOV TMOD,#02H
      MOV IE,#82H
      MOV TH0,#6
      MOV TL0,#6
      MOV R2,#04
      MOV R1,#40H
 LL1: MOV @R1,#00
      INC R1
      DJNZ R2,LL1
      SETB RS0
      MOV R2,#00
      MOV R3,#00
      MOV R4,#00
      MOV R5,#00
      MOV 6FH,#00H
      CLR RS0
      CLR P3.0
      MOV 30H,#02
      MOV 31H,#06
      MOV 32H,#0
      LCALL CHEWEN
__INSTANCE__:CLR TR0
      SETB P2.1
      JB P2.1,K3
      LCALL KKEY
   K3:CLR 01H
      MOV R2,44H
      CJNE R2,#00,K2
      SJMP K7
   K2:CPL P3.0
      MOV R3,#30
   K1:LCALL TM_DISP
      DJNZ R3,K1
      DJNZ R2,K2
   K7:MOV R2,45H
      CJNE R2,#00,K4
      SJMP K6
   K4:MOV R4,#255
  K44:CPL P3.0
      MOV R3,#30
   K5:LCALL TM_DISP
      DJNZ R3,K5
      DJNZ R4,K44
      DEC R2
      CJNE R2,#00,K4
  K6: CLR P3.0
      LCALL CHEWEN
      SETB TR0
MAIN2:JB 01H, __INSTANCE__
      LCALL TM_DISP
      SJMP MAIN2
CHEWEN:CLR RS1
       CLR RS0
      LCALL GET_TM
      LCALL TM_COV
      LCALL DTOB
      LCALL DTOB1
      CLR C
      MOV A,33H
      SUBB A,44H
      MOV 44H,A
      MOV A,34H
      SUBB A,45H
      MOV 45H,A
      RET

    __INTT0__:PUSH ACC
          PUSH B
          SETB RS0
          INC R2
          CJNE R2,#100,__JT0__
          INC 6FH
    
          MOV A,6FH
          CJNE A,#20,__JT0__
          MOV 6FH,#00H
          INC R3
          MOV R2,#00H
          CJNE R3,#2,__JT0__
          SETB 01H
          MOV R3,#00
    
     __JT0__: CLR RS0
          POP B
          POP ACC
          RETI


KKEY: MOV R2,#00
      MOV R4,#0AH
 KS2: LCALL TM_DISP
      DJNZ R4,KS2
      SETB P2.1
      JB P2.1,KKEY1
      JNB P2.1,$
      MOV 60H,#DSPBUF+1
      MOV R1,#DSPBUF+1
      MOV R2,#00
KEY1: LCALL TM_DISP_2
      MOV P2,#0FFH
      MOV A,P2
      ORL A,#01
      CPL A
      JZ KEY1

KEY2: JNB ACC.1,KEY3
      JNB P2.1,$
      INC R1

      INC R2
      CJNE R2,#03,L13
      MOV R1,#DSPBUF+1
      MOV R2,#00

 L13: MOV 60H,R1
      SJMP KEY1
KEY3: JNB ACC.2,KEY4
      JNB P2.2,$
      MOV A,@R1
      CJNE R1,#41H,L1
      CJNE A,#09,LL
      SJMP KEY5
  L1: CJNE R1,#42H,L2
      MOV A,@R1
      CJNE A,#09,LL
      SJMP KEY5
  L2: CJNE R1,#43H,L3
      CJNE A,#09,LL

KEY5: MOV @R1,#00
  L3: SJMP KEY1
  LL: INC A
      MOV @R1,A
  L6: SJMP KEY1
KEY4: JNB ACC.3,KEY1
      JNB P2.3,$
      MOV 30H,41H
      MOV 31H,42H
      MOV 32H,43H
      ACALL DTOB
KKEY1:RET

     DTOB:SETB RS0
          SETB RS1
          MOV A,31H
          MOV B,#10
          MUL AB
          ADD A,32H
          MOV 33H,A
          MOV 34H,#00
          MOV R6,30H
          CJNE R6,#00,JT2
          SJMP JT22
     JT2: MOV A,33H
          ADD A,#100
          MOV 33H,A
          MOV A,34H
          ADDC A,#00
          MOV 34H,A
          DJNZ R6,JT2
     JT22:CLR RS1
          CLR RS0
          RET

  DTOB1:  SETB RS0
          SETB RS1
          MOV A,42H
          MOV B,#10
          MUL AB
          ADD A,43H
          MOV 44H,A
          MOV 45H,#00
          MOV R6,41H
          CJNE R6,#00,JJT2
          SJMP JJT22
    JJT2: MOV A,44H
          ADD A,#100
          MOV 44H,A
          MOV A,45H
          ADDC A,#00
          MOV 45H,A
          DJNZ R6,JJT2
   JJT22: CLR RS1
          CLR RS0
          RET
WR_18B20: MOV R2,#08H
         CLR C
         SETB DQ
         MOV R3,#02H
         DJNZ R3,$
         NOP
    WR1: CLR DQ
         MOV R3,#03H
         DJNZ R3,$
         RRC A
         MOV DQ,C
         MOV R3,#20
         DJNZ R3,$
         SETB DQ
         MOV R3,#03H
         DJNZ R3,$
         DJNZ R2,WR1
         SETB DQ
         RET
RD_18B20: MOV R4,#02H
          MOV R1,#22H
     RE0: MOV R2,#08H
     RE1: CLR C
          SETB DQ
          NOP
          CLR DQ
          NOP
          NOP
          SETB DQ
          MOV R3,#01H
          DJNZ R3,$
          MOV C,DQ
          MOV R3,#010H
          DJNZ R3,$
          RRC A
          DJNZ R2,RE1
          MOV @R1,A
          DEC R1
          DJNZ R4,RE0
          RET
INI_18B20: SETB DQ
           NOP
           CLR DQ
           MOV R4,#150
           DJNZ R4,$
          ;LCALL TM_DISP
          ;LCALL TM_DISP
           SETB DQ
      TS0: MOV R4,#19H
           JNB DQ,TS1
           DJNZ R4,TS0
           SJMP TS2
      TS1: SETB FLAG
           SJMP TS3
      TS2: CLR FLAG
           SJMP TS4
      TS3: ;LCALL TM_DISP
           MOV R4,#120
           DJNZ R4,$
      TS4: SETB DQ
           RET
DELAY8ms: MOV R6,#2H
      KL1: MOV R7,#80H

      KL2: DJNZ R7,KL2
          DJNZ R6,KL1
          RET

GET_TM: SETB DQ
    S1: LCALL INI_18B20
        JB FLAG,S2
        SJMP S1
    S2: MOV R4,#10H
        DJNZ R4,$
        MOV A,#0CCH
        LCALL WR_18B20
        MOV A,#44H
        LCALL WR_18B20
        MOV R4,#0ffH
    S3: LCALL TM_DISP
        DJNZ R4,S3
    S4: LCALL INI_18B20
        JB FLAG,S5
        SJMP S4
    S5: MOV A,#0CCH
        LCALL WR_18B20
        MOV A,#0BEH
        LCALL WR_18B20
        LCALL RD_18B20
        LCALL INI_18B20
        MOV R4,#10H
    S6: LCALL TM_DISP
        DJNZ R4,S6
    S7: RET
TM_COV: MOV A,#0F0H
        ANL A,TM_L
        SWAP A
        MOV TM_NUM,A
        MOV A,TM_H
        ANL A,#07H
        SWAP A
        ORL A,TM_NUM
        MOV TM_NUM,A
        MOV R0,#DSPBUF
        JNB 0FH,SING
        MOV @R0,#0BH
        CPL A
        CLR ACC.7
        ADD A,#01H
        MOV TM_NUM,A
        SJMP SING1
  SING: MOV @R0,#0AH
 SING1: MOV B,#10
        DIV AB
        INC R0
        MOV @R0,A
        INC R0
        MOV A,B
        MOV @R0,A
        INC R0
        MOV A,#00H
        JNB 13H,DOT1
        ADD A,#50
  DOT1: JNB 12H,DOT2
        ADD A,#25
  DOT2: JNB 11H,DOT3
        ADD A,#12
  DOT3: JNB 10H,DOT4
        ADD A,#6
  DOT4: MOV B,#10
        DIV AB
        MOV @R0,A
        RET
TM_DISP: CLR RS1
         CLR RS0
         MOV DPTR,#TAB
         MOV R0,#DSPBUF
         MOV B,#0FEH
         MOV R5,#04
   DIP1: MOV A,@R0
         MOV P0,#0FFH
         MOV P1,#0FFH
         MOVC A,@A+DPTR
         CJNE R5,#02,DIP2
         ANL A,#7FH
   DIP2: MOV P0,A
         MOV A,B
         MOV P1,A
         RL A
         MOV B,A
         LCALL DELAY8ms
         INC R0
         DJNZ R5,DIP1
         RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TM_DISP_1: CLR RS1
         CLR RS0
         MOV DPTR,#TAB
         MOV R0,#DSPBUF
         MOV B,#0FEH
         MOV R5,#04
 DDIP4:  MOV A,R0
         MOV P0,#0FFH
         MOV P1,#0FFH
         CJNE A,60H,DDIP1
         MOV A,#0FFH
         SJMP DDIP3
  DDIP1: MOV A,@R0
         MOVC A,@A+DPTR
  DDIP3: CJNE R5,#02,DDIP2
         ANL A,#7FH
  DDIP2: MOV P0,A
         MOV A,B
         MOV P1,A
         RL A
         MOV B,A
         LCALL DELAY8ms
         INC R0
         DJNZ R5,DDIP4
         RET
 ;;;;;;;;;;;;;;;;;;;;;
 TM_DISP_2: MOV R4,#10H
  KS4: LCALL TM_DISP
      DJNZ R4,KS4
      MOV R4,#1FH
  KS5: LCALL TM_DISP_1
      DJNZ R4,KS5
      RET
TAB:
DB 0C0H,0F9H,0A4H,0B0H,99H,92H,82H,0F8H,80H,90H,0FFH,0CFH
END

```

# 附录二  硬件电路图

![图10-8 硬件电路图](http://my.gunplan.top/static/yj1.png)