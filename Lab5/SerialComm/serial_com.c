
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
#include <unistd.h>
#include <stdio.h>

/*#define LEDR             ((char*) 0x00011090)
#define data_out         ((char*) 0x00011050)
#define data_in          ((char*) 0x00011010)
#define tx_enable        ((char*) 0x00011040)
#define char_complete_tx ((char*) 0x00011030)
#define load             ((char*) 0x00011020)
*/

char getParityBit(char);

int main() {
   while (1) {
      alt_putstr("Enter 's' to send or 'r' to receive a character");
      char choice = alt_getchar();
      alt_getchar();
      if (choice == 's') {
         alt_putstr("Type a character to send: ");
         char ch = alt_getchar();
         alt_getchar();

         /*
         //char parityBit = getParityBit(ch);
         //ch = (ch << 1) + parityBit;
         char data_out = ch;
         //alt_putchar(data_out);
         //printf("%x\n", data_out);
         IOWR_ALTERA_AVALON_PIO_DATA(DATA_OUT_BASE, data_out);

		 char leds = data_out;
     	 IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE, leds);
         data_out = ch;
         usleep(105); // Half of clk16x per = 3.25 us

         char load = 1;
         IOWR_ALTERA_AVALON_PIO_DATA(LOAD_BASE, load);

         usleep(105);

         char tx_enable = 1;
         IOWR_ALTERA_AVALON_PIO_DATA(TX_ENABLE_BASE, tx_enable);

         usleep(105);
         load = 0;
         IOWR_ALTERA_AVALON_PIO_DATA(LOAD_BASE, load);

		 char char_complete_tx = IORD_ALTERA_AVALON_PIO_DATA(CHAR_COMPLETE_TX_BASE);
         printf("%x\n", char_complete_tx);
         */
         /*while (char_complete_tx == 0) {
            //tx_enable = 1;
            //IOWR_ALTERA_AVALON_PIO_DATA(TX_ENABLE_BASE, tx_enable);
            alt_putstr("Infinite loop \n");
            alt_printf("");

         }
         tx_enable = 0;
         IOWR_ALTERA_AVALON_PIO_DATA(TX_ENABLE_BASE, tx_enable);

         usleep(105);
         */
         char data_out = ch;
		 char leds = data_out;
     	 IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE, leds);
         //alt_putchar(data_out);
      	 IOWR_ALTERA_AVALON_PIO_DATA(DATA_OUT_BASE, ch);
      	 IOWR_ALTERA_AVALON_PIO_DATA(LOAD_BASE, 1);
      	 IOWR_ALTERA_AVALON_PIO_DATA(TX_ENABLE_BASE, 1);
      	 usleep(4);
      	 IOWR_ALTERA_AVALON_PIO_DATA(LOAD_BASE, 0);
      	 IOWR_ALTERA_AVALON_PIO_DATA(TX_ENABLE_BASE, 0);
         printf("data_out = %c\n", data_out);

         alt_putstr("Character has been transmitted\n");
      } else if (choice == 'r') {
         char char_complete_rx =
              IORD_ALTERA_AVALON_PIO_DATA(CHAR_COMPLETE_BASE);
         if (char_complete_rx != 0) {
    	      char data_in = IORD_ALTERA_AVALON_PIO_DATA(DATA_IN_BASE);
            alt_putstr("Character received: \n");
            printf("%x\n", data_in);
            char leds = data_in;
            IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE, leds);
            //alt_putstr("\n");
         } else {
            alt_putstr("No character has been received\n");
         }
      } else {
         alt_putstr("Selection was garbo, please enter 's' or 'r'\n");
      }
/*         if (data_in == 0xFF) {
            // Receiver buffer is all 1s, no data received
            alt_putstr("No character has been received\n");
         } else {
            //char received_ch = data_in;
            //char received_ch = *data_in;
            //parityBit = received_ch & 0x01;
            //if (getParityBit(received_ch) == parityBit) {
               alt_putstr("Character has been received: \n");
               //alt_putchar(received_ch);
               alt_putchar(data_in);
               alt_putstr("\n");
               //alt_printf("%x\n");
			   char leds = data_in;
            IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE, leds);


               //LEDR = received_ch;
           // } else {
           //    alt_putstr("Error: Transmission error detected, data is garbo\n");
           // }
         }
      } else {
         alt_putstr("Selection was garbo, please enter 's' or 'r'\n");
      }*/
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

