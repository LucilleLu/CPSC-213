
# t = val[i]
ld $i, r0        # r0 = the address of i
ld 0(r0),r0      # r0 = i
ld $val, r1      # r1 = the address of val
ld (r1,r0,4), r2 # r2 = val[i]

# val[i] = val[j]
ld $j, r3        # r3 = the address of j
ld 0(r3),r3      # r3 = j
ld (r1,r3,4), r4 # r4 = val[j]
st r4,(r1,r0,4)  # val[i] = val[j]

# val[j] = t
st r2, (r1,r3,4) # val[j] = t

halt

.pos 0x1000

i:
 .long 3          # the variable i

j:
 .long 2          # the variable j

val:
 .long 10         # the variable val[0]
 .long 24         # the variable val[1]
 .long 3          # the variable val[2]
 .long 50         # the variable val[3]
