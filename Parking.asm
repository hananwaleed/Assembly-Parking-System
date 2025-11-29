.model small
.stack 100h

.data
    ; --- ??????? ????? ????????? ---
    MAX_PARK    db '8'      ; ???? ?????? ??????? (ASCII '8')
    amount      dw 0        ; ?????? ?????? (Income)
    count       db '0'      ; ?????? ??? ???????? ????????
    count_r     db '0'      ; ??? ?????????
    count_c     db '0'      ; ??? ????????
    count_b     db '0'      ; ??? ????????
    
    ; --- ????? ???????? (???????) ---
    menu    db 10,13,'***************** PARKING SYSTEM *********************$'
    menu1   db 10,13,'Press 1 to Park Rikshaw (200)$'
    menu2   db 10,13,'Press 2 to Park Car (300)$'
    menu3   db 10,13,'Press 3 to Park Bus (400)$'
    menu_separator db 10,13,'------------------ REMOVAL ---------------------$'
    menu8   db 10,13,'Press 8 to Remove Rikshaw (Refund? No)$'
    menu9   db 10,13,'Press 9 to Remove Car (Refund? No)$'
    menuA   db 10,13,'Press A to Remove Bus (Refund? No)$'
    menu_separator_end db 10,13,'-----------------------------------------------$'
    menu4   db 10,13,'Press 4 to Show Record$'
    menu5   db 10,13,'Press 5 to Check Status (New!) $'
    menu6   db 10,13,'Press 6 to Reset All$'
    menu7   db 10,13,'Press 7 to Exit$'
    
    ; --- ????? ?????? ---
    msg_full    db 10,13,'Parking Is Full! Max Capacity reached$'
    msg_err     db 10,13,'Wrong input$'
    
    msg_total   db 10,13,'Total Income: $'
    msg_parked  db 10,13,'Total Vehicles Parked: $'
    msg_rik     db 10,13,'Total Rikshaws: $'
    msg_car     db 10,13,'Total Cars: $'
    msg_bus     db 10,13,'Total Buses: $'
    
    msg_available db 10,13,'Available Slots: $'
    msg_occupied db 10,13,'Occupied Slots: $'
    msg_reset_ok db 10,13,'*** All Records Cleared Successfully ***$'

    ; --- ????? ??????? ??????? ---
    msg_rem_ok  db 10,13,'*** Vehicle Removed Successfully ***$'
    msg_rem_zero db 10,13,'*** ERROR: No vehicles of this type to remove ***$'
    
    newline db 10,13,'$'

.code
; ---------------------------------------------
; ???? ?????? ?????? ??????? (???? ?? 9)
; ---------------------------------------------
print_number proc
    ; (Code remains the same: Converts AX to decimal string and prints)
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
    
    lea dx, newline 
    mov ah, 9
    int 21h
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

; ---------------------------------------------
; MAIN PROCEDURE
; ---------------------------------------------
main proc
    mov ax, @data
    mov ds, ax

while_loop:   
    ; --- Menu Display ---
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
    
    ; NEW REMOVAL OPTIONS
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
    
    ; --- User Input ---
    mov ah, 1
    int 21h
    mov bl, al
    
    ; Print newline
    lea dx, newline
    mov ah, 9
    int 21h

    ; --- Dispatch (Compare and Jump) ---
    cmp bl, '1'
    je do_rikshaw
    cmp bl, '2'
    je do_car
    cmp bl, '3'
    je do_bus
    
    ; NEW REMOVAL DISPATCH
    cmp bl, '8' ; Remove Rikshaw
    je do_rem_rik
    cmp bl, '9' ; Remove Car
    je do_rem_car
    cmp bl, 'a' ; or 'A' for Bus
    je do_rem_bus
    cmp bl, 'A'
    je do_rem_bus

    cmp bl, '4'
    je do_rec
    cmp bl, '5' 
    je do_check
    cmp bl, '6'
    je do_reset
    cmp bl, '7'
    je exit_prog

    ; Wrong Input
    lea dx, msg_err
    mov ah, 9
    int 21h
    jmp while_loop

do_rikshaw:
    call add_rikshaw_proc
    jmp while_loop
do_car:
    call add_car_proc
    jmp while_loop
do_bus:
    call add_bus_proc
    jmp while_loop

; NEW REMOVAL JUMPS
do_rem_rik:
    call remove_rikshaw_proc
    jmp while_loop
do_rem_car:
    call remove_car_proc
    jmp while_loop
do_rem_bus:
    call remove_bus_proc
    jmp while_loop

do_rec:
    call show_record_proc
    jmp while_loop
do_check:
    call check_status_proc
    jmp while_loop
do_reset:
    call reset_record_proc
    jmp while_loop

exit_prog:
    mov ah, 4ch
    int 21h
main endp

; ---------------------------------------------
; ADD VEHICLE PROCEDURES (No change to logic)
; ---------------------------------------------
; (Keep the original add_rikshaw_proc, add_car_proc, add_bus_proc here)
add_rikshaw_proc proc
    mov al, count
    cmp al, MAX_PARK
    jge full_parking_msg
    
    mov ax, 200
    add amount, ax
    inc count
    inc count_r
    
    mov ax, 200
    call print_number
    
    ret
