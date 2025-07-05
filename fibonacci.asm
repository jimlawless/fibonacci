; Jim Lawless
; MIT license
; See project at https://github.com/jimlawless/fibonacci
;
; This program is a Commodore 64 program that just generates 
; a list of the first 14 Fibonacci numbers.
;
; I wrote it as an aid for another developer who was trying to
; write a similar program
;
; Best assembled with 64tass using the command line:
; 64tass -a --output=fibonacci.prg --cbm-prg --list=fibonacci.txt fibonacci.asm
;
    * = $c000

    linprt = $bdcd
    chrout = $ffd2

    jmp begin

; We'll have three 16-bit variables and an 8-bit counter variable
var_a .word 0

var_b .word 1

var_c .word 0
    
loop_count .byte 14

begin:
; let c = a + b
; lobyte first
    lda var_a
    clc
    adc var_b
; save the carry
    php
    sta var_c  
; now, hibyte
    lda var_a+1
; restore the carry
    plp
    adc var_b+1
    sta var_c+1
    ldx var_c
; the .A register alread has the high-order
; byte.  We just needed to load .X before calling
; the BASIC ROM routine at $BDCD to display a 
; signed 16-bit number in .A and .X
;
; print c
    jsr linprt
; print a space
    lda #$20
    jsr chrout
; let a=b
    lda var_b
    sta var_a
    lda var_b+1
    sta var_a+1
; let b=c
    lda var_c
    sta var_b
    lda var_c+1
    sta var_b+1
; decrement the loop counter 
; and branch to the loop if we're not zero
    dec loop_count
    bne begin
    rts
