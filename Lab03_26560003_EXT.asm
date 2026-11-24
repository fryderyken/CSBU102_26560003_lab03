#Tr?n Tr?nh Quang Anh, 26560003, Finds minimum and maximum scores for two classes
# Extension - min_max procedure returning two values
.data
classA: .word 72, 55, 90, 48, 63, 85, 39, 77, 60, 94
classB: .word 45, 81, 66, 50, 92, 38, 70, 59
minA:   .asciiz "Class A min: "
maxA:   .asciiz "Class A max: "
minB:   .asciiz "Class B min: "
maxB:   .asciiz "Class B max: "
nl:     .asciiz "\n"

.text
.globl main
main:
    la   $a0, classA            # argument 1: address of classA[0]
    addi $a1, $zero, 10         # argument 2: number of scores
    jal  min_max                # $v0 = min, $v1 = max
    add  $s0, $v1, $zero        # save max in $s0 before show overwrites registers
    la   $a0, minA              # print Class A min (39)
    add  $a1, $v0, $zero
    jal  show
    la   $a0, maxA              # print Class A max (94)
    add  $a1, $s0, $zero
    jal  show

    la   $a0, classB            # argument 1: address of classB[0]
    addi $a1, $zero, 8          # argument 2: number of scores
    jal  min_max                # $v0 = min, $v1 = max
    add  $s0, $v1, $zero        # save max in $s0 before show overwrites registers
    la   $a0, minB              # print Class B min (38)
    add  $a1, $v0, $zero
    jal  show
    la   $a0, maxB              # print Class B max (92)
    add  $a1, $s0, $zero
    jal  show

    li   $v0, 10                # exit program
    syscall

# min_max(addr = $a0, n = $a1): returns min in $v0 and max in $v1
min_max:
    lw   $v0, 0($a0)            # start min with first element
    add  $v1, $v0, $zero        # start max with first element
    addi $t0, $zero, 1          # i = 1
mm_loop:
    slt  $t1, $t0, $a1          # $t1 = 1 if i < n
    beq  $t1, $zero, mm_end     # exit loop when i >= n
    sll  $t2, $t0, 2            # $t2 = 4 * i
    add  $t2, $t2, $a0          # $t2 = address of element i
    lw   $t3, 0($t2)            # load element i into $t3
    slt  $t1, $t3, $v0          # $t1 = 1 if element < min
    beq  $t1, $zero, check_max  # skip if element >= min
    add  $v0, $t3, $zero        # update min
check_max:
    slt  $t1, $v1, $t3          # $t1 = 1 if max < element
    beq  $t1, $zero, mm_next    # skip if element <= max
    add  $v1, $t3, $zero        # update max
mm_next:
    addi $t0, $t0, 1            # i = i + 1
    j    mm_loop
mm_end:
    jr   $ra                    # return to caller

# show(msg = $a0, value = $a1): prints msg, value and a new line
show:
    li   $v0, 4                 # $a0 already holds address of msg
    syscall
    li   $v0, 1                 # print integer value
    add  $a0, $a1, $zero
    syscall
    li   $v0, 4                 # print newline
    la   $a0, nl
    syscall
    jr   $ra                    # return to caller