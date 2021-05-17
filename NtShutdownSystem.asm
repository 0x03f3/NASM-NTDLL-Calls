;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Created by 0x03f3 - http://github.com/0x03f3 ;;
;;                                               ;;
;;  nasm -felf64 shutdown.asm -o shutdown.obj    ;;
;;  gcc shutdown.obj -o shutdown                 ;;
;;                                               ;;
;;  Mode: 64 bits                                ;;
;;  Syntax: YASM/NASM                            ;;
;;  Instruction set: 80386, x64                  ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                !!!WARNING!!!                  ;;
;;      THIS PROGRAM WILL NOT GRACEFULLY SHUT    ;;
;;      DOWN YOUR SYSTEM, USE WITH CAUTION       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 BITS 64

global main: function

extern __imp_GetProcAddress                             ; Import external functions
extern __imp_LoadLibraryA                               ; to perform lib loading
extern __main                                           ; and function calls

SECTION .rdata                                          ; Assign rdata section constants 

NTDLL:                                                  ; Type: byte
        db 6EH, 74H, 64H, 6CH, 6CH, 2EH, 64H, 6CH       ; 0000 _ ntdll.dl
        db 6CH, 00H                                     ; 0008 _ l.

RTLA:                                                   ; Type: byte
        db 52H, 74H, 6CH, 41H, 64H, 6AH, 75H, 73H       ; RtlAdjus
        db 74H, 50H, 72H, 69H, 76H, 69H, 6CH, 65H       ; tPrivile
        db 67H, 65H, 00H                                ; ge.

NTSS:                                                   ; Type: byte
        db 4EH, 74H, 53H, 68H, 75H, 74H, 64H, 6FH       ; NtShutdo
        db 77H, 6EH, 53H, 79H, 73H, 74H, 65H, 6DH       ; wnSystem
        db 00H, 00H, 00H                                ; ...

SECTION .text                                           ; Begin code section

.text:                                                  ; Local functions

main:
        push    rbp                                     ; 0000 _ 55
        mov     rbp, rsp                                ; 0001 _ 48: 89. E5
        sub     rsp, 80                                 ; 0004 _ 48: 83. EC, 50
        call    __main                                  ; 0008 _ E8, 00000000(rel)
        lea     rcx, [rel NTDLL]                        ; 000D _ 48: 8D. 0D, 00000000(rel)
        mov     rax, qword [rel __imp_LoadLibraryA]     ; 0014 _ 48: 8B. 05, 00000000(rel)
        call    rax                                     ; 001B _ FF. D0
        lea     rdx, [rel RTLA]                         ; 001D _ 48: 8D. 15, 0000000A(rel)
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
        jz      BYE                                     ; 0058 _ 74, 54
        lea     rcx, [rel NTDLL]                        ; 005A _ 48: 8D. 0D, 00000000(rel)
        mov     rax, qword [rel __imp_LoadLibraryA]     ; 0061 _ 48: 8B. 05, 00000000(rel)
        call    rax                                     ; 0068 _ FF. D0
        lea     rdx, [rel NTSS]                         ; 006A _ 48: 8D. 15, 0000001D(rel)
        mov     rcx, rax                                ; 0071 _ 48: 89. C1
        mov     rax, qword [rel __imp_GetProcAddress]   ; 0074 _ 48: 8B. 05, 00000000(rel)
        call    rax                                     ; 007B _ FF. D0
        mov     qword [rbp-10H], rax                    ; 007D _ 48: 89. 45, F0
        lea     rax, [rbp-18H]                          ; 0081 _ 48: 8D. 45, E8
        mov     qword [rsp+28H], rax                    ; 0085 _ 48: 89. 44 24, 28
        mov     dword [rsp+20H], 2                      ; 008A _ C7. 44 24, 20, 00000002
        mov     rax, qword [rbp-10H]                    ; 0092 _ 48: 8B. 45, F0
        mov     ecx, 2                                  ; 00A7 _ B9, C0000002
        call    rax                                     ; 00AC _ FF. D0
BYE:  mov     eax, 0                                    ; 00AE _ B8, 00000000
        leave                                           ; 00B3 _ C9
        ret                                             ; 00B4 _ C3
