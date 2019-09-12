
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32A
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32A
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _Code_tay_cam1=R5
	.DEF _dem=R4
	.DEF _dem1=R7
	.DEF _steering=R6
	.DEF _RC2=R9
	.DEF _RC3=R8
	.DEF _RC4=R11
	.DEF _RC5=R10
	.DEF _RC6=R13
	.DEF _RC7=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer2_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0xB5,0x0,0x0

_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x04
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;unsigned char Code_tay_cam1 = 0xB5;
;#include <mega32a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include <stdio.h>
;#include <stdlib.h>
;#include "define.c"
;#define servo_1 PORTB.1
;#define servo_2 PORTB.2
;#define servo_3 PORTB.4
;#define servo_4 PORTD.0
;#define servo_5 PORTD.1
;#define servo_6 PORTD.2
;#define servo_7 PORTD.3
;#define servo_8 PORTD.6
;
;//---------------------
;#define laser    PORTA.2
;#define led    PORTA.3
;
;#define PWM_1 OCR1A
;#define DIR_1 PORTA.4
;//--------------------
;#define PWM_2 OCR1B
;#define DIR_2 PORTA.5
;//-------------------
;#define CE PORTC.2
;#define CSN PORTC.6
;#define SCK PORTC.1
;#define MOSI PORTC.7
;#define MISO PINC.0
;#define IRQ PINA.7
;
;
;
;
;
;
;#include "init.c"
;unsigned char dem=0, dem1=0;
;unsigned char steering,RC2,RC3,RC4,RC5,RC6,RC7,RC8;
;
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 0007 {

	.CSEG
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
;TCNT0=0x9C;
	LDI  R30,LOW(156)
	OUT  0x32,R30
;dem++;
	INC  R4
;if(dem==200){dem=0;}
	LDI  R30,LOW(200)
	CP   R30,R4
	BRNE _0x3
	CLR  R4
;if(dem<steering){servo_1=1;}else{servo_1=0;}
_0x3:
	CP   R4,R6
	BRSH _0x4
	SBI  0x18,1
	RJMP _0x7
_0x4:
	CBI  0x18,1
_0x7:
;if(dem1<RC6){servo_6=1;}else{servo_6=0;}
	CP   R7,R13
	BRSH _0xA
	SBI  0x12,2
	RJMP _0xD
_0xA:
	CBI  0x12,2
_0xD:
;
;}
	RJMP _0xB5
