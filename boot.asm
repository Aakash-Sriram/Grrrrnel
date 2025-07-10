org 0
bits 16 

bpb:
    jmp short start
    nop 
    times 33 db 0 

start:
    jmp 0x7c0:main

main:
    cli;clear interupts
    mov ax,0x7c0
    mov ds,ax ; manually seting these segments to avoid undefined 
    mov es,ax
    mov ax,0x00
    mov ss,ax
    mov sp,0x7c0
    sti;enable interupts
    mov si , message 
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

message: db 'Hello, World!',0

times 510-($-$$) db 0 ;Fill rem space with 0 until 510byte
dw 0xAA55 ;set 2 bytes to 0xAA55 (boot signature)

