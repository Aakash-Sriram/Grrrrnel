org 0x7c00
bits 16 

jmp main

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

main:
    mov si , message 
    call print
    jmp $

message: db 'Hello, World!',0

times 510-($-$$) db 0 ;Fill rem space with 0 until 510byte
dw 0xAA55 ;set 2 bytes to 0xAA55 (boot signature)

