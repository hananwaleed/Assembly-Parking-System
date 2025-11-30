.model small
.stack 100h

.data
    ; --- VARIABLES ---
    MAX_PARK    db 8        
    amount      dw 0        
    count       db 0        

    count_s     db 0        ; Scooter count
    count_c     db 0        ; Car count
    count_b     db 0        ; Bus count
    
    ; --- MENU TEXT ---
    menu    db 10,13,'***************** WELCOME TO PARKING *****************
    menu1   db 10,13,'Press 1 to Park Scooter (200)$'
    menu2   db 10,13,'Press 2 to Park Car (300)$'
    menu3   db 10,13,'Press 3 to Park Bus (400)$'
    menu4   db 10,13,'Press 4 to Show Record$'
    menu5   db 10,13,'Press 5 to Check Status$'
    menu6   db 10,13,'Press 6 to Reset All$'
    menu7   db 10,13,'Press 7 to Exit$'

    menu_separator db 10,13,'------------------ REMOVAL ---------------------$'
    menu8   db 10,13,'Press 8 to Remove Scooter$'
    menu9   db 10,13,'Press 9 to Remove Car$'
    menuA   db 10,13,'Press A to Remove Bus$'
    menu_separator_end db 10,13,'-----------------------------------------------$'
    
    ; --- MESSAGES ---
    msg_full    db 10,13,'*** Parking Is Full! Max Capacity Reached ***$'
    msg_err     db 10,13,'*** Wrong Input! Please Try Again ***$'
    
    msg_add_scooter db 10,13,'*** Scooter Added Successfully! Fee: $'
    msg_add_car     db 10,13,'*** Car Added Successfully! Fee: $'
    msg_add_bus     db 10,13,'*** Bus Added Successfully! Fee: $'
    
    msg_total   db 10,13,'Total Income: $'
    msg_parked  db 10,13,'Total Vehicles Parked: $'
    msg_scooter db 10,13,'  - Scooters: $'
    msg_car     db 10,13,'  - Cars: $'
    msg_bus     db 10,13,'  - Buses: $'
    
    msg_available db 10,13,'Available Slots: $'
    msg_occupied  db 10,13,'Occupied Slots: $'
    
    msg_rem_scooter db 10,13,'*** Scooter Removed Successfully ***$'
    msg_rem_car     db 10,13,'*** Car Removed Successfully ***$'
    msg_rem_bus     db 10,13,'*** Bus Removed Successfully ***$'
    msg_rem_zero    db 10,13,'*** ERROR: No Vehicles of This Type ***$'
    
    msg_reset_confirm db 10,13,'Are You Sure? (Y/N): $'
    msg_reset_ok      db 10,13,'*** All Records Cleared Successfully ***$'
    msg_reset_cancel  db 10,13,'*** Reset Cancelled ***$'
    
    msg_separator db 10,13,'======================================================$'
    
    newline db 10,13,'$'

.code

; ============================================
; CLEAR SCREEN PROC
; ============================================
clear_screen proc
    push ax
    push bx
    push cx
    push dx
    
    mov ah, 06h
    mov al, 0
    mov bh, 07h
    mov cx, 0
    mov dh, 24
    mov dl, 79
    int 10h
    
    mov ah, 02h
    mov bh, 0
    mov dh, 0
    mov dl, 0
    int 10h
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
clear_screen endp

; ============================================
; PRINT NUMBER PROC  
; ============================================
print_number proc
    push ax
    push bx
    push cx
    push dx
    
    mov dx, 0
    mov bx, 10
    mov cx, 0
L_push:
    div bx
    push dx
    mov dx, 0
    inc cx
    cmp ax, 0
    jne L_push
   
L_print:
    pop dx
    add dl, 48
    mov ah, 2
    int 21h
    loop L_print
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

; ============================================
; DISPLAY MENU PROCEDURE
; ============================================
display_menu_proc proc
    lea dx, menu
    mov ah, 9
    int 21h

    lea dx, menu1
    mov ah, 9
    int 21h
    lea dx, menu2
    mov ah, 9
    int 21h
    lea dx, menu3
    mov ah, 9
    int 21h
    lea dx, menu4
    mov ah, 9
    int 21h
    lea dx, menu5
    mov ah, 9
    int 21h
    lea dx, menu6
    mov ah, 9
    int 21h
    lea dx, menu7
    mov ah, 9
    int 21h
    
    lea dx, menu_separator
    mov ah, 9
    int 21h
    lea dx, menu8
    mov ah, 9
    int 21h
    lea dx, menu9
    mov ah, 9
    int 21h
    lea dx, menuA
    mov ah, 9
    int 21h
    lea dx, menu_separator_end
    mov ah, 9
    int 21h
    
    ret
