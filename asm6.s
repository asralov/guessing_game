# Author: Abrorjon Asralov
# Class: CSC252 Spring 2024
# Description: This is a guesser game
.data 
	LINE0: .asciiz "||==============================================================================================================================||\n"
	LINE1: .asciiz "||  ######   ##     ##  #######   ######    ######   #######  ##     ##    ######        ######      ##     ##       ##  #######||\n"
	LINE2: .asciiz "|| ##    ##  ##     ##  ##       ##    ##  ##    ##     ##    ###    ##   ##    ##      ##    ##    ####    ###     ###  ##     ||\n"
	LINE3: .asciiz "||##         ##     ##  ##       ##        ##           ##    ####   ##  ##            ##          ##  ##   ####   ####  ##     ||\n"
	LINE4: .asciiz "||##   ####  ##     ##  #######   ######    ######      ##    ## ##  ##  ##   ####     ##   ####  ##    ##  ## ## ## ##  #######||\n"
	LINE5: .asciiz "||##    ##   ##     ##  ##             ##        ##     ##    ##  ## ##  ##    ##      ##    ##   ########  ##  ###  ##  ##     ||\n"
	LINE6: .asciiz "|| ##   ##   ##     ##  ##       ##    ##  ##    ##     ##    ##   ####   ##   ##       ##   ##   ##    ##  ##   #   ##  ##     ||\n"
	LINE7: .asciiz "||  #####     #######   #######   ######    ######   #######  ##    ###    #####         #####    ##    ##  ##       ##  #######||\n"
        AUTHR: .asciiz "||=======================================================BY=ABRORJON=ASRALOV====================================================||\n"
        INTRO: .asciiz "Greetings, human! Prepare to be outsmarted by a random number generator.\n"
        DESCR: .asciiz "The randomizer, in its infinite wisdom (or lack thereof), has conjured a\nnumber from the depths of its digital mind. Are you brave enough to face\nits numerical challenge? (Enter 1 if you accept the challenge, 0 otherwise) "
        EXIT_MSG: .asciiz "The mystery remains unsolved, but the game is never truly over. The randomizer whispers, 'Until next time...'\n"
        ACCEPTED: .asciiz "\nThe gauntlet has been thrown! You, brave adventurer, have accepted the challenge\nto decipher the secrets of the randomizer. May your guesses be ever in your favor...\nbecause the randomizer certainly isn't playing fair!\n"
        PROMPT_UPPER_BOUND: .asciiz "\nTime to set the stage for numerical chaos! Choose a number, any positive number\n(well, not ANY number... let's keep it reasonable), and the randomizer will unleash\na secret value within its domain. Choose wisely, or face the consequences of a\nridiculously difficult game! "
	GUESS: .asciiz "\nEnter The Mysterious Number: "
	USER_GUESSED: .asciiz "Wow, you actually guessed it! Either you're a mind reader, or the randomizer is getting rusty.\n"
	HIGH_MSG: .asciiz "Whoa there, buddy! Your guess just flew past the number and is now orbiting Mars. Aim a little lower!\n"
	LOW_MSG: .asciiz "Brrr, that guess is colder than a penguin in Antarctica! Try a higher number to warm things up.\n"
	ANOTHER_GAME: .asciiz "\nDid that tickle your guessing bone? Enter 1 to dive back into the number-guessing madness, or 0 to\nreturn to the mundane world of certainty. "
	REVEAL: .asciiz "\nThe number that played hide-and-seek with your sanity is finally revealed: "
	WRONG_MSG: .asciiz "\nHouston, we have a problem. Your number is out of orbit! Try again.\n"
	BYE_MSG: .asciiz "\nAh, a strategic retreat! The randomizer will miss your valiant attempts to decipher its numerical secrets.\nUntil next time, may your days be filled with certainty and your nights free of number-guessing nightmares!\n"
