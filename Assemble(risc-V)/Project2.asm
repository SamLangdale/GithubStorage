#takes an array and another array containing indexes and rearranges the first array based off the indexes
# 12,10,8,9,5,1,111,0,34,23



.data
    array:
     .word 10, 12, 9, 8, 1, 5, 23, 34, 0, 111
     indx:
      .word 1, 0, 3, 2, 5, 4, 9, 8, 7, 6
.text
    la t1, array #loads array into t1
    la t2, indx #loads indx into t2
    addi s1, x0, 0 #i = 0
    addi t3, x0, 10 # t3 = 10 (length of array)
    addi sp, sp, -40 #allocates 40 bytes (10 int) on the stack
    addi t4, x0, 0 #initialize address holder array1
    addi t5, x0, 0 #initialize address holder temp

    #copy array(t1) into arrayclone(sp)
for: 
    bge s1, t3, done #finished after s1 = 10
    Slli t0,s1,2 #shift binary left 2 (multiply by 4)
    add t4, t0, t1 #t4 now holds the address we want to copy
    add t5, t0, sp #t5 now holds the address we want to save to
    lw t6, 0(t4)  #loads the word in array1(t4) to t6
    sw t6, 0(t5) #saves that word into copyarray(sp)
    addi s1, s1, 1 #i++
    j  for #loop
done:
    addi s1, x0, 0 # i=0


for2:
    bge s1, t3, finish #finished after s1 = 10
    Slli t0,s1,2 #shift binary left 2 (multiply by 4)
    add t4, t0, t1 #t4 now holds the address of array1 we want to change
    #add t5, t0, sp #t5 contains the adress of arraycopy
    add t6, t0, t2 #t6 contains the address of the index array
    lw s2, 0(t6) #s2 is now the integer from the index
    slli t0, s2, 2 #multyplied by 4 to get the address offset of the index in array1
    add s3, t0, sp # s3 contains the address of the index we want to copy
    lw s4, 0(s3) #loads the number we want into s4
    addi  a7, x0, 1    #  arg for int_print
    add   a0, x0, s4    # putting s4 as the number we want to print
    ecall               # syscall
    addi  a7, x0, 11    #  arg for int_print
    addi   a0, x0, ','    # putting s4 as the number we want to print
    ecall
    sw s4, 0(t4)# saves s4 into array1
    addi s1, s1, 1 #i++
    j for2
finish:
    
    