; .FEND
;
;interrupt [TIM2_OVF] void timer2_ovf_isr(void)
;{
_timer2_ovf_isr:
; .FSTART _timer2_ovf_isr
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
;TCNT2=0x9C;
	LDI  R30,LOW(156)
	OUT  0x24,R30
;dem1++;
	INC  R7
;if(dem1==200){dem1=0;}
	LDI  R30,LOW(200)
	CP   R30,R7
	BRNE _0x10
	CLR  R7
;if(dem<RC2){servo_2=1;}else{servo_2=0;}
_0x10:
	CP   R4,R9
	BRSH _0x11
	SBI  0x18,2
	RJMP _0x14
_0x11:
	CBI  0x18,2
_0x14:
;if(dem<RC3){servo_3=1;}else{servo_3=0;}
	CP   R4,R8
	BRSH _0x17
	SBI  0x18,4
	RJMP _0x1A
_0x17:
	CBI  0x18,4
_0x1A:
;if(dem<RC4){servo_4=1;}else{servo_4=0;}
	CP   R4,R11
	BRSH _0x1D
	SBI  0x12,0
	RJMP _0x20
_0x1D:
	CBI  0x12,0
_0x20:
;if(dem1<RC5){servo_5=1;}else{servo_5=0;}
	CP   R7,R10
	BRSH _0x23
	SBI  0x12,1
	RJMP _0x26
_0x23:
	CBI  0x12,1
_0x26:
;if(dem1<RC7){servo_7=1;}else{servo_7=0;}
	CP   R7,R12
	BRSH _0x29
	SBI  0x12,3
	RJMP _0x2C
_0x29:
	CBI  0x12,3
_0x2C:
;if(dem1<RC8){servo_8=1;}else{servo_8=0;}
	LDS  R30,_RC8
	CP   R7,R30
	BRSH _0x2F
	SBI  0x12,6
	RJMP _0x32
_0x2F:
	CBI  0x12,6
_0x32:
;}
_0xB5:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	RETI
; .FEND
;
;
;
;void init(void)
;{
_init:
; .FSTART _init
;
;DDRA=(0<<DDA7) | (0<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (0<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(60)
	OUT  0x1A,R30
;PORTA=(1<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	LDI  R30,LOW(128)
	OUT  0x1B,R30
;
;DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (1<<DDB2) | (1<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(6)
	OUT  0x17,R30
;PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
;
;DDRC=(1<<DDC7) | (1<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (1<<DDC2) | (1<<DDC1) | (0<<DDC0);
	LDI  R30,LOW(198)
	OUT  0x14,R30
;PORTC=(1<<PORTC7) | (1<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (1<<PORTC2) | (1<<PORTC1) | (1<<PORTC0);
	LDI  R30,LOW(199)
	OUT  0x15,R30
;
;
;DDRD=(0<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4) | (0<<DDD3) | (1<<DDD2) | (0<<DDD1) | (0<<DDD0);
	LDI  R30,LOW(116)
	OUT  0x11,R30
;PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(0)
	OUT  0x12,R30
;
;// Timer Period: 0.1 ms
;TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (1<<CS01) | (0<<CS00);
	LDI  R30,LOW(2)
	OUT  0x33,R30
;TCNT0=0x9C;
	LDI  R30,LOW(156)
	OUT  0x32,R30
;OCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x3C,R30
;
;// Timer Period: 4.096 ms
;
;TCCR1A=(1<<COM1A1) | (0<<COM1A0) | (1<<COM1B1) | (0<<COM1B0) | (1<<WGM11) | (0<<WGM10);
	LDI  R30,LOW(162)
	OUT  0x2F,R30
;TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (1<<WGM12) | (0<<CS12) | (1<<CS11) | (1<<CS10);
	LDI  R30,LOW(11)
	OUT  0x2E,R30
;TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
;TCNT1L=0x00;
	OUT  0x2C,R30
;ICR1H=0x00;
	OUT  0x27,R30
;ICR1L=0x00;
	OUT  0x26,R30
;OCR1AH=0x00;
	OUT  0x2B,R30
;OCR1AL=0x00;
	OUT  0x2A,R30
;OCR1BH=0x00;
	OUT  0x29,R30
;OCR1BL=0x00;
	OUT  0x28,R30
;
;// Timer Period: 0.1 ms
;ASSR=0<<AS2;
	OUT  0x22,R30
;TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (1<<CS21) | (0<<CS20);
	LDI  R30,LOW(2)
	OUT  0x25,R30
;TCNT2=0x9C;
	LDI  R30,LOW(156)
	OUT  0x24,R30
;OCR2=0x00;
	LDI  R30,LOW(0)
	OUT  0x23,R30
;
;// Timer(s)/Counter(s) Interrupt(s) initialization
;TIMSK=(0<<OCIE2) | (1<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
	LDI  R30,LOW(65)
	OUT  0x39,R30
;
;MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	LDI  R30,LOW(0)
	OUT  0x35,R30
;MCUCSR=(0<<ISC2);
	OUT  0x34,R30
;
;
;ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
;SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
;
;ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	OUT  0x6,R30
;
;SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
;
;
;TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
;
;#asm("sei")
	sei
;}
	RET
; .FEND
;#include "dong_co.c"
;void control_motor(unsigned char motor,unsigned char dir_motor,unsigned char speed){
; 0000 0008 void control_motor(unsigned char motor,unsigned char dir_motor,unsigned char speed){
_control_motor:
; .FSTART _control_motor
;    switch (motor){
	ST   -Y,R26
;	motor -> Y+2
;	dir_motor -> Y+1
;	speed -> Y+0
	LDD  R30,Y+2
	LDI  R31,0
;        case 1:{
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x38
;            if(dir_motor==0){
	LDD  R30,Y+1
	CPI  R30,0
	BRNE _0x39
;                DIR_1 = dir_motor;
	CPI  R30,0
	BRNE _0x3A
	CBI  0x1B,4
	RJMP _0x3B
_0x3A:
	SBI  0x1B,4
_0x3B:
;                PWM_1 = speed;
	LD   R30,Y
	LDI  R31,0
	OUT  0x2A+1,R31
	OUT  0x2A,R30
;                break;
	RJMP _0x37
;            }
;            else {
_0x39:
;                DIR_1 = dir_motor;
	LDD  R30,Y+1
	CPI  R30,0
	BRNE _0x3D
	CBI  0x1B,4
	RJMP _0x3E
_0x3D:
	SBI  0x1B,4
_0x3E:
;                PWM_1 = 255 - speed;
	CALL SUBOPT_0x0
	OUT  0x2A+1,R31
	OUT  0x2A,R30
;                break;
	RJMP _0x37
;            }
;        }
;        case 2:{
_0x38:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x37
;            if(dir_motor==0){
	LDD  R30,Y+1
	CPI  R30,0
	BRNE _0x41
;                DIR_2 = dir_motor;
	CPI  R30,0
	BRNE _0x42
	CBI  0x1B,5
	RJMP _0x43
_0x42:
	SBI  0x1B,5
_0x43:
;                PWM_2 = speed;
	LD   R30,Y
	LDI  R31,0
	OUT  0x28+1,R31
	OUT  0x28,R30
;                break;
	RJMP _0x37
;            }
;            else{
_0x41:
;                DIR_2 = dir_motor;
	LDD  R30,Y+1
	CPI  R30,0
	BRNE _0x45
	CBI  0x1B,5
	RJMP _0x46
_0x45:
	SBI  0x1B,5
_0x46:
;                PWM_2 = 255 - speed;
	CALL SUBOPT_0x0
	OUT  0x28+1,R31
	OUT  0x28,R30
;                break;
;            }
;        }
;    }
_0x37:
;}
	ADIW R28,3
	RET
; .FEND
;void dung_yen(){
_dung_yen:
; .FSTART _dung_yen
;    control_motor(1,0,0);
	LDI  R30,LOW(1)
	CALL SUBOPT_0x1
;    control_motor(2,0,0);
	LDI  R30,LOW(2)
	CALL SUBOPT_0x1
;}
	RET
; .FEND
;
;void di_lui(int speed){
_di_lui:
; .FSTART _di_lui
;    control_motor(1,1,255-speed);
	ST   -Y,R27
	ST   -Y,R26
;	speed -> Y+0
	LDI  R30,LOW(1)
	CALL SUBOPT_0x2
;    control_motor(2,1,255-speed);
	LDI  R30,LOW(2)
	CALL SUBOPT_0x2
;}
	RJMP _0x20A0002
; .FEND
;
;void di_thang(int speed){
_di_thang:
; .FSTART _di_thang
;    control_motor(1,0,speed);
	ST   -Y,R27
	ST   -Y,R26
;	speed -> Y+0
	LDI  R30,LOW(1)
	CALL SUBOPT_0x3
;    control_motor(2,0,speed);
	LDI  R30,LOW(2)
	CALL SUBOPT_0x3
;}
	RJMP _0x20A0002
; .FEND
;
;void start_servo()
;{
_start_servo:
; .FSTART _start_servo
;DDRB.2=1;
	SBI  0x17,2
;DDRB.4=1;
	SBI  0x17,4
;DDRD.0=1;
	SBI  0x11,0
;DDRD.1=1;
	SBI  0x11,1
;DDRD.2=1;
	SBI  0x11,2
;DDRD.3=1;
	SBI  0x11,3
;DDRD.6=1;
	SBI  0x11,6
;}
	RET
; .FEND
;void stop_servo()
;{
;DDRB.2=0;
;DDRB.4=0;
;DDRD.0=0;
;DDRD.1=0;
;DDRD.2=0;
;DDRD.3=0;
;DDRD.6=0;
;}
;
;void ban()
;{
_ban:
; .FSTART _ban
;PORTD.2=1;
	SBI  0x12,2
;RC6=16;
	LDI  R30,LOW(16)
	MOV  R13,R30
;delay_ms(600);
	LDI  R26,LOW(600)
	LDI  R27,HIGH(600)
	CALL _delay_ms
;RC6=7;
	LDI  R30,LOW(7)
	MOV  R13,R30
;}
	RET
; .FEND
;#include "rf.c"
;//#define CE PORTD.4      //out 1
;//#define CSN PORTD.5      //out 1
;//#define SCK PORTD.3       //out 1
;//#define MOSI PORTD.6      //out 1
;//#define MISO PIND.2       //in p
;//#define IRQ PIND.7        //in p
;
;typedef struct
;{
;    int analog_l;
;    int analog_r;
;    int digital_l;
;    int digital_r;
;}data;
;
;data receive;
;
;//--------------*---------------
;unsigned char Code_tay_cam2 ;
;unsigned char Code_tay_cam3;
;unsigned char Code_tay_cam4;
;unsigned char SPI_RW(unsigned char Buff);                                       //Function used for text moving
;unsigned char SPI_Read(void);
;void RF_Init();                                                                 //Function allow to Initialize RF device
;void RF_Write(unsigned char Reg_Add, unsigned char Value);                      //Function to write a value to a registe ...
;void RF_Command(unsigned char command);                                         //Function to write a command
;void RF_Write_Address(unsigned char Address1, unsigned char Address2, unsigned char Address3, unsigned char Address4);   ...
;void RX_Mode();                                                          //Function to put nRF in RX mode
;void RF_Config();                                                               //Function to config the nRF
;void RF_RX_Read();                                                     //Function to read the data from RX FIFO
;void RF_Write2(unsigned char Reg_Add, unsigned char Value);
;void RF_Write3(unsigned char Reg_Add, unsigned char Value);
;
;
;
;unsigned char SPI_RW(unsigned char Buff)
; 0000 0009 {
_SPI_RW:
; .FSTART _SPI_RW
;    unsigned char bit_ctr;
;       for(bit_ctr=0;bit_ctr<8;bit_ctr++) // output 8-bit
	ST   -Y,R26
	ST   -Y,R17
;	Buff -> Y+1
;	bit_ctr -> R17
	LDI  R17,LOW(0)
_0x66:
	CPI  R17,8
	BRSH _0x67
;       {
;        MOSI = (Buff & 0x80);         // output 'uchar', MSB to MOSI
	LDD  R30,Y+1
	ANDI R30,LOW(0x80)
	BRNE _0x68
	CBI  0x15,7
	RJMP _0x69
_0x68:
	SBI  0x15,7
_0x69:
;        delay_us(5);
	__DELAY_USB 13
;        Buff = (Buff << 1);           // shift next bit into MSB..
	LDD  R30,Y+1
	LSL  R30
	STD  Y+1,R30
;        SCK = 1;                      // Set SCK high..
	CALL SUBOPT_0x4
;        delay_us(5);
;        Buff |= MISO;                 // capture current MISO bit
	LDD  R26,Y+1
	OR   R30,R26
	STD  Y+1,R30
;        SCK = 0;                      // ..then set SCK low again
	CBI  0x15,1
;       }
	SUBI R17,-1
	RJMP _0x66
_0x67:
;    return(Buff);                     // return read uchar
	LDD  R30,Y+1
	LDD  R17,Y+0
	RJMP _0x20A0002
;}
; .FEND
;unsigned char SPI_Read(void)
;{   unsigned char Buff=0;
_SPI_Read:
; .FSTART _SPI_Read
;    unsigned char bit_ctr;
;       for(bit_ctr=0;bit_ctr<8;bit_ctr++) // output 8-bit
	ST   -Y,R17
	ST   -Y,R16
;	Buff -> R17
;	bit_ctr -> R16
	LDI  R17,0
	LDI  R16,LOW(0)
_0x6F:
	CPI  R16,8
	BRSH _0x70
;       {
;        delay_us(5);
	__DELAY_USB 13
;        Buff = (Buff << 1);           // shift next bit into MSB..
	LSL  R17
;        SCK = 1;                      // Set SCK high..
	CALL SUBOPT_0x4
;        delay_us(5);
;        Buff |= MISO;                 // capture current MISO bit
	OR   R17,R30
;        SCK = 0;                      // ..then set SCK low again
	CBI  0x15,1
;       }
	SUBI R16,-1
	RJMP _0x6F
_0x70:
;    return(Buff);                     // return read uchar
	MOV  R30,R17
	LD   R16,Y+
	LD   R17,Y+
	RET
;}
; .FEND
;void RF_Init()                                                    //Function allow to Initialize RF device
;{
_RF_Init:
; .FSTART _RF_Init
;    CE=1;
	SBI  0x15,2
;    delay_us(700);
	__DELAY_USW 1400
;    CE=0;
	CBI  0x15,2
;    CSN=1;
	SBI  0x15,6
;}
	RET
; .FEND
;void RF_Write(unsigned char Reg_Add, unsigned char Value)         //Function to write a value to a register address
;{
_RF_Write:
; .FSTART _RF_Write
;    CSN=0;
	CALL SUBOPT_0x5
;	Reg_Add -> Y+1
;	Value -> Y+0
;    SPI_RW(0b00100000|Reg_Add);
	RJMP _0x20A0001
;    SPI_RW(Value);
;    CSN=1;
;    delay_us(10);
;}
; .FEND
;void RF_Write2(unsigned char Reg_Add, unsigned char Value)         //Function to write a value to a register address
;{
_RF_Write2:
; .FSTART _RF_Write2
;    CSN=0;
	CALL SUBOPT_0x5
;	Reg_Add -> Y+1
;	Value -> Y+0
;    SPI_RW(0b00100000|Reg_Add);
	RCALL _SPI_RW
;    SPI_RW(Value);
	LD   R26,Y
	RCALL _SPI_RW
;    SPI_RW(Value);
	LD   R26,Y
	RCALL _SPI_RW
;    SPI_RW(Value);
	LD   R26,Y
	RCALL _SPI_RW
;    SPI_RW(Value);
	LD   R26,Y
	RJMP _0x20A0001
;    SPI_RW(Value);
;    CSN=1;
;    delay_us(10);
;}
; .FEND
;void RF_Write3(unsigned char Reg_Add, unsigned char Value)         //Function to write a value to a register address
;{
_RF_Write3:
; .FSTART _RF_Write3
;    CSN=0;
	CALL SUBOPT_0x5
;	Reg_Add -> Y+1
;	Value -> Y+0
;    SPI_RW(0b00100000|Reg_Add);
	RCALL _SPI_RW
;    SPI_RW(0x48);
	LDI  R26,LOW(72)
	RCALL _SPI_RW
;    SPI_RW(0x48);
	LDI  R26,LOW(72)
	RCALL _SPI_RW
;    SPI_RW(0x48);
	LDI  R26,LOW(72)
	RCALL _SPI_RW
;    SPI_RW(0x48);
	LDI  R26,LOW(72)
_0x20A0001:
	RCALL _SPI_RW
;    SPI_RW(Value);
	CALL SUBOPT_0x6
;
;
;    CSN=1;
;    delay_us(10);
;}
_0x20A0002:
	ADIW R28,2
	RET
; .FEND
;void RF_Command(unsigned char command)                            //Function to write a command
;{
_RF_Command:
; .FSTART _RF_Command
;    CSN=0;
	ST   -Y,R26
;	command -> Y+0
	CBI  0x15,6
;    SPI_RW(command);
	CALL SUBOPT_0x6
;    CSN=1;
;    delay_us(10);
;}
	ADIW R28,1
	RET
; .FEND
;void RF_Write_Address(unsigned char Address1, unsigned char Address2, unsigned char Address3, unsigned char Address4)    ...
;{
_RF_Write_Address:
; .FSTART _RF_Write_Address
;    CSN=0;
	ST   -Y,R26
;	Address1 -> Y+3
;	Address2 -> Y+2
;	Address3 -> Y+1
;	Address4 -> Y+0
	CBI  0x15,6
;    RF_Write(0x03,0b00000011);
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R26,LOW(3)
	RCALL _RF_Write
;    CSN=1;
	SBI  0x15,6
;    delay_us(10);
	__DELAY_USB 27
;    CSN=0;
	CBI  0x15,6
;    RF_Write2(0x0A, Address1);
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDD  R26,Y+4
	RCALL _RF_Write2
;    RF_Write2(0x10, Address1);
	LDI  R30,LOW(16)
	ST   -Y,R30
	LDD  R26,Y+4
	RCALL _RF_Write2
;
;    RF_Write3(0x0B, Address2);
	LDI  R30,LOW(11)
	ST   -Y,R30
	LDD  R26,Y+3
	CALL SUBOPT_0x7
;    RF_Write3(0x10, Address2);
	LDD  R26,Y+3
	RCALL _RF_Write3
;
;    RF_Write3(0x0C, Address3);
	LDI  R30,LOW(12)
	ST   -Y,R30
	LDD  R26,Y+2
	CALL SUBOPT_0x7
;    RF_Write3(0x10, Address3);
	LDD  R26,Y+2
	RCALL _RF_Write3
;
;    RF_Write3(0x0D, Address4);
	LDI  R30,LOW(13)
	ST   -Y,R30
	LDD  R26,Y+1
	CALL SUBOPT_0x7
;    RF_Write3(0x10, Address4);
	LDD  R26,Y+1
	RCALL _RF_Write3
;
;}
	ADIW R28,4
	RET
; .FEND
;
;void RX_Mode()                                             //Function to put nRF in RX mode
;{
_RX_Mode:
; .FSTART _RX_Mode
;    RF_Write(0x00,0b00011111);     //CONFIG 0x00
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(31)
	RCALL _RF_Write
;    CE=1;
	SBI  0x15,2
;}
	RET
; .FEND
;
;void RF_Config()                                                  //Function to config the nRF
;{
_RF_Config:
; .FSTART _RF_Config
;RF_Command(0b11100010);     //Flush RX
	LDI  R26,LOW(226)
	RCALL _RF_Command
;
;delay_us(10);
	__DELAY_USB 27
;RF_Write(0x00,0b00011111);     //CONFIG 0x00
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(31)
	RCALL _RF_Write
;
;RF_Write(0x07,0b01111010);     //RF status
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R26,LOW(122)
	RCALL _RF_Write
;/*RF_Write(0x11,0b00100000);     //RX_PW_P0 0x11     Payload size
;RF_Write(0x12,0b00100000);
;RF_Write(0x13,0b00100000);
;RF_Write(0x14,0b00100000);*/
;RF_Write(0x1D, 0b00000100);
	LDI  R30,LOW(29)
	ST   -Y,R30
	LDI  R26,LOW(4)
	RCALL _RF_Write
;RF_Write(0x1C,0b00001111);
	LDI  R30,LOW(28)
	CALL SUBOPT_0x8
;RF_Write(0x05,0b00000010);
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDI  R26,LOW(2)
	RCALL _RF_Write
;RF_Write_Address(Code_tay_cam1, Code_tay_cam2, Code_tay_cam3, Code_tay_cam4);
	ST   -Y,R5
	LDS  R30,_Code_tay_cam2
	ST   -Y,R30
	LDS  R30,_Code_tay_cam3
	ST   -Y,R30
	LDS  R26,_Code_tay_cam4
	RCALL _RF_Write_Address
;RF_Write(0x02,0b00001111);     //EX_RXADDR 0x02    enable data pipe 0;
	LDI  R30,LOW(2)
	CALL SUBOPT_0x8
;RF_Write(0x01,0b00001111);     //EN_AA 0x01        enable auto-acknowledgment
	LDI  R30,LOW(1)
	CALL SUBOPT_0x8
;RF_Write(0x04,0b00000000);     //SETUP_RETR 0x04   Setup retry time
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _RF_Write
;}
	RET
; .FEND
;void RF_RX_Read()                                         //Function to read the data from RX FIFO
;{
_RF_RX_Read:
; .FSTART _RF_RX_Read
;   CE=0;
	CBI  0x15,2
;   CSN=1;
	SBI  0x15,6
;   delay_us(10);
	__DELAY_USB 27
;   CSN=0;
	CBI  0x15,6
;   SPI_RW(0b01100001);
	LDI  R26,LOW(97)
	RCALL _SPI_RW
;   delay_us(10);
	__DELAY_USB 27
;   receive.analog_l = SPI_Read();
	RCALL _SPI_Read
	LDI  R31,0
	STS  _receive,R30
	STS  _receive+1,R31
;   receive.analog_r = SPI_Read();
	RCALL _SPI_Read
	__POINTW2MN _receive,2
	LDI  R31,0
	ST   X+,R30
	ST   X,R31
;   receive.digital_l = SPI_Read();
	RCALL _SPI_Read
	__POINTW2MN _receive,4
	LDI  R31,0
	ST   X+,R30
	ST   X,R31
;   receive.digital_r = SPI_Read();
	RCALL _SPI_Read
	__POINTW2MN _receive,6
	LDI  R31,0
	ST   X+,R30
	ST   X,R31
;   CSN=1;
	SBI  0x15,6
;   CE=1;
	SBI  0x15,2
;   RF_Write(0x07,0b01111110);  // Clear flag
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R26,LOW(126)
	RCALL _RF_Write
;   RF_Command(0b11100010);     //Flush RX
	LDI  R26,LOW(226)
	RCALL _RF_Command
;}
	RET
; .FEND
;void main(void)
; 0000 000B {
_main:
; .FSTART _main
; 0000 000C init();
	RCALL _init
; 0000 000D start_servo();
	RCALL _start_servo
; 0000 000E delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
; 0000 000F //stop_servo();
; 0000 0010 RF_Init();
	RCALL _RF_Init
; 0000 0011 RF_Config();
	RCALL _RF_Config
; 0000 0012 RX_Mode();
	RCALL _RX_Mode
; 0000 0013 steering=16;
	LDI  R30,LOW(16)
	MOV  R6,R30
; 0000 0014 while (1)
_0x9D:
; 0000 0015     {
; 0000 0016      RX_Mode();
	RCALL _RX_Mode
; 0000 0017      if(IRQ==0)
	SBIC 0x19,7
	RJMP _0xA0
; 0000 0018         {
; 0000 0019             led=!led;
	SBIS 0x1B,3
	RJMP _0xA1
	CBI  0x1B,3
	RJMP _0xA2
_0xA1:
	SBI  0x1B,3
_0xA2:
; 0000 001A             RF_RX_Read();
	RCALL _RF_RX_Read
; 0000 001B                 if (receive.analog_l ==128)                                 {dung_yen();}
	CALL SUBOPT_0x9
	CPI  R26,LOW(0x80)
	LDI  R30,HIGH(0x80)
	CPC  R27,R30
	BRNE _0xA3
	RCALL _dung_yen
; 0000 001C                 if (receive.analog_l >128)                                  {di_thang(receive.analog_l);}
_0xA3:
	CALL SUBOPT_0x9
	CPI  R26,LOW(0x81)
	LDI  R30,HIGH(0x81)
	CPC  R27,R30
	BRLT _0xA4
	CALL SUBOPT_0x9
	RCALL _di_thang
; 0000 001D                 if (receive.analog_l <128)                                  {di_lui(receive.analog_l);}
_0xA4:
	CALL SUBOPT_0x9
	CPI  R26,LOW(0x80)
	LDI  R30,HIGH(0x80)
	CPC  R27,R30
	BRGE _0xA5
	CALL SUBOPT_0x9
	RCALL _di_lui
; 0000 001E                 if (receive.analog_r ==128)                                 {steering=16;}
_0xA5:
	CALL SUBOPT_0xA
	CPI  R26,LOW(0x80)
	LDI  R30,HIGH(0x80)
	CPC  R27,R30
	BRNE _0xA6
	LDI  R30,LOW(16)
	MOV  R6,R30
; 0000 001F                 //------------------------------------
; 0000 0020                 if ((receive.analog_r >=128)&(receive.analog_r <=148))      {steering=17;}
_0xA6:
	CALL SUBOPT_0xA
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	CALL SUBOPT_0xB
	LDI  R30,LOW(148)
	LDI  R31,HIGH(148)
	CALL __LEW12
	AND  R30,R0
	BREQ _0xA7
	LDI  R30,LOW(17)
	MOV  R6,R30
; 0000 0021                 if ((receive.analog_r >=149)&(receive.analog_r <=170))      {steering=18;}
_0xA7:
	CALL SUBOPT_0xA
	LDI  R30,LOW(149)
	LDI  R31,HIGH(149)
	CALL SUBOPT_0xB
	LDI  R30,LOW(170)
	LDI  R31,HIGH(170)
	CALL __LEW12
	AND  R30,R0
	BREQ _0xA8
	LDI  R30,LOW(18)
	MOV  R6,R30
; 0000 0022                 if ((receive.analog_r >=171)&(receive.analog_r <=190))      {steering=19;}
_0xA8:
	CALL SUBOPT_0xA
	LDI  R30,LOW(171)
	LDI  R31,HIGH(171)
	CALL SUBOPT_0xB
	LDI  R30,LOW(190)
	LDI  R31,HIGH(190)
	CALL __LEW12
	AND  R30,R0
	BREQ _0xA9
	LDI  R30,LOW(19)
	MOV  R6,R30
; 0000 0023                 if ((receive.analog_r >=191)&(receive.analog_r <=210))      {steering=20;}
_0xA9:
	CALL SUBOPT_0xA
	LDI  R30,LOW(191)
	LDI  R31,HIGH(191)
	CALL SUBOPT_0xB
	LDI  R30,LOW(210)
	LDI  R31,HIGH(210)
	CALL __LEW12
	AND  R30,R0
	BREQ _0xAA
	LDI  R30,LOW(20)
	MOV  R6,R30
; 0000 0024                 if ((receive.analog_r >=211)&(receive.analog_r <=230))      {steering=21;}
_0xAA:
	CALL SUBOPT_0xA
	LDI  R30,LOW(211)
	LDI  R31,HIGH(211)
	CALL SUBOPT_0xB
	LDI  R30,LOW(230)
	LDI  R31,HIGH(230)
	CALL __LEW12
	AND  R30,R0
	BREQ _0xAB
	LDI  R30,LOW(21)
	MOV  R6,R30
; 0000 0025                 if (receive.analog_r >=231)                                 {steering=22;}
_0xAB:
	CALL SUBOPT_0xA
	CPI  R26,LOW(0xE7)
	LDI  R30,HIGH(0xE7)
	CPC  R27,R30
	BRLT _0xAC
	LDI  R30,LOW(22)
	MOV  R6,R30
; 0000 0026                 //------------------------------------
; 0000 0027                 if ((receive.analog_r >=111)&(receive.analog_r <=127))      {steering=15;}
_0xAC:
	CALL SUBOPT_0xA
	LDI  R30,LOW(111)
	LDI  R31,HIGH(111)
	CALL SUBOPT_0xB
	LDI  R30,LOW(127)
	LDI  R31,HIGH(127)
	CALL __LEW12
	AND  R30,R0
	BREQ _0xAD
	LDI  R30,LOW(15)
	MOV  R6,R30
; 0000 0028                 if ((receive.analog_r >=91)&(receive.analog_r <=110))       {steering=14;}
_0xAD:
	CALL SUBOPT_0xA
	LDI  R30,LOW(91)
	LDI  R31,HIGH(91)
	CALL SUBOPT_0xB
	LDI  R30,LOW(110)
	LDI  R31,HIGH(110)
	CALL __LEW12
	AND  R30,R0
	BREQ _0xAE
	LDI  R30,LOW(14)
	MOV  R6,R30
; 0000 0029                 if ((receive.analog_r >=71)&(receive.analog_r <=90))        {steering=13;}
_0xAE:
	CALL SUBOPT_0xA
	LDI  R30,LOW(71)
	LDI  R31,HIGH(71)
	CALL SUBOPT_0xB
	LDI  R30,LOW(90)
	LDI  R31,HIGH(90)
	CALL __LEW12
	AND  R30,R0
	BREQ _0xAF
	LDI  R30,LOW(13)
	MOV  R6,R30
; 0000 002A                 if ((receive.analog_r >=51)&(receive.analog_r <=70))        {steering=12;}
_0xAF:
	CALL SUBOPT_0xA
	LDI  R30,LOW(51)
	LDI  R31,HIGH(51)
	CALL SUBOPT_0xB
	LDI  R30,LOW(70)
	LDI  R31,HIGH(70)
	CALL __LEW12
	AND  R30,R0
	BREQ _0xB0
	LDI  R30,LOW(12)
	MOV  R6,R30
; 0000 002B                 if ((receive.analog_r >=21)&(receive.analog_r <=50))        {steering=11;}
_0xB0:
	CALL SUBOPT_0xA
	LDI  R30,LOW(21)
	LDI  R31,HIGH(21)
	CALL SUBOPT_0xB
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	CALL __LEW12
	AND  R30,R0
	BREQ _0xB1
	LDI  R30,LOW(11)
	MOV  R6,R30
; 0000 002C                 if (receive.analog_r <=20)                                  {steering=10;}
_0xB1:
	CALL SUBOPT_0xA
	SBIW R26,21
	BRGE _0xB2
	LDI  R30,LOW(10)
	MOV  R6,R30
; 0000 002D                 if (receive.digital_r ==1)                                  {ban();}
_0xB2:
	__GETW2MN _receive,6
	SBIW R26,1
	BRNE _0xB3
	RCALL _ban
; 0000 002E         }
_0xB3:
; 0000 002F 
; 0000 0030 }
_0xA0:
	RJMP _0x9D
; 0000 0031 }
_0xB4:
	RJMP _0xB4
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_RC8:
	.BYTE 0x1
_receive:
	.BYTE 0x8
_Code_tay_cam2:
	.BYTE 0x1
_Code_tay_cam3:
	.BYTE 0x1
_Code_tay_cam4:
	.BYTE 0x1
__seed_G101:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	LD   R30,Y
	LDI  R31,0
	LDI  R26,LOW(255)
	LDI  R27,HIGH(255)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _control_motor

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x2:
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDD  R26,Y+2
	LDI  R30,LOW(255)
	SUB  R30,R26
	MOV  R26,R30
	JMP  _control_motor

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDD  R26,Y+2
	JMP  _control_motor

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4:
	SBI  0x15,1
	__DELAY_USB 13
	LDI  R30,0
	SBIC 0x13,0
	LDI  R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	ST   -Y,R26
	CBI  0x15,6
	LDD  R30,Y+1
	ORI  R30,0x20
	MOV  R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
	LD   R26,Y
	CALL _SPI_RW
	SBI  0x15,6
	__DELAY_USB 27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	CALL _RF_Write3
	LDI  R30,LOW(16)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	ST   -Y,R30
	LDI  R26,LOW(15)
	JMP  _RF_Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x9:
	LDS  R26,_receive
	LDS  R27,_receive+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 23 TIMES, CODE SIZE REDUCTION:41 WORDS
SUBOPT_0xA:
	__GETW2MN _receive,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:24 WORDS
SUBOPT_0xB:
	CALL __GEW12
	MOV  R0,R30
	RJMP SUBOPT_0xA


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__LEW12:
	CP   R30,R26
	CPC  R31,R27
	LDI  R30,1
	BRGE __LEW12T
	CLR  R30
__LEW12T:
	RET

__GEW12:
	CP   R26,R30
	CPC  R27,R31
	LDI  R30,1
	BRGE __GEW12T
	CLR  R30
__GEW12T:
	RET

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

;END OF CODE MARKER
__END_OF_CODE:
