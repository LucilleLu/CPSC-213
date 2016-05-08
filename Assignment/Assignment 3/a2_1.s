    # c = 5
    ld $5, r0          # r0 = 5
    ld $c, r1          # r1 = address of c
    st r0, 0(r1)       # c = 5

    # b = c + 10
    ld $c, r1          # r1 = address of c
    ld 0(r1), r1       # r1 = c
    ld $10, r2         # r2 = 10
    add r1, r2         # r2 = c + 10
    ld $b, r3          # r3 = address of b
    st r2, 0(r3)       # b = c + 10
    
    # a[8] = 8
    ld $8, r4          # r4 = 8
    ld $a, r5          # r5 = address of a
    st r4, 32(r5)      # a[8] = 8

    # a[4] = 4
    ld $4, r6          # r6 = 4
    ld 16(r5), r7      # r7 = a[4]
    add r7, r6         # r6 = a[4] + 4
    st r6, 16(r5)      # a[4] = a[4] + 4
 
    # a[c] = a[8] + b + a[b & 0x7]
    ld 32(r5), r1      # r1 = a[8]
    ld 0(r3), r2       # r2 = b
    add r2, r1         # r1 = a[8] + b
    ld $0x7, r3        # r3 = 0x7
    and r2, r3         # r3 = b & 0x7
    ld (r5, r3, 4), r4 # r4 = a[b & 0x7]
    add r1, r4         # r4 = a[8] + b + a[b & 0x7]
    ld $c, r0          # r0 = address of c
    ld 0(r0), r0       # r0 = c
    st r4, (r5, r0, 4) # a[c] = a[8] + b + a[b & 0x7]

.pos 0x1000
# Data area

b:
    .long 0             # the variable of b
c:
    .long 0             # the variable of c
a:
    .long 0             # a[0]
    .long 0             # a[1]
    .long 0             # a[2]
    .long 0             # a[3]
    .long 0             # a[4]
    .long 0             # a[5]
    .long 0             # a[6]
    .long 0             # a[7]
    .long 0             # a[8]
    .long 0             # a[9]