display_menu_proc endp

; ============================================
; MAIN PROGRAM  
; ============================================
main proc
    mov ax, @data
    mov ds, ax

while_loop:
    call clear_screen
    call display_menu_proc

    mov ah, 1
    int 21h
    mov bl, al

    lea dx, newline
    mov ah, 9
    int 21h

    cmp bl, '1'
    je do_scooter
    cmp bl, '2'
    je do_car
    cmp bl, '3'
    je do_bus
    cmp bl, '4'
    je do_record
    cmp bl, '5'
    je do_check
    cmp bl, '6'
    je do_reset
    cmp bl, '7'
    je exit_prog
    cmp bl, '8'
    je do_rem_scooter
    cmp bl, '9'
    je do_rem_car
    cmp bl, 'A'
    je do_rem_bus
    cmp bl, 'a'
    je do_rem_bus

    lea dx, msg_err
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    
    mov ah, 1
    int 21h
    jmp while_loop

do_scooter:
    call add_scooter_proc
    mov ah, 1
    int 21h
    jmp while_loop
    
do_car:
    call add_car_proc
    mov ah, 1
    int 21h
    jmp while_loop
    
do_bus:
    call add_bus_proc
    mov ah, 1
    int 21h
    jmp while_loop

do_rem_scooter:
    call remove_scooter_proc
    mov ah, 1
    int 21h
    jmp while_loop
    
do_rem_car:
    call remove_car_proc
    mov ah, 1
    int 21h
    jmp while_loop
    
do_rem_bus:
    call remove_bus_proc
    mov ah, 1
    int 21h
    jmp while_loop

do_record:
    call show_record_proc
    mov ah, 1
    int 21h
    jmp while_loop
    
do_check:
    call check_status_proc
    mov ah, 1
    int 21h
    jmp while_loop
    
do_reset:
    call reset_record_proc
    mov ah, 1
    int 21h
    jmp while_loop

exit_prog:
    mov ah, 4ch
    int 21h
main endp

; ============================================
; ADD SCOOTER
; ============================================
add_scooter_proc proc
    mov al, count
    cmp al, MAX_PARK
    jge full_s

    mov ax, 200
    add amount, ax
    inc count
    inc count_s

    lea dx, msg_add_scooter
    mov ah, 9
    int 21h
    
    mov ax, 200
    call print_number
    
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret

full_s:
    lea dx, msg_full
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
add_scooter_proc endp

; ============================================
; ADD CAR
; ============================================
add_car_proc proc
    mov al, count
    cmp al, MAX_PARK
    jge full_c

    mov ax, 300
    add amount, ax
    inc count
    inc count_c

    lea dx, msg_add_car
    mov ah, 9
    int 21h
    
    mov ax, 300
    call print_number
    
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret

full_c:
    lea dx, msg_full
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
add_car_proc endp

; ============================================
; ADD BUS
; ============================================
add_bus_proc proc
    mov al, count
    cmp al, MAX_PARK
    jge full_b

    mov ax, 400
    add amount, ax
    inc count
    inc count_b

    lea dx, msg_add_bus
    mov ah, 9
    int 21h
    
    mov ax, 400
    call print_number
    
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret

full_b:
    lea dx, msg_full
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
add_bus_proc endp

; ============================================
; REMOVE SCOOTER
; ============================================
remove_scooter_proc proc
    mov al, count_s
    cmp al, 0
    jle rem_err_s

    dec count
    dec count_s

    lea dx, msg_rem_scooter
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret

rem_err_s:
    lea dx, msg_rem_zero
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
remove_scooter_proc endp

; ============================================
; REMOVE CAR
; ============================================
remove_car_proc proc
    mov al, count_c
    cmp al, 0
    jle rem_err_c

    dec count
    dec count_c

    lea dx, msg_rem_car
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret

rem_err_c:
    lea dx, msg_rem_zero
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
remove_car_proc endp

