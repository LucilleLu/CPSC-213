.pos 0x1000
    ld $s, r0      # r0 = the address of [0]s (2000)
    ld (r0), r0    # r0 = the address of d0[0] (2004)
    ld (r0), r1    # r1 = d0->d1 (the address of d1[0])
    ld 4(r0), r2   # r2 = d0->d2 (the address of d2[0])
    ld 4(r1), r3   # r3 = d1->a (a is the first int, b is the second int)
    st r3, (r2)    # d2->a = d1->b
    ld 4(r2), r3   # r3 = d2->b
    st r3, (r1)    # d1->a = d2->b
    halt                     

.pos 0x2000
s:  .long d0
# END OF STATIC ALLOCATION/Users/luxiuyuan/Documents/学习/University Courses/Second Year/CPSC213/Lab Assignment/Assignment 3/code/Part 1/a2_1.s

# DYNAMICALLY ALLOCATED HEAP SNAPSHOT
# (malloc'ed and dynamically initialized in c version)
d0: .long d1
    .long d2
d1: .long 1
    .long 2
d2: .long 3
    .long 4
