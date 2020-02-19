#Find prime numbers between 0 to 100

#PSEUDO CODE:
# While (n < 101): n == 0, n++;
# if n > 1 && n % 2 != 0: n is prime
# print all primes

        .data
msg:    .asciiz "First 100 prime numbers are: \n"
space:  .asciiz " "
        .text	

main:
        addi    $t0, $zero, 0
        addi    $t1, $zero, 2 #divider
        addi    $t2, $zero, 101 #first 100 nums 


        li      $v0, 4 #print string stored in "msg"
        la      $a0, msg
        syscall

test_prime:
        slt     $s0, $t0, $t2 #if t0 < 101, store 1 in s0, otherwise store 0

        beq     $s0, 0, exit #if s0 == 0, jump to exit

        ble     $t0, 1, iterator #if t0 <= 1, jump to iterator
        bge	$t0, 2, CheckRemainder	# if $t0 >= 2 then jump to CheckRemainder

CheckRemainder:
        div	$t0, $t1			# $t0 / $t1
        mflo	$t3				# $t3 = floor($t0 / $t1) 
        mfhi	$t4				# $t4 = $t0 mod $t1 

        bgt     $t4, 0, print #if t4 > 0, jump to print

        j        iterator

print: 
        li      $v0, 1 #print t0
        add     $a0, $zero, $t0
        syscall

        li      $v0, 4 #print string stored in "space"
        la      $a0, space
        syscall

        j       iterator

iterator:
        addi     $t0, $t0, 1 #t0 += 1

        j       test_prime #loop back to test_prime

exit:
        li      $v0, 10 #exit 
        syscall



