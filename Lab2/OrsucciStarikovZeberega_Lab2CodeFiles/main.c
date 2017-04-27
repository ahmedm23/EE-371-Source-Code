/*Name :- Kalkidan Zeberega, Daniel Starikov, Mitchell Orsucci
Title   : Working with C pointers
Summary : This program explores pointers and pointer variables.
          In addition, it explores references and dereferencing
          with an address and computes the result.
*/

#include <stdio.h>
#include <stdlib.h>

int main () {

    // Part 1: Getting to Know Pointers
    // The following list declare and initializes a variables of type int, float,
    // and char.
      int a = 3; //declare a variable of type int called a and initialize it to 3
	  int b = 21;
	  float c = 8.97; // declare a variable of type float called c and initialize it to 8.97
	  float d = -321.0;
	  char e = 'e'; // // declare a variable of type char called e and initialize it to 'e'
	  char f = 'f';

      int* xPtr; // declare a variable of type pointer to integer
	  float* yPtr; //declare a variable of type pointer to float
	  char* zPtr; // declare a variable of type pointer to char

	  xPtr = &a; // assign the address of x to a
	  printf("The value of a is = %d\n", *xPtr);
	  printf("The address of a is = %d\n\n", xPtr);

	  xPtr = &b;  //assign the address of x to b
	  printf("The value of b is = %d\n", *xPtr);
	  printf("The address of b is = %d\n\n", xPtr);

	  yPtr = &c; // assign the address of y to c
	  printf("The value of c is = %f\n", *yPtr);
	  printf("The address of c is= %d\n\n", yPtr);

      yPtr = &d;
      printf("The value of d is = %f\n", *yPtr);
	  printf("The address of d is = %d\n\n", yPtr);

    zPtr = &e;
    printf("The value of e is = %c\n", *zPtr);
    printf("The address of e is = %d\n\n", zPtr);

    zPtr = &f;
    printf("The value of f is = %c\n", *zPtr);
    printf("The address of f is = %d\n\n", zPtr);


	  // Part 2: Working with Pointer Variables

    int A = 22;
    int B = 17;
    int C = 6;
    int D = 4;
    int E = 9;
    int result = 0;

    int* aPtr = &A;
    int* bPtr = &B;
    int* cPtr = &C;
    int* dPtr = &D;
    int* ePtr = &E;
    int* rPrt = &result;

    result = ((*aPtr - *bPtr) * (*cPtr + *dPtr)) / (*ePtr);
    printf("result = %d\n", result);
    printf("The address of result is = %d\n\n", rPrt);

    return result;
}