; ============================================
; REMOVE BUS
; ============================================
remove_bus_proc proc
    mov al, count_b
    cmp al, 0
    jle rem_err_b

    dec count
    dec count_b

    lea dx, msg_rem_bus
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret

rem_err_b:
    lea dx, msg_rem_zero
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
remove_bus_proc endp

; ============================================
; SHOW RECORD
; ============================================
show_record_proc proc
    lea dx, msg_separator
    mov ah, 9
    int 21h
    
    lea dx, msg_total
    mov ah, 9
    int 21h
    mov ax, amount
    call print_number

    lea dx, newline
    mov ah, 9
    int 21h

    lea dx, msg_parked
    mov ah, 9
    int 21h
    
    mov al, count
    mov ah, 0
    mov dl, 10
    div dl
    
    cmp al, 0
    je skip_tens
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h
skip_tens:
    
    mov al, ah
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    lea dx, msg_scooter
    mov ah, 9
    int 21h
    
    mov al, count_s
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    lea dx, msg_car
    mov ah, 9
    int 21h
    
    mov al, count_c
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    lea dx, msg_bus
    mov ah, 9
    int 21h
    
    mov al, count_b
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
show_record_proc endp

; ============================================
; CHECK STATUS
; ============================================
check_status_proc proc
    lea dx, msg_separator
    mov ah, 9
    int 21h
    
    lea dx, msg_occupied
    mov ah, 9
    int 21h

    mov al, count
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    lea dx, msg_available
    mov ah, 9
    int 21h

    mov al, MAX_PARK
    sub al, count
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h

    lea dx, newline
    mov ah, 9
    int 21h
    
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
check_status_proc endp

; ============================================
; RESET
; ============================================
reset_record_proc proc
    lea dx, msg_reset_confirm
    mov ah, 9
    int 21h
    
    mov ah, 1
    int 21h
    mov bl, al
    
    lea dx, newline
    mov ah, 9
    int 21h
    
    cmp bl, 'Y'
    je reset_yes
    cmp bl, 'y'
    je reset_yes
    
    lea dx, msg_reset_cancel
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
    
reset_yes:
    mov count_s, 0
    mov count_c, 0
    mov count_b, 0
    mov count, 0
    mov amount, 0

    lea dx, msg_reset_ok
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
reset_record_proc endp

end main
    menu1   db 10,13,'Press 1 to Park Scooter (200)$'
    menu2   db 10,13,'Press 2 to Park Car (300)$'
    menu3   db 10,13,'Press 3 to Park Bus (400)$'
    menu4   db 10,13,'Press 4 to Show Record$'
    menu5   db 10,13,'Press 5 to Check Status$'
    menu6   db 10,13,'Press 6 to Reset All$'
    menu7   db 10,13,'Press 7 to Exit$'

    menu_separator db 10,13,'------------------ REMOVAL ---------------------$'
    menu8   db 10,13,'Press 8 to Remove Scooter$'
    menu9   db 10,13,'Press 9 to Remove Car$'
    menuA   db 10,13,'Press A to Remove Bus$'
    menu_separator_end db 10,13,'-----------------------------------------------$'
    
    ; --- MESSAGES ---
    msg_full    db 10,13,'*** Parking Is Full! Max Capacity Reached ***$'
    msg_err     db 10,13,'*** Wrong Input! Please Try Again ***$'
    
    msg_add_scooter db 10,13,'*** Scooter Added Successfully! Fee: $'
    msg_add_car     db 10,13,'*** Car Added Successfully! Fee: $'
    msg_add_bus     db 10,13,'*** Bus Added Successfully! Fee: $'
    
    msg_total   db 10,13,'Total Income: $'
    msg_parked  db 10,13,'Total Vehicles Parked: $'
    msg_scooter db 10,13,'  - Scooters: $'
    msg_car     db 10,13,'  - Cars: $'
    msg_bus     db 10,13,'  - Buses: $'
    
    msg_available db 10,13,'Available Slots: $'
    msg_occupied  db 10,13,'Occupied Slots: $'
    
    msg_rem_scooter db 10,13,'*** Scooter Removed Successfully ***$'
    msg_rem_car     db 10,13,'*** Car Removed Successfully ***$'
    msg_rem_bus     db 10,13,'*** Bus Removed Successfully ***$'
    msg_rem_zero    db 10,13,'*** ERROR: No Vehicles of This Type ***$'
    
    msg_reset_confirm db 10,13,'Are You Sure? (Y/N): $'
    msg_reset_ok      db 10,13,'*** All Records Cleared Successfully ***$'
    msg_reset_cancel  db 10,13,'*** Reset Cancelled ***$'
    
    msg_separator db 10,13,'======================================================$'
    
    newline db 10,13,'$'

