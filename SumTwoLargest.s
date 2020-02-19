#Write and test a program that reads in three integers
#and prints out the sum of the largest two of the three.  
#You can break ties arbitrarily.
#For example, input = {2, 9, 4} 
#then output should be 13 as 9, 4 are the two largest of three.
#Write and test an adding machine program that repeatedly reads in integers 
#and adds them into a running sum. 
#The program should stop when it gets an input that is 0, 
#printing out the sum at that point.


#PSEUDO CODE:
#For loop takes 3 integers from user
#Store inputs as array
#sort array in descending order
#calculate the sum of array and minus the last number in the array to get final result

        .data
Array:  .space 12 #store 3 int, each 4 bites
msg:    .asciiz "Enter 3 integers: \n"
sum:    .asciiz "Sum of two largest is: "
        .text		


main: 
        addi    $t0, $t0, 12 #array size constant
        addi    $t4, $t4, 90 #loop counter

        li      $v0, 4 #print string stored in "msg"
        la      $a0, msg
        syscall

input: 
        beq     $t1, $t0, continue #continue to take input if in arange 

        li      $v0, 5 #take user input
        syscall      
        move    $t2, $v0
        beq     $t2, 0, reinitialize  #end loop if input == 0


        sw      $v0, Array($t1)
                addi    $t1, $t1, 4 #move to next index

        j       input

continue:
        #reinitialize register
        move    $t1, $zero #for array(x)
        move    $t2, $zero 

        addi    $t2, $t2, 4 #move index

        move    $s0, $zero # for condition check at line 68
        addi    $s0, $s0, 1

sort:   
        beq     $t3, $t4, reinitialize #end loop 

        beq     $t2, $t0, continue #check if reached end of array or not

        lw      $t5, Array($t1) #t5 = array[0]
        lw      $t6, Array($t2) #t6 = array[1]

        addi    $t3, $t3, 1 #update loop counter

        slt     $t7, $t5, $t6 #if t5 < t6 -> true, store 1 in t7, otherwise store 0 in t7
        beq     $t7, $s0, swap #if t7 = 1, jump to swap

        #move index
        addi    $t1, $t1, 4
        addi    $t2, $t2, 4

        j sort 

swap: 
        #sort elements in descending order
        sw      $t5, Array($t2) #store t5 value in array [x+1]
        sw      $t6, Array($t1) #store t5 value in array [x]

        #move index
        addi    $t1, $t1, 4
        addi    $t2, $t2, 4

        j       sort #go back to sort after done sorting 

reinitialize:
        #reinitialize register
        move    $t1, $zero #array element
        move    $t2, $zero #temp holder
        
        move    $t3, $zero
        addi    $t3, $t3, 8 #last array element 

        move    $t4, $zero  #min value holder
       
AddSum:

        #sum all nums together
        beq     $t1, $t0, EndLoop #if element reach the end of array, jump to EndLoop
        lw      $t2, Array($t1) #t2 = Array[t1]
        addi    $t1, $t1, 4 #update to next index of array
        add     $s1, $s1, $t2 #sum all array elements into s1

        j       AddSum

EndLoop:
        
        lw      $t4, Array($t3)         #assign last value of array to t4
        sub     $s1, $s1, $t4		# $s1 = $s1 - $t4 (get sum of 2 largest)
        

        li      $v0, 4 #print string stored in "sum"
        la      $a0, sum
        syscall

        move    $a0, $s1 #print s1 value 
        li      $v0, 1
        syscall

        li      $v0, 10 #exit 
        syscall
