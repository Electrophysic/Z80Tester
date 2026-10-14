; Simple program to test z80

    xor a
    cpl
    ld c, 1
    out (c),a ; turn on all LEDs
    
;-----------------   
    ld b, 255
delay01:    
    ld c, 255
delay02:
    dec c
    jp nz, delay02
    dec b
    jp nz, delay01
;-----------------  

    xor a
    ld c, 1
    out (c),a ; turn off all LEDs
    
;-----------------   
    ld b, 255
delay03:    
    ld c, 255
delay04:
    dec c
    jp nz, delay04
    dec b
    jp nz, delay03
;-----------------  

    db 0xED, 0x71 ; undocumented "out (c),0" works as out (c), FF on CMOS z80
    
;-----------------   
    ld b, 255
delay05:    
    ld c, 255
delay06:
    dec c
    jp nz, delay06
    dec b
    jp nz, delay05
;-----------------  
    
start:
    ld c, 1
    ld b, c
    ld a, c
    out (c),a
   
;-----------------   
    ld b, 255
delay1:    
    ld c, 255
delay2:
    dec c
    jp nz, delay2
    dec b
    jp nz, delay1
;-----------------   

    ld c, 2
    ld b, c
    ld a, c
    out (c),a

;-------------------    
    ld b, 255
delay11:    
    ld c, 255
delay21:
    dec c
    jp nz, delay21
    dec b
    jp nz, delay11
;-----------------   

    ld c, 4
    ld b, c
    ld a, c
    out (c),a    
    
;-------------------    
    ld b, 255
delay12:    
    ld c, 255
delay22:
    dec c
    jp nz, delay22
    dec b
    jp nz, delay12
;-----------------   

    ld c, 8
    ld b, c
    ld a, c
    out (c),a    
    
;-------------------    
    ld b, 255
delay13:    
    ld c, 255
delay23:
    dec c
    jp nz, delay23
    dec b
    jp nz, delay13
;-----------------   

    ld c, 16
    ld b, c
    ld a, c
    out (c),a   
    
;-------------------    
    ld b, 255
delay14:    
    ld c, 255
delay24:
    dec c
    jp nz, delay24
    dec b
    jp nz, delay14
;-----------------   

    ld c, 32
    ld b, c
    ld a, c
    out (c),a    

    
;-------------------    
    ld b, 255
delay15:    
    ld c, 255
delay25:
    dec c
    jp nz, delay25
    dec b
    jp nz, delay15
;-----------------   

    ld c, 64
    ld b, c
    ld a, c
    out (c),a 
    
;-------------------    
    ld b, 255
delay16:    
    ld c, 255
delay26:
    dec c
    jp nz, delay26
    dec b
    jp nz, delay16
;-----------------   

    ld c, 128
    ld b, c
    ld a, c
    out (c),a 
    
;-------------------    
    ld b, 255
delay17:    
    ld c, 255
delay27:
    dec c
    jp nz, delay27
    dec b
    jp nz, delay17
;-----------------  

    jp start