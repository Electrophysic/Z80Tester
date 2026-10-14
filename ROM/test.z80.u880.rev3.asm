;==================================================================================================
; Z80 Tester
; 
; Hardware: https://oshwlab.com/vitalian1980/z80-tester
; Software: https://bitbucket.org/rudolff/z80-tester/src/master/
;
; Additional code to detect U880 by kinzi @ Forum64 based on
; https://www.robotrontechnik.de/html/forum/thwb/showtopic.php?threadid=11288
;
; Blink codes:
; 1 x = Z80 NMOS
; 2 x = Z8ß CMOS
; 3 x = U880 NMOS (with litte pause between first and second blinking)
;       U880 CMOS (U84C00) does blink two times like Zilog CMOS CPU
;==================================================================================================

SETLED:         macro lednr
                ld c, lednr
                ld a, c
                out (c),a
                endm

DELAY:          macro
                ld b, 255
.loop1:         ld c, 255
.loop2:         dec c
                jp nz, .loop2
                dec b
                jp nz, .loop1
                endm
    
;--------------------------------------------------------------------------------------------------
; CMOS detection (additional blink)
; undocumented "out (c),0" works as out (c), FF on CMOS z80
;--------------------------------------------------------------------------------------------------

start:          

;               out (c),0
                db 0xED, 0x71       ; oooooooo = CMOS
                                    ; xxxxxxxx = NMOS
                DELAY

                SETLED 0            ; xxxxxxxx
    
                DELAY

;--------------------------------------------------------------------------------------------------
; At least flash once (NMOS)
;--------------------------------------------------------------------------------------------------

                SETLED 255          ; oooooooo

                DELAY

                SETLED 0            ; xxxxxxxx
    
                DELAY
        
;--------------------------------------------------------------------------------------------------
; U880 detection (double blink)
;--------------------------------------------------------------------------------------------------

                ld hl,0ffffh
                ld bc,0180ah
                scf
                outi
                jp nc,knightrider   ; skip this step if no U880

                SETLED 255          ; oooooooo
                             
                DELAY

                SETLED 0            ; xxxxxxxx
                             
                DELAY
                
                SETLED 255          ; oooooooo
                             
                DELAY
                
                SETLED 0            ; xxxxxxxx
                             
                DELAY

;==================================================================================================
; main loop (endless "knight rider" light effect)
;==================================================================================================

knightrider:    SETLED 1
   
                DELAY

                SETLED 2

                DELAY

                SETLED 4
                
                DELAY

                SETLED 8
                
                DELAY

                SETLED 16
                
                DELAY

                SETLED 32
                
                DELAY

                SETLED 64
                
                DELAY

                SETLED 128
                
                DELAY

                SETLED 64

                DELAY

                SETLED 32
                
                DELAY

                SETLED 16
                
                DELAY

                SETLED 8
                
                DELAY

                SETLED 4
                
                DELAY

                SETLED 2
                
                DELAY
                
                SETLED 1
                
                DELAY
                
                SETLED 0            ; turn off all LEDs
            
                DELAY
                
                jp start


