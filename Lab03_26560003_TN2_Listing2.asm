#Tr?n Tr?nh Quang Anh, 26560003, Finds the larger of two numbers using max2 procedure
#Listing 2  - max2(a, b) returns the larger of a and b
.text
.globl main
main:
    addi $a0, $zero, 15         # load first argument a = 15
    addi $a1, $zero, 42         # load second argument b = 42
    jal  max2                   # call max2(15, 42), result returns in $v0
    add  $a0, $v0, $zero        # save result into $a0 before $v0 gets overwritten
    li   $v0, 1                 # syscall 1 prints an integer
    syscall

    addi $a0, $zero, -7         # load new argument a = -7
    addi $a1, $zero, -3         # load new argument b = -3
    jal  max2                   # call max2(-7, -3)
    add  $s1, $v0, $zero        # store the second result in $s1
    li   $v0, 10                # syscall 10 exits the program
    syscall

# max2(a = $a0, b = $a1): returns the larger one in $v0
max2:
    add  $v0, $a0, $zero        # assume a is larger: result = a
    slt  $t0, $a0, $a1          # set $t0 = 1 if a < b
    beq  $t0, $zero, max2_end   # if a >= b, skip updating $v0
    add  $v0, $a1, $zero        # otherwise b is larger: result = b
max2_end:
    jr   $ra                    # return to caller