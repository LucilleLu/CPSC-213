.pos 0x0  # start
                 ld   $sb, r5   # initialize stack pointer
                 inca r5        # r5 = deallocate
                 gpc  $6, r6    # r6 = return address
                 j    0x300     # goto adress 0x300 (main)
                 halt                     
.pos 0x100 # array
                 .long 0x00001000  # &v
.pos 0x200 # foo
                 ld   0x0(r5), r0        # r0 = c = a3
                 ld   0x4(r5), r1        # r1 = d = a4
                 ld   $0x100, r2         # r2 = address that store the &v
                 ld   0x0(r2), r2        # r2 = &v
                 ld   (r2, r1, 4), r3    # r3 = v[d]
                 add  r3, r0             # r0 = v[d] + c
                 st   r0, (r2, r1, 4)    # v[d] = v[d] + c
                 j    0x0(r6)            # return to caller
.pos 0x300 # main
                 ld   $0xfffffff4, r0    # r0 = -12
                 add  r0, r5             # allocate space for arguments and return address
                 st   r6, 0x8(r5)        # store return address on stack
                 ld   $0x1, r0           # r0 = 1 ＝ value of a0
                 st   r0, 0x0(r5)        # save value of a0 to stack
                 ld   $0x2, r0           # r0 = 2 ＝ value of a1
                 st   r0, 0x4(r5)        # save value of a1 to stack
                 ld   $0xfffffff8, r0    # r0 = -8
                 add  r0, r5             # allocate space
                 ld   $0x3, r0           # r0 = 3 ＝ value of a3
                 st   r0, 0x0(r5)        # save value of a3 to stack
                 ld   $0x4, r0           # r0 = 4 ＝ value of a4
                 st   r0, 0x4(r5)        # save value of a4 to stack
                 gpc  $6, r6             # r6 = return address
                 j    0x200              # goto adress 0x200 (foo)
                 ld   $0x8, r0           # r0 = 8
                 add  r0, r5             # deallocate
                 ld   0x0(r5), r1        # r1 = a = 1
                 ld   0x4(r5), r2        # r2 = b = 2
                 ld   $0xfffffff8, r0    # r0 = -8
                 add  r0, r5             # allocate space
                 st   r1, 0x0(r5)        # c = a
                 st   r2, 0x4(r5)        # d = b
                 gpc  $6, r6             # r6 = return address
                 j    0x200              # goto adress 0x200 (foo)
                 ld   $0x8, r0           # r0 = 8
                 add  r0, r5             # deallocate
                 ld   0x8(r5), r6        # r6 = return address
                 ld   $0xc, r0           # r0 = 12
                 add  r0, r5             # deallocate
                 j    0x0(r6)            # return to caller (start)


.pos 0x1000
# array v
                 .long 0x00000000  # v[0]
                 .long 0x00000000  # v[1]
                 .long 0x00000000  # v[2] .long 0x00000001
                 .long 0x00000000  # v[3]
                 .long 0x00000000  # v[4] .long 0x00000003
                 .long 0x00000000  # v[5]
                 .long 0x00000000  # v[6]
                 .long 0x00000000  # v[7]
                 .long 0x00000000  # v[8]
                 .long 0x00000000  # v[9]
.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0   #c=3(old), c=1(new)  r0
    .long 0
    .long 0
    .long 0
    .long 0   #d=4(old), d=2(new)  r1 (old)
    .long 0
    .long 0
    .long 0
    .long 0   #a=1 r1 (new)
    .long 0
    .long 0
    .long 0
    .long 0   #b=2 r2
    .long 0
    .long 0
    .long 0
    .long 0   #ra
    .long 0
    .long 0
sb: .long 0
