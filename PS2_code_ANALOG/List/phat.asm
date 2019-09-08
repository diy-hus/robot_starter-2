
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Release
;Chip type              : ATmega8L
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega8L
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

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
	.EQU GICR=0x3B
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
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
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
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
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
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	RCALL __EEPROMRDD
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	.DEF _rjoyx=R5
	.DEF _rjoyy=R4
	.DEF _ljoyx=R7
	.DEF _ljoyy=R6
	.DEF _byte4=R9
	.DEF _byte5=R8
	.DEF _ready=R11
	.DEF _P_Add=R10
	.DEF _int_var=R13
	.DEF _xx=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP _ext_int0_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _timer0_ovf_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0xB5,0x0,0x0,0x0


__GLOBAL_INI_TBL:
	.DW  0x04
	.DW  0x0A
	.DW  __REG_VARS*2

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
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

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

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;#include <mega8.h>
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
;#include <string.h>
;#include "define.c"
;#define CE   PORTC.0            //   out 1
;#define SCK   PORTC.2            //   out 1
;//#define IRQ  PORTC.4
;
;/*********** PORTC ************/
;/*********** PORTD ************/
;
;#define MISO   PINC.4           //in p
;#define CSN    PORTC.1         //   out 1
;#define MOSI   PORTC.3          //   out 1
;#define IRQ     PINC.5              //in p
;//#include "NRF24L01.c"
;
;#define DATA PIND.3      //in p
;#define CMD PORTD.2      //out 1
;#define ATT PORTD.1      //out 1
;#define CLK PORTD.0      //out 1
;
;
;// Dieu khien LED
;#define Status          0x40;   // Set bit
;#define Mode_program    0x04; // Set bit
;
;
;//byte nhan Tay cam
;#define Select  1 // nut Select Byte 4.0
;#define L3      2 // nut Select Byte 4.1
;#define R3      4 // nut Select Byte 4.2
;#define Start   8 // nut Select Byte 4.3
;#define Up      16 // nut Select Byte 4.4
;#define Right   32 // nut Select Byte 4.5
;#define Down    64 // nut Select Byte 4.6
;#define Left    128 // nut Select Byte 4.7
;
;#define L2      1 // nut Select Byte 5.0
;#define R2      2 // nut Select Byte 5.1
;#define L1      4 // nut Select Byte 5.2
;#define R1      8 // nut Select Byte 5.3
;#define Tamgiac 16 // nut Select Byte 5.4
;#define Tron    32 // nut Select Byte 5.5
;#define Nhan    64 // nut Select Byte 5.6
;#define Vuong   128 // nut Select Byte 5.7
;#include "giai_ma_ps.c"
;unsigned char rjoyx,rjoyy,ljoyx,ljoyy,byte4,byte5;
;unsigned char access(unsigned char tbyte);
;unsigned char ready=0;
;void read_data(void);
;//Gamepad PS2
;unsigned char access(unsigned char tbyte)
; 0000 0006 {

	.CSEG
_access:
; .FSTART _access
;unsigned char rbyte=0;
;unsigned char i;
;CMD = 1;
	ST   -Y,R26
	RCALL __SAVELOCR2
;	tbyte -> Y+2
;	rbyte -> R17
;	i -> R16
	LDI  R17,0
	SBI  0x12,2
;CLK = 1;
	SBI  0x12,0
;for(i=0;i<8;i++)
	LDI  R16,LOW(0)
_0x8:
	CPI  R16,8
	BRSH _0x9
;{
;    CMD=tbyte&0x01;
	LDD  R30,Y+2
	ANDI R30,LOW(0x1)
	BRNE _0xA
	CBI  0x12,2
	RJMP _0xB
_0xA:
	SBI  0x12,2
_0xB:
;    delay_us(50);
	__DELAY_USB 133
;    CLK=0;
	CBI  0x12,0
;    delay_us(50);
	__DELAY_USB 133
;    rbyte=(rbyte>>1)|(DATA<<7);
	MOV  R30,R17
	LSR  R30
	MOV  R0,R30
	LDI  R26,0
	SBIC 0x10,3
	LDI  R26,1
	MOV  R30,R26
	ROR  R30
	LDI  R30,0
	ROR  R30
	OR   R30,R0
	MOV  R17,R30
;    CLK=1;
	SBI  0x12,0
;    tbyte=tbyte>>1;
	LDD  R30,Y+2
	LSR  R30
	STD  Y+2,R30
;}
	SUBI R16,-1
	RJMP _0x8
_0x9:
;delay_us(100);
	__DELAY_USW 200
;return rbyte;
	MOV  R30,R17
	RCALL __LOADLOCR2
	ADIW R28,3
	RET
;}
; .FEND
;
;
;void read_data(void)
;{
_read_data:
; .FSTART _read_data
;//rjoyx=rjoyy=ljoyx=ljoyy=128;
;ATT=0;               // Enable Joytick
	RCALL SUBOPT_0x0
;access(0x01);       // >> dua ma 0x01 vao Joytick
;access(0x42);      // >> dua ma 0x42 vao Joytick
	LDI  R26,LOW(66)
	RCALL SUBOPT_0x1
;access(0);
	RCALL SUBOPT_0x1
;byte4   =   access(0);
	RCALL _access
	MOV  R9,R30
;byte5   =   access(0);
	RCALL SUBOPT_0x2
	MOV  R8,R30
;rjoyx   =   access(0);
	RCALL SUBOPT_0x2
	MOV  R5,R30
;rjoyy   =   access(0);
	RCALL SUBOPT_0x2
	MOV  R4,R30
;ljoyx   =   access(0);
	RCALL SUBOPT_0x2
	MOV  R7,R30
;ljoyy   =   access(0);
	RCALL SUBOPT_0x2
	MOV  R6,R30
;CMD=0;
	CBI  0x12,2
;ATT=1;
	SBI  0x12,1
;}
	RET
