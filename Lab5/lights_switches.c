/* 
 * "Lights and Switches" example.
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware.
 * This program also connects the switches to leds in the hardware thus both
 * components are required.
 * 
 * author 371 TA's and Ahmed Moalim
 * All rights Reserved 2017 University of Washington EE 371
 * 
 * Free from Licensing Restrictions
 */

#include "sys/alt_stdio.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
int main()
{ 
  alt_putstr("Hello from Nios II! L&S Example \n");
  /* Event loop never exits. */
  while (1) {
	  char switches = IORD_ALTERA_AVALON_PIO_DATA(SWITCHES_BASE);
	  char leds = switches;
	  IOWR_ALTERA_AVALON_PIO_DATA(LEDS_BASE, leds);
  }

  return 0;
}
