.data  
Prompt: .asciiz "\n Please Input a value for N = "
Result: .asciiz "\nThe sum of the integers from 1 to N is: "
Bye: .asciiz "\n Bye"
floatingp: .asciiz "\n You entered a fraction"
integer: .asciiz "\n We use integer"     
     .globl main 
     .text 

main: 
    # Prints Prompt string to console
    li  $v0, 4
    la  $a0, Prompt
    syscall          
    # Gets Floating point input from user
    li  $v0, 6
    syscall
    
    mfc1 $t1, $f0  # Input stored in $f0
    srl $t2, $t1, 23
    add $s3, $t2, -127
    sll $t4, $t1, 9
    srl $t5, $t4, 9
    add $t6, $t5, 8388608
    add $t7, $s3, 9
    rol $t4, $t6, $t7
    li $t5, 31
    sub $t2, $t5, $s3
    sllv $t5, $t4, $t2
    srlv $s5, $t5, $t2
    # Integer Value is stored in $s5
    mtc1 $s5, $f2 # Stores Valur from $s5 to $f2
    cvt.s.w $f2, $f2
    c.eq.s $f0, $f2  # checks for inequality if($f0 == $f2)
    bc1f Floatingp
    b Loop
    # Does IEE74 Single Pressision
    blez $v0, End
    li   $t0, 0

Floatingp:
    la $a0, floatingp
    li $v0, 4
    syscall

    mov.s $f12, $f0
    li $v0, 2
    syscall   
    # cout<< floating value
    la $a0, integer
    li $v0, 4
    syscall
    move $a0, $s5
    li $v0, 1
    syscall
    #cout << integer value 

    li $t0, 0
    b Loop
        
Loop:
     add  $t0, $t0, $s5
     addi $s5, $s5, -1
     bnez $s5, Loop
     
     li   $v0, 4
     la   $a0, Result
     syscall 
     
     li  $v0, 1
     move $a0, $t0
     syscall
     b  main
     
End: li $v0, 4
     la $a0, Bye
     syscall 
     li $v0, 10
     syscall 