; .FEND
;void reset_status(void)
;{
_reset_status:
; .FSTART _reset_status
;    byte4 = byte5 = 0xFF;
	LDI  R30,LOW(255)
	MOV  R8,R30
	MOV  R9,R30
;    rjoyx = rjoyy = ljoyx = ljoyy = 128;
	LDI  R30,LOW(128)
	MOV  R6,R30
	MOV  R7,R30
	MOV  R4,R30
	MOV  R5,R30
;}
	RET
; .FEND
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;{   //TCNT0=0xDB; // tao tan so 300Hz
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;       TCNT0=0x90; //B8 tao tan so 150Hz
	LDI  R30,LOW(144)
	OUT  0x32,R30
;
;   // TCNT2=0xDB; // tao tan so 300Hz
;   if (ready==1)
	LDI  R30,LOW(1)
	CP   R30,R11
	BRNE _0x16
;        read_data();
	RCALL _read_data
;// Place your code here
;
;}
_0x16:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;void enter_config()
;{
_enter_config:
; .FSTART _enter_config
;ATT=0;               // Enable Joytick
	RCALL SUBOPT_0x0
;access(0x01);       // >> dua ma 0x01 vao Joytick
;access(0x43);      // >> dua ma 0x42 vao Joytick
	LDI  R26,LOW(67)
	RCALL SUBOPT_0x1
;access(0x00);
	RCALL _access
;access(0x01);
	LDI  R26,LOW(1)
	RJMP _0x2060004
;access(0x00);
;
;CMD=0;
;delay_ms(1);
;ATT=1;
;delay_ms(10);
;}
; .FEND
;void exit_config()
;{
_exit_config:
; .FSTART _exit_config
;ATT=0;               // Enable Joytick
	RCALL SUBOPT_0x0
;access(0x01);       // >> dua ma 0x01 vao Joytick
;access(0x43);      // >> dua ma 0x42 vao Joytick
	LDI  R26,LOW(67)
	RCALL SUBOPT_0x1
;access(0x00);
	RCALL SUBOPT_0x1
;access(0x00);
	RCALL SUBOPT_0x3
;access(0x5A);
	RCALL SUBOPT_0x3
;access(0x5A);
	RCALL SUBOPT_0x3
;access(0x5A);
	RCALL SUBOPT_0x3
;access(0x5A);
	RCALL SUBOPT_0x3
;access(0x5A);
	RJMP _0x2060003
;CMD=0;
;delay_ms(1);
;ATT=1;
;delay_ms(10);
;}
; .FEND
;void change_analog()
;{
_change_analog:
; .FSTART _change_analog
;ATT=0;               // Enable Joytick
	RCALL SUBOPT_0x0
;access(0x01);       // >> dua ma 0x01 vao Joytick
;access(0x44);
	LDI  R26,LOW(68)
	RCALL SUBOPT_0x1
;access(0x00);      // >> dua ma 0x42 vao Joytick
	RCALL _access
;access(0x01);
	LDI  R26,LOW(1)
	RCALL _access
;access(0x03);
	LDI  R26,LOW(3)
	RCALL SUBOPT_0x1
;access(0x00);
	RCALL SUBOPT_0x1
;access(0x00);
	RCALL SUBOPT_0x1
;access(0x00);
_0x2060004:
	RCALL _access
;access(0x00);
	LDI  R26,LOW(0)
_0x2060003:
	RCALL _access
;CMD=0;
	CBI  0x12,2
;delay_ms(1);
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x4
;ATT=1;
	SBI  0x12,1
;delay_ms(10);
	LDI  R26,LOW(10)
	RCALL SUBOPT_0x4
;}
	RET