full_parking_msg:
    lea dx, msg_full
    mov ah, 9
    int 21h
    ret
add_rikshaw_proc endp

add_car_proc proc
    mov al, count
    cmp al, MAX_PARK
    jge full_parking_msg_c
    
    mov ax, 300
    add amount, ax
    inc count
    inc count_c
    
    mov ax, 300
    call print_number
    
    ret
full_parking_msg_c:
    lea dx, msg_full
    mov ah, 9
    int 21h
    ret
add_car_proc endp

add_bus_proc proc
    mov al, count
    cmp al, MAX_PARK
    jge full_parking_msg_b
    
    mov ax, 400
    add amount, ax
    inc count
    inc count_b
    
    mov ax, 400
    call print_number
    
    ret
full_parking_msg_b:
    lea dx, msg_full
    mov ah, 9
    int 21h
    ret
add_bus_proc endp


; ---------------------------------------------
; NEW REMOVAL PROCEDURES
; ---------------------------------------------

; --- Remove Rikshaw ---
remove_rikshaw_proc proc
    push ax
    push dx
    
    mov al, count_r
    cmp al, '0'        ; Check if Rikshaw count > 0
    jle rem_error      ; Jump if Less or Equal (No Rikshaws)
    
    ; Decrease counts
    dec count          ; Decrease total count
    dec count_r        ; Decrease Rikshaw count
    
    ; Display success message
    lea dx, msg_rem_ok
    mov ah, 9
    int 21h
    jmp rem_exit
    
rem_error:
    lea dx, msg_rem_zero
    mov ah, 9
    int 21h
    
rem_exit:
    pop dx
    pop ax
    ret
remove_rikshaw_proc endp

; --- Remove Car ---
remove_car_proc proc
    push ax
    push dx
    
    mov al, count_c
    cmp al, '0'        ; Check if Car count > 0
    jle rem_error_c    ; Jump if Less or Equal (No Cars)
    
    ; Decrease counts
    dec count          ; Decrease total count
    dec count_c        ; Decrease Car count
    
    ; Display success message
    lea dx, msg_rem_ok
    mov ah, 9
    int 21h
    jmp rem_exit_c
    
rem_error_c:
    lea dx, msg_rem_zero
    mov ah, 9
    int 21h
    
rem_exit_c:
    pop dx
    pop ax
    ret
remove_car_proc endp

; --- Remove Bus ---
remove_bus_proc proc
    push ax
    push dx
    
    mov al, count_b
    cmp al, '0'        ; Check if Bus count > 0
    jle rem_error_b    ; Jump if Less or Equal (No Buses)
    
    ; Decrease counts
    dec count          ; Decrease total count
    dec count_b        ; Decrease Bus count
    
    ; Display success message
    lea dx, msg_rem_ok
    mov ah, 9
    int 21h
    jmp rem_exit_b
    
rem_error_b:
    lea dx, msg_rem_zero
    mov ah, 9
    int 21h
    
rem_exit_b:
    pop dx
    pop ax
    ret
remove_bus_proc endp


; ---------------------------------------------
; Other Procedures (No change to logic)
; ---------------------------------------------
; (Keep the original check_status_proc, show_record_proc, reset_record_proc here)
check_status_proc proc
    push ax
    push bx
    push cx
    push dx
    
    ; Display Occupied Slots
    lea dx, msg_occupied
    mov ah, 9
    int 21h
    
    mov dl, count ; Display count (ASCII)
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h
    
    ; Display Available Slots (MAX_PARK - count)
    lea dx, msg_available
    mov ah, 9
    int 21h
    
    ; Subtraction Logic:
    mov al, MAX_PARK ; Load '8' (ASCII 56)
    sub al, count    ; Subtract current count (e.g., '3', ASCII 51)
                     ; Result is 5 (Numeric)
    add al, '0'      ; Convert back to ASCII ('5' -> 53)
    
    mov dl, al       ; Move ASCII result to DL
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
check_status_proc endp

show_record_proc proc
    ; Total Income
    lea dx, msg_total
    mov ah, 9
    int 21h
    mov ax, amount
    call print_number

    ; Total Vehicles Parked
    lea dx, msg_parked
    mov ah, 9
    int 21h
    mov dl, count
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    ; Rikshaws
    lea dx, msg_rik
    mov ah, 9
    int 21h
    mov dl, count_r
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    ; Cars
    lea dx, msg_car
    mov ah, 9
    int 21h
    mov dl, count_c
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h

    ; Buses
    lea dx, msg_bus
    mov ah, 9
    int 21h
    mov dl, count_b
    mov ah, 2
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h
    ret
show_record_proc endp

reset_record_proc proc
    mov count_r, '0'
    mov count_c, '0'
    mov count_b, '0'
    mov amount, 0
    mov count, '0'
    
    lea dx, msg_reset_ok
    mov ah, 9
    int 21h
    
    lea dx, newline
    mov ah, 9
    int 21h
    ret
reset_record_proc endp

end main