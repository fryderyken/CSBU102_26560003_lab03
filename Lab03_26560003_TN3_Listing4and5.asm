#Tr?n Tr?nh Quang Anh, 26560003, Computes total scores and pass counts for two classes
# Listing 4 & 5 - a small gradebook library
.data
classA: .word 72, 55, 90, 48, 63, 85, 39, 77, 60, 94
classB: .word 45, 81, 66, 50, 92, 38, 70, 59
msgA:   .asciiz "Class A total: "
msgB:   .asciiz "Class B total: "
passA:  .asciiz "Class A passed: "
passB:  .asciiz "Class B passed: "
nl:     .asciiz "\n"

.text
.globl main
main:
    la   $a0, classA            # argument 1: address of classA[0]
    addi $a1, $zero, 10         # argument 2: number of scores
    jal  sum_array              # $v0 = total of class A
    la   $a0, msgA              # load total message for class A
    add  $a1, $v0, $zero        # copy total into $a1 for show()
    jal  show

    la   $a0, classB            # argument 1: address of classB[0]
    addi $a1, $zero, 8          # argument 2: number of scores
    jal  sum_array              # $v0 = total of class B
    la   $a0, msgB              # load total message for class B
    add  $a1, $v0, $zero        # copy total into $a1 for show()
    jal  show

    la   $a0, classA            # argument 1: address of classA[0]
    addi $a1, $zero, 10         # argument 2: number of scores
    addi $a2, $zero, 67         # argument 3: pass mark M = 67 (test with 50 first for Step 3.2)
    jal  count_pass             # $v0 = number of passes in class A
    la   $a0, passA             # load pass message for class A
    add  $a1, $v0, $zero        # copy pass count into $a1 for show()
    jal  show

    la   $a0, classB            # argument 1: address of classB[0]
    addi $a1, $zero, 8          # argument 2: number of scores
    addi $a2, $zero, 67         # argument 3: pass mark M = 67 (test with 50 first for Step 3.2)
    jal  count_pass             # $v0 = number of passes in class B
    la   $a0, passB             # load pass message for class B
    add  $a1, $v0, $zero        # copy pass count into $a1 for show()
    jal  show

    li   $v0, 10                # syscall 10 exits the program
    syscall

# sum_array(addr = $a0, n = $a1): returns the sum of n words in $v0
sum_array:
    addi $v0, $zero, 0          # sum = 0
    addi $t0, $zero, 0          # i = 0
sum_loop:
    slt  $t1, $t0, $a1          # $t1 = 1 if i < n
    beq  $t1, $zero, sum_end    # exit loop when i >= n
    sll  $t2, $t0, 2            # $t2 = 4 * i
    add  $t2, $t2, $a0          # $t2 = address of element i
    lw   $t3, 0($t2)            # load element i into $t3
    add  $v0, $v0, $t3          # sum = sum + element i
    addi $t0, $t0, 1            # i = i + 1
    j    sum_loop
sum_end:
    jr   $ra                    # return to caller

# Listing 5 - count_pass, to be added to your TN3 file
# count_pass(addr = $a0, n = $a1, mark = $a2): count of words >= mark
count_pass:
    addi $v0, $zero, 0          # count = 0
    addi $t0, $zero, 0          # i = 0
cp_loop:
    slt  $t1, $t0, $a1          # $t1 = 1 if i < n
    beq  $t1, $zero, cp_end     # leave loop when i >= n
    sll  $t2, $t0, 2            # $t2 = 4 * i (byte offset)
    add  $t2, $t2, $a0          # $t2 = address of element i
    lw   $t3, 0($t2)            # load element i into $t3
    slt  $t1, $t3, $a2          # $t1 = 1 if element < mark
    bne  $t1, $zero, cp_next    # if element < mark, skip counting
    addi $v0, $v0, 1            # otherwise element >= mark, count = count + 1
cp_next:
    addi $t0, $t0, 1            # i = i + 1
    j    cp_loop
cp_end:
    jr   $ra                    # return to caller

# show(msg = $a0, value = $a1): prints msg, value and a new line
show:
    li   $v0, 4                 # $a0 already holds the address of msg
    syscall
    li   $v0, 1                 # syscall 1 prints an integer
    add  $a0, $a1, $zero        # move value into $a0 to print
    syscall
    li   $v0, 4                 # syscall 4 prints newline
    la   $a0, nl
    syscall
    jr   $ra                    # return to caller