; .FEND
;char P_Add = 0xB5;         // dia chi cua tay cam ( cam giong voi dia chi cua robot)
;#include "nrf_code.c"
;unsigned char SPI_RW(unsigned char Buff);                                       //Function used for text moving
;void RF_Init();
;void RF_Write(unsigned char Reg_Add, unsigned char Value);
;void RF_Write_Address(unsigned char Address);
;void RX_Mode_Active();
;void TX_Mode_Active();
;void RF_Config();
;void RF_TX_send(unsigned char RX_Address, unsigned char Value);
;
;unsigned char SPI_RW(unsigned char Buff)
; 0000 0008 {
_SPI_RW:
; .FSTART _SPI_RW
;    unsigned char bit_ctr;
;       for(bit_ctr=0;bit_ctr<8;bit_ctr++) // output 8-bit
	ST   -Y,R26
	ST   -Y,R17
;	Buff -> Y+1
;	bit_ctr -> R17
	LDI  R17,LOW(0)
_0x2A:
	CPI  R17,8
	BRSH _0x2B
;       {
;        MOSI = (Buff & 0x80);         // output 'uchar', MSB to MOSI
	LDD  R30,Y+1
	ANDI R30,LOW(0x80)
	BRNE _0x2C
	CBI  0x15,3
	RJMP _0x2D
_0x2C:
	SBI  0x15,3
_0x2D:
;        delay_us(5);
	__DELAY_USB 13
;        Buff = (Buff << 1);           // shift next bit into MSB..
	LDD  R30,Y+1
	LSL  R30
	STD  Y+1,R30
;        SCK = 1;                      // Set SCK high..
	SBI  0x15,2
;        delay_us(5);
	__DELAY_USB 13
;        Buff |= MISO;                 // capture current MISO bit
	LDI  R30,0
	SBIC 0x13,4
	LDI  R30,1
	LDD  R26,Y+1
	OR   R30,R26
	STD  Y+1,R30
;        SCK = 0;                      // ..then set SCK low again
	CBI  0x15,2
;       }
	SUBI R17,-1
	RJMP _0x2A
_0x2B:
;    return(Buff);                     // return read uchar
	LDD  R30,Y+1
	LDD  R17,Y+0
	RJMP _0x2060001
;}
; .FEND
;
;void RF_Init()                                                    //Function allow to Initialize RF device
;{
_RF_Init:
; .FSTART _RF_Init
;    CE=1;
	SBI  0x15,0
;    delay_us(700);
	__DELAY_USW 1400
;    CE=0;
	CBI  0x15,0
;    CSN=1;
	SBI  0x15,1
;}
	RET
