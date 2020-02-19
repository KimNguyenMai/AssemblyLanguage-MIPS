#Write and test an adding machine program that repeatedly reads in integers 
#and adds them into a running sum. 
#The program should stop when it gets an input that is 0, 
#printing out the sum at that point.
           
        
        .data
input:  .asciiz "Enter a number: \n"
sum:    .asciiz "Sum is: "
        .text

main: 
while:

        li      $v0, 4 #print string stored in "input"
        la      $a0, input
        syscall
        
        li      $v0, 5 #take user input then store in t0
        syscall
        move    $t0, $v0

        beq     $t0, 0, exit #if t0 == 0 -> jump to "exit"
                        #otherwise contiune to next line
        
        add    $t1, $t1, $t0 #add the inputs together and store in t1

        j		while

exit:
        li      $v0, 4
        la      $a0, sum #print string stored in "sum"
        syscall

        li      $v0, 1 #print value of t1 that was now moved to a0
        move    $a0, $t1
        syscall

        li      $v0, 10
        syscall

