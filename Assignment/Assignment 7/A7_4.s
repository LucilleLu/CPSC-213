.pos 0x0 #main
main:
                 ld   $0x1028, r5         # initialize stack pointer
                 ld   $0xfffffff4, r0     # r0 = -12
                 add  r0, r5              # allocate space (decrement stack pointer by 12)
                 ld   $0x200, r0          # r0 = &x
                 ld   0x0(r0), r0         # r0 = x
                 st   r0, 0x0(r5)         # a = x
                 ld   $0x204, r0          # r0 = &x[1]
                 ld   0x0(r0), r0         # r0 = x[1]
                 st   r0, 0x4(r5)         # b = x[1]
                 ld   $0x208, r0          # r0 = &x[2]
                 ld   0x0(r0), r0         # r0 = x[2]
                 st   r0, 0x8(r5)         # c = x[2]
                 gpc  $6, r6              # r6 = return address
                 j    0x300               # goto F2 (call foo(x[1], x[2], x[3]))
                 ld   $0x20c, r1          # r1 = &result
                 st   r0, 0x0(r1)         # r1 = result
                 halt                     # halt program
.pos 0x200 # x
                 .long 0x00000000         #x[0]
                 .long 0x00000000         #x[1]
                 .long 0x00000000         #x[2]
                 .long 0x00000000         #x[3] (result)
.pos 0x300 # foo
foo:
                 ld   0x0(r5), r0         # r0 = a
                 ld   0x4(r5), r1         # r1 = b
                 ld   0x8(r5), r2         # r2 = c
                 ld   $0xfffffff6, r3     # r3 = -10
                 add  r3, r0              # r0 = a-10
                 mov  r0, r3              # r3 = a-10
                 not  r3                  # r3 = ~(a-10)
                 inc  r3                  # r3 = -(a-10)=10-a
                 bgt  r3, L6              # goto L6(default) if a<10
                 mov  r0, r3              # r3 = a-10
                 ld   $0xfffffff8, r4     # r4 = -8
                 add  r4, r3              # r3 = a-18
                 bgt  r3, L6              # goto L6(default) if a>18
                 ld   $0x400, r3          # r3 = &jumptable
                 j    *(r3, r0, 4)        # goto jumptable[a-10]
.pos 0x330
case10:          add  r1, r2              # r2 = c+b
                 br   L7                  # goto end
case12:          not  r2                  # r2 = ~c
                 inc  r2                  # r2 = -c
                 add  r1, r2              # r2 = b-c
                 br   L7                  # goto end
case14:          not  r2                  # r2 = ~c
                 inc  r2                  # r2 = -c
                 add  r1, r2              # r2 = b-c
                 bgt  r2, L0              # goto L0 if b>c
                 ld   $0x0, r2            # r2 = 0
                 br   L1                  # goto L1
L0:              ld   $0x1, r2            # r2 = 1
L1:              br   L7                  # goto end
case16:          not  r1                  # r1 = ~b
                 inc  r1                  # r1 = -b
                 add  r2, r1              # r1 = c-b
                 bgt  r1, L2              # goto L2 if c>b
                 ld   $0x0, r2            # r2 ＝ 0
                 br   L3                  # goto L3
L2:              ld   $0x1, r2            # r2 = 1
L3:              br   L7                  # goto end
case18:          not  r2                  # r2 = ~c
                 inc  r2                  # r2 = -c
                 add  r1, r2              # r2 = b-c
                 beq  r2, L4              # goto L4 if b==c
                 ld   $0x0, r2            # r2 = 0
                 br   L5                  # goto L5
L4:              ld   $0x1, r2            # r2 = 1
L5:              br   L7                  # goto end

#default
L6:              ld   $0x0, r2            # r2 = 0
                 br   L7                  # goto end
#end
L7:              mov  r2, r0              # r0 = 0
                 j    0x0(r6)             # return (main)
.pos 0x400 # jumptable
                 .long 0x00000330         # case a == 10   jumptable[0]
                 .long 0x00000384         # case default   jumptable[1]
                 .long 0x00000334         # case a == 12   jumptable[2]
                 .long 0x00000384         # case default   jumptable[3]
                 .long 0x0000033c         # case a == 14   jumptable[4]
                 .long 0x00000384         # case default   jumptable[5]
                 .long 0x00000354         # case a == 16   jumptable[6]
                 .long 0x00000384         # case default   jumptable[7]
                 .long 0x0000036c         # case a == 18   jumptable[8]
.pos 0x1000 # stack
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000
                 .long 0x00000000         
                 .long 0x00000000         
