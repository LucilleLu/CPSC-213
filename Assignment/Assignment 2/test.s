ldi:  ld $0x00000040, r0
      ld $0x00000040, r2
      ld $0xffffffff, r3
      ld $0xffffffff, r4
      ld $0x00000400, r5
      ld $0xeeeeeeee, r6
      ld $0x11223344, r7
rr_move:  mov r0, r1 
add:  add r0, r1
and:  and r1, r3
inc:  inc r6
inca: inca r7
dec:  dec r3
deca: deca r4
not:  not r5
shift: shl $1, r6
       shr $1, r6
lbo:  ld 4(r1), r2
      ld 4(r2), r3
ldx:  ld (r0,r2,4), r5

.pos 0x100
                 ld   $0x0, r0            # r0 = 0
                 ld   $a, r1              # r1 = address of a
sbo:             st   r0, 0x0(r1)         # a = 0
                 ld   $b, r0              # r0 = address of b
                 ld   $a, r1              # r1 = address of a
                 ld   0x0(r1), r2         # r2 = a
sdx:             st   r2, (r0, r2, 4)     # b[a] = a

halt

.pos 0x1000
a:               .long 0xffffffff         # a
.pos 0x2000
b:               .long 0xffffffff         # b[0]
                 .long 0xffffffff         # b[1]
                 .long 0xffffffff         # b[2]
                 .long 0xffffffff         # b[3]
                 .long 0xffffffff         # b[4]
                 .long 0xffffffff         # b[5]
                 .long 0xffffffff         # b[6]
                 .long 0xffffffff         # b[7]
                 .long 0xffffffff         # b[8]
                 .long 0xffffffff         # b[9]

      


