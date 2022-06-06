; SNES SPC700 Tutorial code
 ; (originally by Joe Lee)
 ; This code is in the public domain.
 
.include "hdr.asm"

.MACRO Snes_Init
 	sei 	 	; Disabled interrupts
 	clc 	 	; clear carry to switch to native mode
 	xce 	 	; Xchange carry & emulation bit. native mode
 	rep 	#$18 	; Binary mode (decimal mode off), X/Y 16 bit
         ldx 	#$1FFF  ; set stack to $1FFF
         txs
 
         jsr Init
 .ENDM

 .bank 0
 .section "Snes_Init" SEMIFREE
 Init:
 	sep 	#$30    ; X,Y,A are 8 bit numbers
 	lda 	#$8F    ; screen off, full brightness
 	sta 	$2100   ; brightness + screen enable register 
 	stz 	$2101   ; Sprite register (size + address in VRAM) 
 	stz 	$2102   ; Sprite registers (address of sprite memory [OAM])
 	stz 	$2103   ;    ""                       ""
 	stz 	$2105   ; Mode 0, = Graphic mode register
 	stz 	$2106   ; noplanes, no mosaic, = Mosaic register
 	stz 	$2107   ; Plane 0 map VRAM location
 	stz 	$2108   ; Plane 1 map VRAM location
 	stz 	$2109   ; Plane 2 map VRAM location
 	stz 	$210A   ; Plane 3 map VRAM location
 	stz 	$210B   ; Plane 0+1 Tile data location
 	stz 	$210C   ; Plane 2+3 Tile data location
 	stz 	$210D   ; Plane 0 scroll x (first 8 bits)
 	stz 	$210D   ; Plane 0 scroll x (last 3 bits) #$0 - #$07ff
 	lda 	#$FF    ; The top pixel drawn on the screen isn't the top one in the tilemap, it's the one above that.
 	sta 	$210E   ; Plane 0 scroll y (first 8 bits)
 	sta 	$2110   ; Plane 1 scroll y (first 8 bits)
 	sta 	$2112   ; Plane 2 scroll y (first 8 bits)
 	sta 	$2114   ; Plane 3 scroll y (first 8 bits)
 	lda 	#$07    ; Since this could get quite annoying, it's better to edit the scrolling registers to fix this.
 	sta 	$210E   ; Plane 0 scroll y (last 3 bits) #$0 - #$07ff
 	sta 	$2110   ; Plane 1 scroll y (last 3 bits) #$0 - #$07ff
 	sta 	$2112   ; Plane 2 scroll y (last 3 bits) #$0 - #$07ff
 	sta 	$2114   ; Plane 3 scroll y (last 3 bits) #$0 - #$07ff
 	stz 	$210F   ; Plane 1 scroll x (first 8 bits)
 	stz 	$210F   ; Plane 1 scroll x (last 3 bits) #$0 - #$07ff
 	stz 	$2111   ; Plane 2 scroll x (first 8 bits)
 	stz 	$2111   ; Plane 2 scroll x (last 3 bits) #$0 - #$07ff
 	stz 	$2113   ; Plane 3 scroll x (first 8 bits)
 	stz 	$2113   ; Plane 3 scroll x (last 3 bits) #$0 - #$07ff
 	lda 	#$80    ; increase VRAM address after writing to $2119
 	sta 	$2115   ; VRAM address increment register
 	stz 	$2116   ; VRAM address low
 	stz 	$2117   ; VRAM address high
 	stz 	$211A   ; Initial Mode 7 setting register
 	stz 	$211B   ; Mode 7 matrix parameter A register (low)
 	lda 	#$01
 	sta 	$211B   ; Mode 7 matrix parameter A register (high)
 	stz 	$211C   ; Mode 7 matrix parameter B register (low)
 	stz 	$211C   ; Mode 7 matrix parameter B register (high)
 	stz 	$211D   ; Mode 7 matrix parameter C register (low)
 	stz 	$211D   ; Mode 7 matrix parameter C register (high)
 	stz 	$211E   ; Mode 7 matrix parameter D register (low)
 	sta 	$211E   ; Mode 7 matrix parameter D register (high)
 	stz 	$211F   ; Mode 7 center position X register (low)
 	stz 	$211F   ; Mode 7 center position X register (high)
 	stz 	$2120   ; Mode 7 center position Y register (low)
 	stz 	$2120   ; Mode 7 center position Y register (high)
 	stz 	$2121   ; Color number register ($0-ff)
 	stz 	$2123   ; BG1 & BG2 Window mask setting register
 	stz 	$2124   ; BG3 & BG4 Window mask setting register
 	stz 	$2125   ; OBJ & Color Window mask setting register
 	stz 	$2126   ; Window 1 left position register
 	stz 	$2127   ; Window 2 left position register
 	stz 	$2128   ; Window 3 left position register
 	stz 	$2129   ; Window 4 left position register
 	stz 	$212A   ; BG1, BG2, BG3, BG4 Window Logic register
 	stz 	$212B   ; OBJ, Color Window Logic Register (or,and,xor,xnor)
 	sta 	$212C   ; Main Screen designation (planes, sprites enable)
 	stz 	$212D   ; Sub Screen designation
 	stz 	$212E   ; Window mask for Main Screen
 	stz 	$212F   ; Window mask for Sub Screen
 	lda 	#$30
 	sta 	$2130   ; Color addition & screen addition init setting
 	stz 	$2131   ; Add/Sub sub designation for screen, sprite, color
 	lda 	#$E0
 	sta 	$2132   ; color data for addition/subtraction
 	stz 	$2133   ; Screen setting (interlace x,y/enable SFX data)
 	stz 	$4200   ; Enable V-blank, interrupt, Joypad register
 	lda 	#$FF
 	sta 	$4201   ; Programmable I/O port
 	stz 	$4202   ; Multiplicand A
 	stz 	$4203   ; Multiplier B
 	stz 	$4204   ; Multiplier C
 	stz 	$4205   ; Multiplicand C
 	stz 	$4206   ; Divisor B
 	stz 	$4207   ; Horizontal Count Timer
 	stz 	$4208   ; Horizontal Count Timer MSB (most significant bit)
 	stz 	$4209   ; Vertical Count Timer
 	stz 	$420A   ; Vertical Count Timer MSB
 	stz 	$420B   ; General DMA enable (bits 0-7)
 	stz 	$420C   ; Horizontal DMA (HDMA) enable (bits 0-7)
 	stz 	$420D	; Access cycle designation (slow/fast rom)
 	cli 	 	; Enable interrupts
 	rts
 .ends

 ; These definitions are needed to satisfy some lines in "Snes_Init.asm".
 .define BG1MoveH $7E1A25
 .define BG1MoveV $7E1A26
 .define BG2MoveH $7E1A27
 .define BG2MoveV $7E1A28
 .define BG3MoveH $7E1A29
 .define BG3MoveV $7E1A2A
 
 ; Needed to satisfy interrupt definition in "Header.inc".
 VBlank:
   rti
 
 .define AUDIO_R0 $2140
 .define AUDIO_R1 $2141
 .define AUDIO_R2 $2142
 .define AUDIO_R3 $2143
 
 .define XY_8BIT $10
 .define A_8BIT  $20
 
 .define musicSourceAddr $00fd
 
 ; The SPC file from which we read our data.
 .define spcFile "turtlepower.spc"
 
 ; The address in SPC RAM where we put our 15-byte startup routine.
 .define spcFreeAddr $ffa0
 
 ; The first half of the saved SPC RAM from the SPC file.
 .bank 1
 .section "musicData1"
 spcMemory1: .incbin spcFile skip $00100 read $8000
 .ends
 
 ; The second half of the saved SPC RAM from the SPC file.
 .bank 2
 .section "musicData2"
 spcMemory2: .incbin spcFile skip $08100 read $8000
 .ends
 
 .bank 0
 .section "MainCode"
 
 ; The rest of the saved SPC state from the SPC file.
 dspData:  .incbin spcFile skip $10100 read $0080
 audioPC:  .incbin spcFile skip $00025 read $0002
 audioA:   .incbin spcFile skip $00027 read $0001
 audioX:   .incbin spcFile skip $00028 read $0001
 audioY:   .incbin spcFile skip $00029 read $0001
 audioPSW: .incbin spcFile skip $0002a read $0001
 audioSP:  .incbin spcFile skip $0002b read $0001
 
 Start:
     ; Initialize the SNES.
     Snes_Init
 
     jsr LoadSPC
 
     ; Set the background color to green.
     sep     #$20        ; Set the A register to 8-bit.
     lda     #%10000000  ; Force VBlank and set brightness to 0%.
     sta     $2100
     lda     #%11100000  ; Load the low byte of the green background color.
     sta     $2122
     lda     #%00000000  ; Load the high byte of the green background color.
     sta     $2122
     lda     #%00001111  ; End VBlank, setting brightness to 100%.
     sta     $2100
 
     ; Loop forever.
 Forever:
     jmp Forever
 
 .macro sendMusicBlockM ; srcSeg srcAddr destAddr len
     ; Store the source address \1:\2 in musicSourceAddr.
     sep     #A_8BIT
     lda     #\1
     sta     musicSourceAddr + 2
     rep     #A_8BIT
     lda     #\2
     sta     musicSourceAddr
 
     ; Store the destination address in x.
     ; Store the length in y.
     rep     #XY_8BIT
     ldx     #\3
     ldy     #\4
     jsr     CopyBlockToSPC
 .endm
 
 .macro startSPCExecM ; startAddr
     rep     #XY_8BIT
     ldx     #\1
     jsr     StartSPCExec
 .endm
 
 LoadSPC:
     jsr     CopySPCMemoryToRam
 
     stz     $4200   ; Disable NMI
     sei             ; Disable IRQ
 
     ; Copy RAM between 0x0002 and 0xffc0.
     sendMusicBlockM $7f $0002 $0002 $ffbe
 
     ; Build code to initialize registers.
     jsr     MakeSPCInitCode
 
     ; Copy init code to some region of SPC memory that we hope isn't in use.
     sendMusicBlockM $7f $0000 spcFreeAddr $0016
 
     ; Initialize DSP registers.
     jsr     InitDSP
 
     ; Start SPC execution at init code region.
     startSPCExecM spcFreeAddr
 
     cli             ; Enable IRQ
     sep     #A_8BIT ; Enable NMI
     lda     #$80
     sta     $4200
 
     rts
 
 CopySPCMemoryToRam:
     ; Copy music data from ROM to RAM, from the end backwards.
     rep   #XY_8BIT        ; xy in 16-bit mode.
     ldx.w #$7fff           ; Set counter to 32k-1.
 -   lda.l spcMemory1,x     ; Copy byte from first music bank.
     sta.l $7f0000,x
     lda.l spcMemory2,x     ; Copy byte from second music bank.
     sta.l $7f8000,x
     dex
     bpl -
     rts
 
 InitDSP:
     rep     #XY_8BIT            ; x and y in 16-bit mode
     ldx     #$0000              ; Reset DSP address counter.
 -
     sep     #A_8BIT
     txa                         ; Write DSP address register byte.
     sta     $7f0100             
     lda.l   dspData,x           ; Write DSP data register byte.
     sta     $7f0101             
     phx                         ; Save x on the stack.
 
     ; Send the address and data bytes to the DSP memory-mapped registers.
     sendMusicBlockM $7f $0100 $00f2 $0002
 
     rep     #XY_8BIT            ; Restore x.
     plx
 
     ; Loop if we haven't done 128 registers yet.
     inx
     cpx     #$0080
     bne     -
     rts
 
 MakeSPCInitCode:
     ; Constructs SPC700 code to restore the remaining SPC state and start
     ; execution.
 
     ; The code we want to construct:
     ; Move 00 byte to 00.
     ; Move 01 byte to 01.
     ; Move s value into s.
     ; Push PSW value.
     ; Move a value into a.
     ; Move x value into x.
     ; Move y value into y.
     ; Pull PSW value.
     ; Jump to saved program counter location.
 
     sep     #A_8BIT
 
     ; Push [01] value to stack.
     lda.l   $7f0001
     pha
 
     ; Push [00] value to stack.
     lda.l   $7f0000
     pha
 
     ; Write code to set [00] byte.
     lda     #$8f        ; mov dp,#imm
     sta.l   $7f0000
     pla
     sta.l   $7f0001
     lda     #$00
     sta.l   $7f0002
 
     ; Write code to set [01] byte.
     lda     #$8f        ; mov dp,#imm
     sta.l   $7f0003
     pla
     sta.l   $7f0004
     lda     #$01
     sta.l   $7f0005
 
     ; Write code to set s.
     lda     #$cd        ; mov x,#imm
     sta.l   $7f0006
     lda.l   audioSP
     sta.l   $7f0007
     lda     #$bd        ; mov sp,x
     sta.l   $7f0008
 
     ; Write code to push psw
     lda     #$cd        ; mov x,#imm
     sta.l   $7f0009
     lda.l   audioPSW
     sta.l   $7f000a
     lda     #$4d        ; push x
     sta.l   $7f000b
 
     ; Write code to set a.
     lda     #$e8        ; mov a,#imm
     sta.l   $7f000c
     lda.l   audioA
     sta.l   $7f000d
 
     ; Write code to set x.
     lda     #$cd        ; mov x,#imm
     sta.l   $7f000e
     lda.l   audioX
     sta.l   $7f000f
 
     ; Write code to set y.
     lda     #$8d        ; mov y,#imm
     sta.l   $7f0010
     lda.l   audioY
     sta.l   $7f0011
 
     ; Write code to pull psw.
     lda     #$8e        ; pop psw
     sta.l   $7f0012
 
     ; Write code to jump.
     lda     #$5f        ; jmp labs
     sta.l   $7f0013
     rep     #A_8BIT
     lda.l   audioPC
     sep     #A_8BIT
     sta.l   $7f0014
     xba
     sta.l   $7f0015
     rts
 
 .macro waitForAudio0M
 -
     cmp     AUDIO_R0
     bne     -
 .endm
 
 CopyBlockToSPC:
     ; musicSourceAddr - source address
     ; x - dest address
     ; y - count
 
     ; Wait until audio0 is 0xbbaa
     sep     #A_8BIT
     lda     #$aa
     waitForAudio0M
 
     ; Send the destination address to AUDIO2.
     stx     AUDIO_R2
 
     ; Transfer count to x.
     phy
     plx
 
     ; Send $01cc to AUDIO0 and wait for echo.
     lda     #$01
     sta     AUDIO_R1
     lda     #$cc
     sta     AUDIO_R0
     waitForAudio0M
 
     ; Zero counter.
     ldy     #$0000
 
 CopyBlockToSPC_loop:
     ; Load the high byte of a with the destination byte.
     xba
     lda     [musicSourceAddr],y
     xba
     
     ; Load the low byte of a with the counter.
     tya
 
     ; Send the counter/byte.
     rep     #A_8BIT
     sta     AUDIO_R0
     sep     #A_8BIT
 
     ; Wait for counter to echo back.
     waitForAudio0M
 
     ; Update counter and number of bytes left to send.
     iny
     dex
     bne     CopyBlockToSPC_loop
 
     ; Send the start of IPL ROM send routine as starting address.
     ldx     #$ffc9
     stx     AUDIO_R2
     
     ; Clear high byte.
     xba
     lda     #0
     xba
 
     ; Add a value greater than one to the counter to terminate.
     clc
     adc     #$2
 
     ; Send the counter/byte.
     rep     #A_8BIT
     sta     AUDIO_R0
     sep     #A_8BIT
 
     ; Wait for counter to echo back.
     waitForAudio0M
 
     rts
 
 StartSPCExec:
     ; Starting address is in x.
 
     ; Wait until audio0 is 0xbbaa
     sep     #A_8BIT
     lda     #$aa
     waitForAudio0M
 
     ; Send the destination address to AUDIO2.
     stx     AUDIO_R2
 
     ; Send $00cc to AUDIO0 and wait for echo.
     lda     #$00
     sta     AUDIO_R1
     lda     #$cc
     sta     AUDIO_R0
     waitForAudio0M
 
     rts
 
 .ends