.data

 num: .word 10, 12, 0
 result_s: .asciiz "The result is: " 
 error_s: .asciiz "Multiplication error"

.text

main:
 ######  NUMBERS TO BE MULTIPLIED
 
addi $s1, $zero, 40      #First number in S1
addi $s2, $zero, 3     #Second number in S2

mult $s1, $s2,  #Error correction
mflo $t6        #T6 error check
addi $t5, $zero, 0 #initialising T5 to zero

and $t3, $s1, 1
beq $t3, 1, addition 

 while:
	beq  $s1, 1, exit #while loop condition
	
	srl $s1, $s1, 1 #division by 2
	
	sll $s2, $s2, 1 # multiply second number by 2 and overwrite register s2
	
	and $t3, $s1, 1
	beq $t3, 1, addition
	
	j while 
 exit:
  
  beq $t5, $t6, resultMessage
  bne $t5, $t6, errorMessage
  
  li $v0, 1
  add $a0, $zero , $t5     # result
  syscall

 li $v0,10
 syscall  #end of program

#########################
#Functions 

addition:
	add $t5, $s2, $t5
	
	j while #jump to while

resultMessage:
	li $v0, 4
	la $a0,result_s
	syscall
	
	 li $v0, 1
         add $a0, $zero , $t5     # result
          syscall

     li $v0,10
     syscall  #end of program


errorMessage: 
	li $v0, 4
	la $a0,error_s
	syscall

	 li $v0,10
         syscall  #end of program