.text
.globl main
main:
	# this is a main function we run our guesser game
	addiu $sp, $sp, -24
	sw $ra, 4($sp)
	sw $fp, 0($sp)
	addiu $fp, $sp, 20
	
	
	# PRINTING GAME NAME MESSAGE
	addi $v0, $zero, 4
	la $a0, LINE0
	syscall
	
	addi $v0, $zero, 4
	la $a0, LINE1
	syscall
	
	addi $v0, $zero, 4
	la $a0, LINE2
	syscall
	
	addi $v0, $zero, 4
	la $a0, LINE3
	syscall
	
	addi $v0, $zero, 4
	la $a0, LINE4
	syscall
	
	addi $v0, $zero, 4
	la $a0, LINE5
	syscall
	
	addi $v0, $zero, 4
	la $a0, LINE6
	syscall
	
	addi $v0, $zero, 4
	la $a0, LINE7
	syscall
	
	addi $v0, $zero, 4
	la $a0, AUTHR
	syscall
	
	addi $v0, $zero, 11
	addi $a0,$zero, 10
	syscall
	
	addi $v0, $zero, 4
	la $a0, INTRO
	syscall
	
	addi $v0, $zero, 4
	la $a0, DESCR
	syscall

	# getting user's input
	addi $v0, $zero, 5
	syscall
	
	# if it is 0, then go to the EXIT
	beq $v0, $zero, EXIT
	
	# ACTUALLY STARTING THE GAME
	addi $v0, $zero, 4
	la $a0, ACCEPTED
	syscall
	
	
	# asking for user's input that is going to be a positive integer N
	addi $v0, $zero, 4
	la $a0, PROMPT_UPPER_BOUND
	syscall
	
	addi $v0, $zero, 11
	addi $a0,$zero, 10
	syscall
	
	
	# user_input
	addi $v0, $zero, 5
	syscall
	
	add $t0, $zero, $v0		# saving the upper bound N to be equal to t0
	addi $t0, $t0, 1
	
	
	
	# the start of the game
	GAME_LOOP:
	
	# calling a random number generator
	addi $v0, $zero, 42		# getting a random integer and $a0 has got it now.
	add $a1, $zero, $t0
	syscall 

	add $t1, $zero, $a0		# saving t1 to be random number

	# a game loop where user can keep guessing till he finds the correct number
	GUESS_LOOP:
	addi $v0, $zero, 4
	la $a0, GUESS
	syscall
	
	# get user's input
	addi $v0, $zero, 5
	syscall
	
	add $t2, $zero, $v0		# t2 = user_input  
	
	addi $v0, $zero, 11
	addi $a0, $zero, 10
	syscall 
	
	addi $t3, $t0, 1
	# checking if user entered invalid range numnber
	slt $t3, $t2, $t3		# t3 = range < user_input, if true, goto WRONG_RANGE user_input > range    -> user_input <= range
	beq $t3, $zero, WRONG_RANGE							    # range > user_input   -> range <= user_input 
	
	slt $t3, $t2, $zero		# t3 = user_input < 0, if true, goto WRONG_RANGE
	bne $t3, $zero, WRONG_RANGE
	
	
	# checking if user_input - random_num == 0. If true, goto GUESSED
	sub $t3, $t2, $t1
	
	beq $t3, $zero, GUESSED		# if user_input == rand_num => goto GUESSED
	
	slt $t4, $t2, $t1		# t2 = user < rand_num considering the first equal check
	
	addi $t5, $zero, 1
	beq $t4, $t5, GUESS_LOW
	
	# otherwise, if it does not pass equal check and second check, it must be
	# third case
	addi $v0, $zero, 4
	la $a0, HIGH_MSG
	syscall
	j GUESS_LOOP
	
	# calling to print a message that says that user is out of the range
	WRONG_RANGE:
	addi $v0, $zero, 4
	la $a0, WRONG_MSG
	syscall
	
	# get back to guessing loop
	j GUESS_LOOP
	
	
	# when user is done and found the number, then we can re-ask whether
	# he wants to keep playing or just leave
	ASK_FOR_ANOTHER_GAME:
	# prompt for another game 
	addi $v0, $zero, 4
	la $a0, ANOTHER_GAME
	syscall
	
	# get user's input
	addi $v0, $zero, 5
	syscall
	bne $v0, $zero, GAME_LOOP
	# if user does not want that we are sending him to a last message
	j LAST_MSG
	
	# if user's input is less than chosen random number, we want to let user know 
	# that his guess should be higher
	GUESS_LOW:
	addi $v0, $zero, 4
	la $a0, LOW_MSG
	syscall
	j GUESS_LOOP
	
	# if yser'r input is equal to the chosen random number, we want to let user 
	# know, and that he guessed and we want to re-ask user whether he wants to 
	# play again
	GUESSED:
	addi $v0, $zero, 4
	la $a0, USER_GUESSED
	syscall
	
	# showing what was the mysterious number  hidden over there
	addi $v0, $zero, 4
	la $a0, REVEAL
	syscall
	
	addi $v0, $zero, 1
	add $a0, $zero, $t1
	syscall
	
	addi $v0, $zero, 11
	addi $a0, $zero, 10
	syscall
	
	# jumping to ask for another game
	j ASK_FOR_ANOTHER_GAME
	
	
	# printing last message
	LAST_MSG:
	addi $v0, $zero, 4
	la $a0, BYE_MSG
	syscall
	j DONE
	
	# if user decides to exit the game before even starting.
	EXIT:
	addi $v0, $zero, 4
	la $a0, EXIT_MSG
	syscall
	j DONE
	
	# epilogue and we are done with the program if we want to execute the program
	DONE:
	addi $v0, $zero, 10
	syscall
	
	lw $fp, 0($sp)
	lw $ra, 4($sp)
	addiu $sp, $sp, 24
	jr $ra
