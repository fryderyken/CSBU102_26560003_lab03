#Tr?n Tr?nh Quang Anh, 26560003, prints a score report with star and dash lines
# Listing 1 - one procedure, called from two places 

.data 
title:    .asciiz "SCORE REPORT\n" 
endMsg:   .asciiz "END\n" 
line:     .asciiz "----------\n" 
starLine: .asciiz "**********\n"      # added string for the star border

.text 
.globl main 
main: 
    jal  stars              # call stars first to print the top border

    li   $v0, 4             # syscall 4 prints a string
    la   $a0, title         # load "SCORE REPORT\n"
    syscall 

    jal  sep                # call sep to print the middle dash line

    li   $v0, 4 
    la   $a0, endMsg        # load "END\n"
    syscall 

    jal  stars              # replaced the 2nd jal sep with jal stars for bottom border

    li   $v0, 10            # syscall 10 exits the program
    syscall 

# sep: prints a separator line 
sep: 
    li   $v0, 4 
    la   $a0, line          # load "----------\n"
    syscall 
    jr   $ra                # return to the caller

# stars: prints a star separator line
stars:
    li   $v0, 4             # set syscall to print string
    la   $a0, starLine      # load "**********\n"
    syscall
    jr   $ra                # jump back to the return address in $ra