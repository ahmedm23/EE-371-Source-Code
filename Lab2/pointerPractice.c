
#include <stdio.h>

int main() {
   int A = 22;
   int B = 17;
   int C = 6;
   int D = 4;
   int E = 9;

   int result = 0;

   int *Aptr = &A;
   int *Bptr = &B;
   int *Cptr = &C;
   int *Dptr = &D;
   int *Eptr = &E;

   result = ((*Aptr - *Bptr) * (*Cptr + *Dptr)) / *Eptr;

   printf("result = %d\n", result);

   return 0;
}