; .FEND
;void RF_Write(unsigned char Reg_Add, unsigned char Value)         //Function to write a value to a register address
;{
_RF_Write:
; .FSTART _RF_Write
;    CSN=0;
	ST   -Y,R26
;	Reg_Add -> Y+1
;	Value -> Y+0
	CBI  0x15,1
;    SPI_RW(0b00100000|Reg_Add);
	LDD  R30,Y+1
	ORI  R30,0x20
	MOV  R26,R30
	RCALL SUBOPT_0x5
;    SPI_RW(Value);
;    CSN=1;
	RCALL SUBOPT_0x6
;    delay_us(10);
;}
	RJMP _0x2060001
; .FEND
;void RF_Write_Address(unsigned char Address)                      //Function to write TX and RX address
;{
_RF_Write_Address:
; .FSTART _RF_Write_Address
;    CSN=0;
	ST   -Y,R26
;	Address -> Y+0
	CBI  0x15,1
;    RF_Write(0x03,0b00000011);
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R26,LOW(3)
	RCALL _RF_Write
;    CSN=1;
	RCALL SUBOPT_0x6
;    delay_us(10);
;    CSN=0;
	CBI  0x15,1
;    SPI_RW(0b00100000|0x0A);
	LDI  R26,LOW(42)
	RCALL SUBOPT_0x5
;    SPI_RW(Address);
;    SPI_RW(Address);
	RCALL SUBOPT_0x7
;    SPI_RW(Address);
;    SPI_RW(Address);
	RCALL SUBOPT_0x7
;    SPI_RW(Address);
;    CSN=1;
	RCALL SUBOPT_0x6
;    delay_us(10);
;    CSN=0;
	CBI  0x15,1
;    SPI_RW(0b00100000|0x10);
	LDI  R26,LOW(48)
	RCALL SUBOPT_0x5
;    SPI_RW(Address);
;    SPI_RW(Address);
	RCALL SUBOPT_0x7
;    SPI_RW(Address);
;    SPI_RW(Address);
	RCALL SUBOPT_0x7
;    SPI_RW(Address);
;    CSN=1;
	RCALL SUBOPT_0x6
;    delay_us(10);
;}
	ADIW R28,1
	RET
; .FEND
;
;void RX_Mode_Active()                                             //Function to put nRF in RX mode
;{
_RX_Mode_Active:
; .FSTART _RX_Mode_Active
;    RF_Write(0x00,0b00011111);     //CONFIG 0x00
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(31)
	RCALL _RF_Write
;    CE=1;
	SBI  0x15,0
;}
	RET
; .FEND
;void TX_Mode_Active()                                             //Function to put nRF in TX mode
;{
_TX_Mode_Active:
; .FSTART _TX_Mode_Active
;    CE=0;
	CBI  0x15,0
;    RF_Write(0x00,0b00011110);     //CONFIG 0x00
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(30)
	RJMP _0x2060002
;}
; .FEND
;
;void RF_Config()                                                  //Function to config the nRF
;{
_RF_Config:
; .FSTART _RF_Config
;delay_us(10);
	__DELAY_USB 27
;RF_Write(0x00,0b00011111);     //CONFIG 0x00
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(31)
	RCALL _RF_Write
;delay_ms(2);
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x4
;RF_Write(0x07,0b01111110);
	RCALL SUBOPT_0x8
;RF_Write(0x11,0b00000001);     //RX_PW_P0 0x11     Payload size
	LDI  R30,LOW(17)
	RCALL SUBOPT_0x9
;RF_Write(0x05,0b00000010);     //RF_CH 0x05        Choose frequency channel
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDI  R26,LOW(2)
	RCALL _RF_Write
;RF_Write_Address(P_Add);
	MOV  R26,R10
	RCALL _RF_Write_Address
;RF_Write(0x02,0b00000001);     //EX_RXADDR 0x02    enable data pipe 0;
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x9
;RF_Write(0x01,0b00000001);     //EN_AA 0x01        enable auto-acknowledgment
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x9
;RF_Write(0x04,0b00000000);     //SETUP_RETR 0x04   Setup retry time
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R26,LOW(0)
_0x2060002:
	RCALL _RF_Write
;}
	RET
