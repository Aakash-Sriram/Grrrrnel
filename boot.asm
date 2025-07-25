org 0
bits 16 

bpb:
    jmp short start
    nop 
    times 33 db 0 

start:
    jmp 0x7c0:main

; AH = 02h
; AL = number of sectors to read (must be nonzero)
; CH = low eight bits of cylinder number
; CL = sector number 1-63 (bits 0-5)
; high two bits of cylinder (bits 6-7, hard disk only)
; DH = head number
; DL = drive number (bit 7 set for hard disk)
; ES:BX -> data buffer


main:
    cli;clear interupts
    mov ax,0x7c0
    mov ds,ax ; manually seting these segments to avoid undefined behaviour
    mov es,ax
    mov ax,0x00
    mov ss,ax
    mov sp,0x7c0
    sti;enable interupts

    mov ah,2
    mov al,1
    mov cl,2
    mov ch,0
    mov dh,0        
    
    mov bx,buffer
    int 13h

    jc err_msg
  
    mov si , bx
    call print

    jmp $

msg: db "Error reading sector" ,0

err_msg:
    mov si , msg
    call print
    jmp $

print:

._loop:
    mov al , [si] ;move one byte at a time into al register
    cmp al,0 ;look for null terminator
    je .done
    mov ah , 0eh
    int 10h ;bios interupt for writing char to screen
    inc si ;increment si to move to next char
    jmp ._loop

.done:
    ret

times 510-($-$$) db 0 ;Fill rem space with 0 until 510byte
dw 0xAA55 ;set 2 bytes to 0xAA55 (boot signature)

buffer: