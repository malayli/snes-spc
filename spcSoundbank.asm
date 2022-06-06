;************************************************
; SPC soundbank data                            *
;************************************************

.include "hdr.asm"

; The SPC file from which we read our data.
.define spcFile "turtlepower.spc"

.BANK 5
.SECTION "SOUNDBANK0" ; need dedicated bank(s)

SOUNDBANK__0:
.incbin spcFile skip $00100 read $8000
.ENDS

.BANK 6
.SECTION "SOUNDBANK1" ; need dedicated bank(s)

SOUNDBANK__1:
.incbin spcFile skip $08100 read $8000
.ENDS
