#include <stdio.h>

int main(void) {
   float mfact_cost = 0;
   float dealer_markup = 0;
   float sales_tax = 0;
   float discount = 0;

   // Prompt user for data
   printf("Manufacturer's cost?\t\t");
   scanf("%f", &mfact_cost);

   printf("Dealer markup? (percentage)\t");
   scanf("%f", &dealer_markup);

   printf("Sales tax? (percentage)\t\t");
   scanf("%f", &sales_tax);

   printf("Pre-tax discount? (percentage)\t");
   scanf("%f", &discount);

   // Convert percentages to decimal
   dealer_markup = dealer_markup / 100;
   sales_tax = sales_tax / 100;
   discount = discount / 100;

   // Compute cost from data
   float subtotal = mfact_cost * (1 + dealer_markup) * (1 - discount);
   float total = subtotal * (1 + sales_tax);

   // Print estimated price
   printf("Estimated Price:\t\t$%0.2f\n", total);

   return 0;
}