.code

; ============================================
; CLEAR SCREEN PROC
; ============================================
clear_screen proc
    push ax
    push bx
    push cx
    push dx
    
    mov ah, 06h
    mov al, 0
    mov bh, 07h
    mov cx, 0
    mov dh, 24
    mov dl, 79
    int 10h
    
    mov ah, 02h
    mov bh, 0
    mov dh, 0
    mov dl, 0
    int 10h
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
clear_screen endp

; ============================================
; PRINT NUMBER PROC  
; ============================================
print_number proc
    push ax
    push bx
    push cx
    push dx
    
    mov dx, 0
    mov bx, 10
    mov cx, 0
L_push:
    div bx
    push dx
    mov dx, 0
    inc cx
    cmp ax, 0
    jne L_push
   
L_print:
    pop dx
    add dl, 48
    mov ah, 2
    int 21h
    loop L_print
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

; ============================================
; DISPLAY MENU PROCEDURE
; ============================================
display_menu_proc proc
    lea dx, menu
    mov ah, 9
    int 21h

    lea dx, menu1
    mov ah, 9
    int 21h
    lea dx, menu2
    mov ah, 9
    int 21h
    lea dx, menu3
    mov ah, 9
    int 21h
    lea dx, menu4
    mov ah, 9
    int 21h
    lea dx, menu5
    mov ah, 9
    int 21h
    lea dx, menu6
    mov ah, 9
    int 21h
    lea dx, menu7
    mov ah, 9
    int 21h
    
    lea dx, menu_separator
    mov ah, 9
    int 21h
    lea dx, menu8
    mov ah, 9
    int 21h
    lea dx, menu9
    mov ah, 9
    int 21h
    lea dx, menuA
    mov ah, 9
    int 21h
    lea dx, menu_separator_end
    mov ah, 9
    int 21h
    
    ret
display_menu_proc endp

; ============================================
; MAIN PROGRAM  
; ============================================
main proc
    mov ax, @data
    mov ds, ax

while_loop:
    call clear_screen
    call display_menu_proc

    mov ah, 1
    int 21h
    mov bl, al

    lea dx, newline
    mov ah, 9
    int 21h

    cmp bl, '1'
    je do_scooter
    cmp bl, '2'
    je do_car
    cmp bl, '3'
    je do_bus
    cmp bl, '4'
    je do_record
    cmp bl, '5'
    je do_check
    cmp bl, '6'
    je do_reset
    cmp bl, '7'
    je exit_prog
    cmp bl, '8'
    je do_rem_scooter
    cmp bl, '9'
    je do_rem_car
    cmp bl, 'A'
    je do_rem_bus
    cmp bl, 'a'
    je do_rem_bus

    lea dx, msg_err
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    
    mov ah, 1
    int 21h
    jmp while_loop

do_scooter:
    call add_scooter_proc
    mov ah, 1
    int 21h
    jmp while_loop
    
do_car:
    call add_car_proc
    mov ah, 1
    int 21h
    jmp while_loop
    
do_bus:
    call add_bus_proc
    mov ah, 1
    int 21h
    jmp while_loop

do_rem_scooter:
    call remove_scooter_proc
    mov ah, 1
    int 21h
    jmp while_loop
    
do_rem_car:
    call remove_car_proc
    mov ah, 1
    int 21h
    jmp while_loop
    
do_rem_bus:
    call remove_bus_proc
    mov ah, 1
    int 21h
    jmp while_loop

do_record:
    call show_record_proc
    mov ah, 1
    int 21h
    jmp while_loop
    
do_check:
    call check_status_proc
    mov ah, 1
    int 21h
    jmp while_loop
    
do_reset:
    call reset_record_proc
    mov ah, 1
    int 21h
    jmp while_loop

exit_prog:
    mov ah, 4ch
    int 21h
main endp