; .FEND
;void RF_TX_send(unsigned char RX_Address, unsigned char Value)     //Function to send data Value to a specify RX Address
;{
_RF_TX_send:
; .FSTART _RF_TX_send
; {
	ST   -Y,R26
;	RX_Address -> Y+1
;	Value -> Y+0
;  RF_Write_Address(RX_Address);
	LDD  R26,Y+1
	RCALL _RF_Write_Address
;  CSN=1;
	RCALL SUBOPT_0x6
;  delay_us(10);
;  CSN=0;
	CBI  0x15,1
;  SPI_RW(0b11100001);
	LDI  R26,LOW(225)
	RCALL _SPI_RW
;  CSN=1;
	RCALL SUBOPT_0x6
;  delay_us(10);
;  CSN=0;
	CBI  0x15,1
;  SPI_RW(0b10100000);
	LDI  R26,LOW(160)
	RCALL SUBOPT_0x5
;  SPI_RW(Value);
;  CSN=1;
	SBI  0x15,1
;  CE=1;
	SBI  0x15,0
;  delay_us(500);
	__DELAY_USW 1000
;  CE=0;
	CBI  0x15,0
;  RF_Write(0x07,0b01111110);
	RCALL SUBOPT_0x8
;  RF_Write_Address(P_Add);
	MOV  R26,R10
	RCALL _RF_Write_Address
;  }
;}
_0x2060001:
	ADIW R28,2
	RET
; .FEND
;
;#include "khoi_tao.c"
;void init_systeam (void);
;
;void init_systeam (void)
; 0000 0009 {
_init_systeam:
; .FSTART _init_systeam
;// Declare your local variables here
;
;// Input/Output Ports initialization
;// Port B initialization
;// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
;DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;
;// Port C initialization
;// Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;// State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;PORTC=0b00111111;
	LDI  R30,LOW(63)
	OUT  0x15,R30
;DDRC=0b00001111;
	LDI  R30,LOW(15)
	OUT  0x14,R30
;
;// Port D initialization
;// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;PORTD=0xFF;
	LDI  R30,LOW(255)
	OUT  0x12,R30
;DDRD=0b00000111;
	LDI  R30,LOW(7)
	OUT  0x11,R30
;
;// Timer/Counter 0 initialization
;// Clock source: System Clock
;// Clock value: 7.813 kHz
;TCCR0=0x05;
	LDI  R30,LOW(5)
	OUT  0x33,R30
;TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
;
;// Timer(s)/Counter(s) Interrupt(s) initialization
;TIMSK=0x01;
	LDI  R30,LOW(1)
	OUT  0x39,R30
;
;// USART initialization
;// USART disabled
;UCSRB=0x00;
	LDI  R30,LOW(0)
	OUT  0xA,R30
;
;// Analog Comparator initialization
;// Analog Comparator: Off
;// Analog Comparator Input Capture by Timer/Counter 1: Off
;ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
;
;// ADC initialization
;// ADC disabled
;ADCSRA=0x00;
	OUT  0x6,R30
;
;// SPI initialization
;// SPI disabled
;SPCR=0x00;
	OUT  0xD,R30
;// External Interrupt(s) initialization
;// INT0: On
;// INT0 Mode: Falling Edge
;// INT1: Off
;GICR|=0x40;
	IN   R30,0x3B
	ORI  R30,0x40
	OUT  0x3B,R30
;MCUCR=0x02;
	LDI  R30,LOW(2)
	OUT  0x35,R30
;GIFR=0x40;
	LDI  R30,LOW(64)
	OUT  0x3A,R30
;
;// TWI initialization
;// TWI disabled
;TWCR=0x00;
	LDI  R30,LOW(0)
	OUT  0x36,R30
;#asm("sei")
	sei
;
;
;}
	RET
; .FEND
; char int_var=0;
;
; unsigned char xx=0;
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 000E {  int_var=1; }
_ext_int0_isr:
; .FSTART _ext_int0_isr
	ST   -Y,R30
	LDI  R30,LOW(1)
	MOV  R13,R30
	LD   R30,Y+
	RETI
