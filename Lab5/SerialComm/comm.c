
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include <unistd.h>

#define LEDR             ((char*) 0x00011090)
#define data_out         ((char*) 0x00011050)
#define data_in          ((char*) 0x00011010)
#define tx_enable        ((char*) 0x00011040)
#define char_complete_tx ((char*) 0x00011030)
#define load             ((char*) 0x00011020)

char getParityBit(char);

int main() {
   while (1) {
      alt_putstr("Enter 's' to send or 'r' to receive a character\n");
      char choice = alt_getchar();
      if (choice == 's') {
         alt_putstr("Type a character to send: ");
         char ch = alt_getchar();
         //char parityBit = getParityBit(ch);
         //ch = (ch << 1) + parityBit;
         *data_out = ch;
         usleep(105); // Half of clk16x per = 3.25 us
         *load = 1;
         usleep(105);
         *tx_enable = 1;
         usleep(105);
         *load = 0;
         while (*char_complete_tx == 0) {
            *tx_enable = 1;
         }
         *tx_enable = 0;
         usleep(105);
         alt_putstr("Character has been transmitted\n");
      } else if (choice == 'r') {
         if (*data_in == 0xFF) {
            // Receiver buffer is all 1s, no data received
            alt_putstr("No character has been received\n");
         } else {
            char received_ch = *data_in;
            //parityBit = received_ch & 0x01;
            //if (getParityBit(received_ch) == parityBit) {
               alt_putstr("Character has been received: \n");
               alt_putchar(received_ch);
               *LEDR = received_ch;
           // } else {
           //    alt_putstr("Error: Transmission error detected, data is garbo\n");
           // }
         }
      } else {
         alt_putstr("Selection was garbo, please enter 's' or 'r'\n");
      }
   }
   return 0;
}

char getParityBit(char ch) {
   ch = ch ^ (ch >> 4);
   ch = ch ^ (ch >> 2);
   ch = ch ^ (ch >> 1);
   ch = ch & 0x01;
   return ch;
}

