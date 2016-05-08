
ld $0x0, r0   # r0 = temp_i = 0
ld $0x0, r2   # r2 = temp_s = 0
ld $0xfffffffe, r3  # r3 = -2

loop:
mov r0, r4    # r4 = temp_i
add r3, r4    # r4 = temp_i-2
beq r4, end   # goto end if temp_i=2
bgt r4, end   # goto end if temp_i>2
inc r2        # temp_s = temp_s + 1
gpc $6, r6    # r6 = return address
j help        # goto help
inc r0        # i++
br loop       # goto loop

help:
ld $3, r5     # r5 = 3
add r5, r2    # r2 = temp_s + 3
j 0(r6)       # return to caller

end:
ld $s, r1     # r1 = address of s
st r2, 0(r1)  # r1 = temp_s
st r0, 4(r1)  # i = temp_i

halt

.pos 0x1000
s:               .long 0x00000000         # s
i:               .long 0x00000000         # i

