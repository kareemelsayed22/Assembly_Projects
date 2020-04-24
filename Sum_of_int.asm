#Program Name: Sum of Integers
#Programmer: Kareem El Sayed 
#Date: April 19th, 2018

.data

 Prompt: .asciiz "\n Please Input a Value for N =  "
 Result: .asciiz "The sum of the integers from 1 to N is"
 Bye:    .asciiz "\n **** Adios Amigo - Have a good day ****" 
         .globl  main
         .text
main: 

          li   $v0, 4    # Sysytem Call code for Print String 
          la   $a0, Prompt  #load address of Prompt into $a0
          syscall           # Print line prompt message 
          li   $v0, 5       # System Call for read Integer 
          syscall           # Reads the value of N into $v0
          blez $v0, End     # branch to end if $v0 < = 0
          li   $t0, 0       # Clear register $t0 to 0
          
Loop: 
          add  $t0, $t0, $v0  # Sum of integers in register $t0
          addi $v0, $v0, -1   # Summing integers in reverse order
          bnez $v0, Loop      # branch to loop if $v0 is != 0
          
          li   $v0, 4        # system call code for print string 
          la   $a0, Result   # load address of message into $a0
          syscall            # print the string 
          
          li   $v0, 1        # system call code for Print Integer
          move $a0, $t0      # move value to be printed to $a0
          syscall            # print sum of integers 
          b    main          # branch to main
          
End:      li   $v0, 4        # system call code for Print String 
          la   $a0, Bye      # load address of msg into $a0
          syscall            # print the string 
          li   $v0, 10       # terminate the program run and 
          syscall            # return control to system 
          