; .FEND
;
;void main(void)
; 0000 0011 {
_main:
; .FSTART _main
; 0000 0012 init_systeam();
	RCALL _init_systeam
; 0000 0013  ready=0;
	CLR  R11
; 0000 0014  reset_status();
	RCALL _reset_status
; 0000 0015  RF_Init();
	RCALL _RF_Init
; 0000 0016  RF_Config();
	RCALL _RF_Config
; 0000 0017  RX_Mode_Active();
	RCALL _RX_Mode_Active
; 0000 0018  reset_status();
	RCALL _reset_status
; 0000 0019  enter_config();
	RCALL _enter_config
; 0000 001A  change_analog();
	RCALL _change_analog
; 0000 001B  exit_config();
	RCALL _exit_config
; 0000 001C  ready=1;
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 001D while (1)
_0x5A:
; 0000 001E   {
; 0000 001F   TX_Mode_Active();
	RCALL _TX_Mode_Active
; 0000 0020 	   if(ljoyy<80)				             {xx=1;}  // trai len
	LDI  R30,LOW(80)
	CP   R6,R30
	BRSH _0x5D
	LDI  R30,LOW(1)
	MOV  R12,R30
; 0000 0021   else if(ljoyy>170)   				         {xx=2;}  // trai xuong
	RJMP _0x5E
_0x5D:
	LDI  R30,LOW(170)
	CP   R30,R6
	BRSH _0x5F
	LDI  R30,LOW(2)
	MOV  R12,R30
; 0000 0022   else if(ljoyx<80)          				 {xx=3;}  // trai sang trai
	RJMP _0x60
_0x5F:
	LDI  R30,LOW(80)
	CP   R7,R30
	BRSH _0x61
	LDI  R30,LOW(3)
	MOV  R12,R30
; 0000 0023   else if(ljoyx>170)       					 {xx=4;}  // trai sang phai
	RJMP _0x62
_0x61:
	LDI  R30,LOW(170)
	CP   R30,R7
	BRSH _0x63
	LDI  R30,LOW(4)
	MOV  R12,R30
; 0000 0024   else if(rjoyy<80)  				         {xx=5;}  // phai tien
	RJMP _0x64
_0x63:
	LDI  R30,LOW(80)
	CP   R4,R30
	BRSH _0x65
	LDI  R30,LOW(5)
	MOV  R12,R30
; 0000 0025   else if(rjoyy>170) 			             {xx=6;}  // phai lui
	RJMP _0x66
_0x65:
	LDI  R30,LOW(170)
	CP   R30,R4
	BRSH _0x67
	LDI  R30,LOW(6)
	MOV  R12,R30
; 0000 0026   else if(rjoyx<80)     				     {xx=7;}  // phai trai
	RJMP _0x68
_0x67:
	LDI  R30,LOW(80)
	CP   R5,R30
	BRSH _0x69
	LDI  R30,LOW(7)
	MOV  R12,R30
; 0000 0027   else if(rjoyx>170)        				 {xx=8;}  // phai phai
	RJMP _0x6A
_0x69:
	LDI  R30,LOW(170)
	CP   R30,R5
	BRSH _0x6B
	LDI  R30,LOW(8)
	MOV  R12,R30
; 0000 0028   else if((byte4&Up) == 0)                   {xx=9;}
	RJMP _0x6C
_0x6B:
	SBRC R9,4
	RJMP _0x6D
	LDI  R30,LOW(9)
	MOV  R12,R30
; 0000 0029   else if((byte4&Left) == 0)                 {xx=10;}
	RJMP _0x6E
_0x6D:
	SBRC R9,7
	RJMP _0x6F
	LDI  R30,LOW(10)
	MOV  R12,R30
; 0000 002A   else if((byte4&Down) == 0)                 {xx=11;}
	RJMP _0x70
_0x6F:
	SBRC R9,6
	RJMP _0x71
	LDI  R30,LOW(11)
	MOV  R12,R30
; 0000 002B   else if((byte4&Right) == 0)                {xx=12;}
	RJMP _0x72
_0x71:
	SBRC R9,5
	RJMP _0x73
	LDI  R30,LOW(12)
	MOV  R12,R30
; 0000 002C   else if((byte5&Tamgiac) == 0)              {xx=13;}
	RJMP _0x74
_0x73:
	SBRC R8,4
	RJMP _0x75
	LDI  R30,LOW(13)
	MOV  R12,R30
; 0000 002D   else if((byte5&Tron) == 0)                 {xx=14;}
	RJMP _0x76
_0x75:
	SBRC R8,5
	RJMP _0x77
	LDI  R30,LOW(14)
	MOV  R12,R30
; 0000 002E   else if((byte5&Nhan) == 0)                 {xx=15;}
	RJMP _0x78
_0x77:
	SBRC R8,6
	RJMP _0x79
	LDI  R30,LOW(15)
	MOV  R12,R30
; 0000 002F   else if((byte5&Vuong) == 0)                {xx=16;}
	RJMP _0x7A
_0x79:
	SBRC R8,7
	RJMP _0x7B
	LDI  R30,LOW(16)
	MOV  R12,R30
; 0000 0030   else if((byte5&L1) == 0)                   {xx=17;}
	RJMP _0x7C
_0x7B:
	SBRC R8,2
	RJMP _0x7D
	LDI  R30,LOW(17)
	MOV  R12,R30
; 0000 0031   else if((byte5&R1) == 0)                   {xx=18;}
	RJMP _0x7E
_0x7D:
	SBRC R8,3
	RJMP _0x7F
	LDI  R30,LOW(18)
	MOV  R12,R30
; 0000 0032   else if((byte5&L2) == 0)                   {xx=19;}
	RJMP _0x80
_0x7F:
	SBRC R8,0
	RJMP _0x81
	LDI  R30,LOW(19)
	MOV  R12,R30
; 0000 0033   else if((byte5&R2) == 0)                   {xx=20;}
	RJMP _0x82
_0x81:
	SBRC R8,1
	RJMP _0x83
	LDI  R30,LOW(20)
	MOV  R12,R30
; 0000 0034   else if((byte4&Select) == 0)               {xx=21;}
	RJMP _0x84
_0x83:
	SBRC R9,0
	RJMP _0x85
	LDI  R30,LOW(21)
	MOV  R12,R30
; 0000 0035   else if((byte4&L3) == 0)                   {xx=22;}
	RJMP _0x86
_0x85:
	SBRC R9,1
	RJMP _0x87
	LDI  R30,LOW(22)
	MOV  R12,R30
; 0000 0036   else if((byte4&R3) == 0)                   {xx=23;}
	RJMP _0x88
_0x87:
	SBRC R9,2
	RJMP _0x89
	LDI  R30,LOW(23)
	MOV  R12,R30
; 0000 0037   else if((byte4&Start) == 0)                {xx=24;}
	RJMP _0x8A
_0x89:
	SBRC R9,3
	RJMP _0x8B
	LDI  R30,LOW(24)
	MOV  R12,R30
; 0000 0038   else                                       {xx=0;}
	RJMP _0x8C
_0x8B:
	CLR  R12
_0x8C:
_0x8A:
_0x88:
_0x86:
_0x84:
_0x82:
_0x80:
_0x7E:
_0x7C:
_0x7A:
_0x78:
_0x76:
_0x74:
_0x72:
_0x70:
_0x6E:
_0x6C:
_0x6A:
_0x68:
_0x66:
_0x64:
_0x62:
_0x60:
_0x5E:
; 0000 0039   RF_TX_send(P_Add,xx);   // ham gui ma lenh
	ST   -Y,R10
	MOV  R26,R12
	RCALL _RF_TX_send
; 0000 003A   delay_ms(1);
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x4
; 0000 003B     }
	RJMP _0x5A
; 0000 003C   }
_0x8D:
	RJMP _0x8D
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

	.CSEG

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x0:
	CBI  0x12,1
	LDI  R26,LOW(1)
	RJMP _access

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1:
	RCALL _access
	LDI  R26,LOW(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(0)
	RJMP _access

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3:
	RCALL _access
	LDI  R26,LOW(90)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x5:
	RCALL _SPI_RW
	LD   R26,Y
	RJMP _SPI_RW

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x6:
	SBI  0x15,1
	__DELAY_USB 27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	LD   R26,Y
	RJMP SUBOPT_0x5

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R26,LOW(126)
	RJMP _RF_Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x9:
	ST   -Y,R30
	LDI  R26,LOW(1)
	RJMP _RF_Write


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

__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
