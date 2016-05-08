.pos 0x100
start:
    ld $sb, r5           # initialize stack pointer
    inca    r5           # r5 = deallocate
    gpc $6, r6           # r6 = return address
    j main               # goto main
    halt

f:
    deca r5              # allocate space for arguments
    ld $0, r0            # r0 = d = 0
    ld 4(r5), r1         # r1 = b = x[i]
    ld $0x80000000, r2   # r2 = 80000000
f_loop:
    beq r1, f_end        # goto f_end if b=0
    mov r1, r3           # r3 = c = x[i]
    and r2, r3           # r3 = c = x[i] & 80000000
    beq r3, f_if1        # goto f_if1 if c == 0
    inc r0               # d++

f_if1:
    shl $1, r1           # b = b * 2
    br f_loop            # goto f_loop

f_end:
    inca r5              # deallocate
    j(r6)                # return to caller （main_loop)

main:
    deca r5              # allocate space
    deca r5              # allocate space
    st r6, 4(r5)         # store return address on stack
    ld $8, r4            # i = 8

main_loop:
    beq r4, main_end     # goto main_en if i=0
    dec r4               # i--
    ld $x, r0            # r0 = &x
    ld (r0,r4,4), r0     # r0 = x[i]
    deca r5              # allocate space
    st r0, (r5)          # a = x[i]
    gpc $6, r6           # r6 = return address
    j f                  # goto f
    inca r5              # deallocate
    ld $y, r1            # r1 = &y
    st r0, (r1,r4,4)     # y[i] = d
    br main_loop         # goto main_loop

main_end:
    ld 4(r5), r6         # r6 = return address
    inca r5              # deallocate
    inca r5              # deallocate
    j (r6)               # return to caller （start)

.pos 0x2000
x:
    .long 1              # x[0]
    .long 2              # x[1]
    .long 3              # x[2]
    .long 0xffffffff     # x[3]
    .long 0xfffffffe     # x[4]
    .long 0              # x[5]
    .long 184            # x[6]
    .long 340057058      # x[7]

y:
    .long 0              # y[0]
    .long 0              # y[1]
    .long 0              # y[2]
    .long 0              # y[3]
    .long 0              # y[4]
    .long 0              # y[5]
    .long 0              # y[6]
    .long 0              # y[7]

.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0     # a=x[i]
    .long 0
    .long 0
    .long 0   
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0     # ra
    .long 0
    .long 0
sb: .long 0

