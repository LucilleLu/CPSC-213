    #a[8] = {0,11,2,0,1,2,0,1}
    ld $a, r0         # r0 = address of a

    #b[8] = {2,12,0,2,1,0,2,1}
    ld $b, r1         # r1 = address of b

    #c[8] = {99,6,2,1,0,2,1,0}
    ld $c, r2         # r2 = address of c

    #i = 5
    ld $i, r4         # r4 = address of i
    ld 0(r4), r4      # r4 = the value of i (5)

    #*d = c
    ld $d, r5         # r5 = address of d
    ld 0(r5),r5       # r5 = the value at d (the address of c)

    #a[i+1]
    inc r4            # r4 = i+1
    ld (r0,r4,4), r6  # r6 = a[i+1]

    #b[i+2]
    inc r4            # r4 = i+2
    ld (r1,r4,4), r2  # r2 = b[i+2]

    #a[i] = a[i+1] + b[i+2]
    add r6, r2        # r2 = a[i+1] + b[i+2]
    ld $i, r3         # r3 = address of i
    ld 0(r3), r3      # r3 = i
    st r2, (r0,r3,4)  # a[i] = a[i+1] + b[i+2]

    #d[i] = a[i] + b[i]
    ld (r0,r3,4), r4  # r4 = a[i]
    ld (r1,r3,4), r6  # r6 = b[i]
    add r6, r4        # r4 = a[i] + b[i]
    st r4, (r5,r3,4)  # d[i] = a[i] + b[i]

    #a[b[i]]
    ld (r0,r6,4), r4  # r4 = a[b[i]]

    #b[a[i]]
    ld (r0,r3,4), r2  # r2 = a[i]
    ld (r1,r2,4), r6  # r6 = b[a[i]]

    #d[i] = a[b[i]] + b[a[i]]
    add r6, r4        # r4 = a[b[i]] + b[a[i]]
    st r4, (r5,r3,4)  # d[i] = a[b[i]] + b[a[i]]

    #b[a[i & 3] & 3]
    ld $3, r2         # r2 = 3
    and r3, r2        # r2 = i & 3
    ld (r0,r2,4), r4  # r4 = a[i & 3]
    ld $3, r6         # r6 = 3
    and r6, r4        # r4 = a[i & 3] & 3
    ld (r1,r4,4), r4  # r4 = b[a[i & 3] & 3]

    #a[b[i & 3] & 3]
    ld (r1,r2,4), r7  # r7 = b[i & 3]
    and r6, r7        # r7 = b[i & 3] & 3
    ld (r0,r7,4), r7  # r7 = a[b[i & 3] & 3]

    #d[i]
    ld (r5,r3,4), r2  # r2 = d[i]

    #d[b[i]] = b[a[i & 3] & 3] - a[b[i & 3] & 3] + d[i]
    not r7            # ~a[b[i & 3] & 3]
    inc r7            # -a[b[i & 3] & 3]
    add r4, r7        # r7 = b[a[i & 3] & 3] - a[b[i & 3] & 3]
    add r7, r2        # r2 = b[a[i & 3] & 3] - a[b[i & 3] & 3] + d[i]
    ld (r1,r3,4), r1  # r1 = b[i]
    st r2, (r5,r1,4)  #d[b[i]] = b[a[i & 3] & 3] - a[b[i & 3] & 3] + d[i]

halt


.pos 0x1000
a:
.long 0    # the variable a[0]
.long 11   # the variable a[1]
.long 2    # the variable a[2]
.long 0    # the variable a[3]
.long 1    # the variable a[4]
.long 2    # the variable a[5]
.long 0    # the variable a[6]
.long 1    # the variable a[7]

b:
.long 2    # the variable b[0]
.long 12   # the variable b[1]
.long 0    # the variable b[2]
.long 2    # the variable b[3]
.long 1    # the variable b[4]
.long 0    # the variable b[5]
.long 2    # the variable b[6]
.long 1    # the variable b[7]

c:
.long 99   # the variable c[0]
.long 6    # the variable c[1]
.long 2    # the variable c[2]
.long 1    # the variable c[3]
.long 0    # the variable c[4]
.long 2    # the variable c[5]
.long 1    # the variable c[6]
.long 0    # the variable c[7]

i:
.long 5    # the variable i (5)

d:
.long c    # the variable d (address of c)
