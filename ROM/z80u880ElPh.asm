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

SETLED          macro lednr
                ld c, lednr
                ld a, c
                out (c),a
                endm

DELAY           MACRO num
                ld b, 255
loop1##num:     ld c, 255
loop2##num:     dec c
                jp nz, loop2##num
                dec b
                jp nz, loop1##num
                endm
    
;--------------------------------------------------------------------------------------------------
; CMOS detection (additional blink)
; undocumented "out (c),0" works as out (c), FF on CMOS z80
;--------------------------------------------------------------------------------------------------
		ORG $0000				; RESET vector
reset:  
        DI						; disable interrupts
		JP		start			; jump to start
;----------------- 		
		ORG $0038				; INT vector
int:	
        DI						; disable interrupts
        JP		doint
        RETI					; interrupt not used
;----------------- 
		ORG $0066				; NMI vector
nmi:	
        DI						; disable interrupts
		JP		donmi
		RETN
;--------------------------------------------------------------------------------------------------
start:          
                IM		1				; interrupt mode 1
                EI                      ; enable interrupt
	            LD		sp, $ffff		; set stack

;               out (c),0
                db 0xED, 0x71       ; oooooooo = CMOS
                                    ; xxxxxxxx = NMOS
                DELAY 01

                SETLED 0            ; xxxxxxxx
    
                DELAY 02

;--------------------------------------------------------------------------------------------------
; At least flash once (NMOS)
;--------------------------------------------------------------------------------------------------

                SETLED 255          ; oooooooo

                DELAY 03

                SETLED 0            ; xxxxxxxx
    
                DELAY 04
        
;--------------------------------------------------------------------------------------------------
; U880 detection (double blink)
;--------------------------------------------------------------------------------------------------

                ld hl,0ffffh
                ld bc,0180ah
                scf
                outi
                jp nc,knightrider   ; skip this step if no U880

                SETLED 255          ; oooooooo
                             
                DELAY 05

                SETLED 0            ; xxxxxxxx
                             
                DELAY 06
                
                SETLED 255          ; oooooooo
                             
                DELAY 07
                
                SETLED 0            ; xxxxxxxx
                             
                DELAY 08

;==================================================================================================
; main loop (endless "knight rider" light effect)
;==================================================================================================

knightrider:    SETLED 1
   
                DELAY 09

                SETLED 2

                DELAY 10

                SETLED 4
                
                DELAY 11

                SETLED 8
                
                DELAY 12

                SETLED 16
                
                DELAY 13

                SETLED 32
                
                DELAY 14

                SETLED 64
                
                DELAY 15

                SETLED 128
                
                DELAY 16

                SETLED 64

                DELAY 17

                SETLED 32
                
                DELAY 18

                SETLED 16
                
                DELAY 19

                SETLED 8
                
                DELAY 20

                SETLED 4
                
                DELAY 21

                SETLED 2
                
                DELAY 22
                
                SETLED 1
                
                DELAY 23
                
                SETLED 0            ; turn off all LEDs
            
                DELAY 24
                
                jp start
;--------------------------------------------------------------------------------------------------
doint:	
		        SETLED 0

                DELAY 25

                SETLED $81

                DELAY 26

                SETLED $42

                DELAY 27

                SETLED $24

                DELAY 28

                SETLED $18

                DELAY 29

                SETLED 0

                DELAY 30
    		
		        jp  reset        
;--------------------------------------------------------------------------------------------------
donmi:
                SETLED 0

                DELAY 31

                SETLED $18

                DELAY 32

                SETLED $24

                DELAY 33

                SETLED $42

                DELAY 34

                SETLED $81

                DELAY 35

                SETLED 0

                DELAY 36
    		
		        jp  reset  