; ============================================
; ADD SCOOTER
; ============================================
add_scooter_proc proc
    mov al, count
    cmp al, MAX_PARK
    jge full_s

    mov ax, 200
    add amount, ax
    inc count
    inc count_s

    lea dx, msg_add_scooter
    mov ah, 9
    int 21h
    
    mov ax, 200
    call print_number
    
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret

full_s:
    lea dx, msg_full
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
add_scooter_proc endp

; ============================================
; ADD CAR
; ============================================
add_car_proc proc
    mov al, count
    cmp al, MAX_PARK
    jge full_c

    mov ax, 300
    add amount, ax
    inc count
    inc count_c

    lea dx, msg_add_car
    mov ah, 9
    int 21h
    
    mov ax, 300
    call print_number
    
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret

full_c:
    lea dx, msg_full
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
add_car_proc endp

; ============================================
; ADD BUS
; ============================================
add_bus_proc proc
    mov al, count
    cmp al, MAX_PARK
    jge full_b

    mov ax, 400
    add amount, ax
    inc count
    inc count_b

    lea dx, msg_add_bus
    mov ah, 9
    int 21h
    
    mov ax, 400
    call print_number
    
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret

full_b:
    lea dx, msg_full
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
add_bus_proc endp

; ============================================
; REMOVE SCOOTER
; ============================================
remove_scooter_proc proc
    mov al, count_s
    cmp al, 0
    jle rem_err_s

    dec count
    dec count_s

    lea dx, msg_rem_scooter
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret

rem_err_s:
    lea dx, msg_rem_zero
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
remove_scooter_proc endp

; ============================================
; REMOVE CAR
; ============================================
remove_car_proc proc
    mov al, count_c
    cmp al, 0
    jle rem_err_c

    dec count
    dec count_c

    lea dx, msg_rem_car
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret

rem_err_c:
    lea dx, msg_rem_zero
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
remove_car_proc endp

; ============================================
; REMOVE BUS
; ============================================
remove_bus_proc proc
    mov al, count_b
    cmp al, 0
    jle rem_err_b

    dec count
    dec count_b

    lea dx, msg_rem_bus
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret

rem_err_b:
    lea dx, msg_rem_zero
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
remove_bus_proc endp

; ============================================
; SHOW RECORD
; ============================================
show_record_proc proc
    lea dx, msg_separator
    mov ah, 9
    int 21h
    
    lea dx, msg_total
    mov ah, 9
    int 21h
    mov ax, amount
    call print_number

    lea dx, newline
    mov ah, 9
    int 21h

    lea dx, msg_parked
    mov ah, 9
    int 21h
    
    mov al, count
    mov ah, 0
    mov dl, 10
    div dl
    
    cmp al, 0
    je skip_tens
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h
skip_tens:
    
    mov al, ah
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    lea dx, msg_scooter
    mov ah, 9
    int 21h
    
    mov al, count_s
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    lea dx, msg_car
    mov ah, 9
    int 21h
    
    mov al, count_c
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    lea dx, msg_bus
    mov ah, 9
    int 21h
    
    mov al, count_b
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
show_record_proc endp

; ============================================
; CHECK STATUS
; ============================================
check_status_proc proc
    lea dx, msg_separator
    mov ah, 9
    int 21h
    
    lea dx, msg_occupied
    mov ah, 9
    int 21h

    mov al, count
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    lea dx, msg_available
    mov ah, 9
    int 21h

    mov al, MAX_PARK
    sub al, count
    add al, 48
    mov dl, al
    mov ah, 2
    int 21h

    lea dx, newline
    mov ah, 9
    int 21h
    
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
check_status_proc endp

; ============================================
; RESET
; ============================================
reset_record_proc proc
    lea dx, msg_reset_confirm
    mov ah, 9
    int 21h
    
    mov ah, 1
    int 21h
    mov bl, al
    
    lea dx, newline
    mov ah, 9
    int 21h
    
    cmp bl, 'Y'
    je reset_yes
    cmp bl, 'y'
    je reset_yes
    
    lea dx, msg_reset_cancel
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
    
reset_yes:
    mov count_s, 0
    mov count_c, 0
    mov count_b, 0
    mov count, 0
    mov amount, 0

    lea dx, msg_reset_ok
    mov ah, 9
    int 21h
    lea dx, msg_separator
    mov ah, 9
    int 21h
    ret
reset_record_proc endp

end main
