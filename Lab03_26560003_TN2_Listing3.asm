#Tr?n Tr?nh Quang Anh, 26560003, Clamps an input score between zero and one hundred
# Listing 3 - clamp(x, lo, hi) 
.text
.globl main
main:
    li   $v0, 5                 # read an integer x into $v0
    syscall
    add  $a0, $v0, $zero        # argument 1: x
    addi $a1, $zero, 0          # argument 2: lo = 0
    addi $a2, $zero, 100        # argument 3: hi = 100
    jal  clamp
    add  $a0, $v0, $zero        # print the result
    li   $v0, 1
    syscall
    li   $v0, 10
    syscall

# clamp(x = $a0, lo = $a1, hi = $a2): returns x limited to [lo, hi] in $v0
clamp:
    add  $v0, $a0, $zero        # start by assuming result = x
    slt  $t0, $a0, $a1          # set $t0 = 1 if x < lo
    beq  $t0, $zero, check_hi   # if x >= lo, check upper limit
    add  $v0, $a1, $zero        # otherwise x < lo, so result = lo
    j    clamp_end              # skip the hi check
check_hi:
    slt  $t0, $a2, $a0          # set $t0 = 1 if hi < x (x > hi)
    beq  $t0, $zero, clamp_end  # if x <= hi, keep current result
    add  $v0, $a2, $zero        # otherwise x > hi, so result = hi
clamp_end:
    jr   $ra                    # return to caller