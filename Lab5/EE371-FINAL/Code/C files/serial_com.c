
#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
#include <unistd.h>
#include <stdio.h>

char getParityBit(char);

int main() {
   while (1) {
      alt_putstr("Type a character to send: ");
      char ch = alt_getchar();
      alt_getchar();
      char data_out = ch;
		char leds = data_out;
   	IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE, leds);
   	IOWR_ALTERA_AVALON_PIO_DATA(DATA_OUT_BASE, ch);
   	IOWR_ALTERA_AVALON_PIO_DATA(LOAD_BASE, 1);
   	IOWR_ALTERA_AVALON_PIO_DATA(TX_ENABLE_BASE, 1);
   	usleep(4);
   	IOWR_ALTERA_AVALON_PIO_DATA(LOAD_BASE, 0);
   	char char_complete_tx = IORD_ALTERA_AVALON_PIO_DATA(CHAR_COMPLETE_TX_BASE);
      while (char_complete_tx == 0) {
         char_complete_tx = IORD_ALTERA_AVALON_PIO_DATA(CHAR_COMPLETE_TX_BASE);
      }
      IOWR_ALTERA_AVALON_PIO_DATA(TX_ENABLE_BASE, 0);

      alt_putstr("Character has been transmitted\n");
      // ---------------RECEIVE--------------------------
      char char_complete_rx =
         IORD_ALTERA_AVALON_PIO_DATA(CHAR_COMPLETE_BASE);
      if (char_complete_rx != 0) {
   	   char data_in = IORD_ALTERA_AVALON_PIO_DATA(DATA_IN_BASE);
         alt_putstr("Character received: \n");
         printf("%x\n", data_in);
      } else {
         alt_putstr("No character has been received\n");
      }
   }
   return 0;
}


