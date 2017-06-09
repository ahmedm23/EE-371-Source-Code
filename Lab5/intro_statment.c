
#include <stdio.h>

int main() {
	print_intro();
	return 0;
}

void print_intro() {
	alt_putstr("Welcome to the world famous game, Ahmed Says!\n\n");
   	alt_putstr("The instructions to this game are simple.\n");
   	alt_putstr("1) 4 colors will flash on the screen in a pseudo random order.\n\n");
   	alt_putstr("2) When you see a color on the screen you must press the corresponding key\n");
   	alt_putstr("before the color changes. The color and key relationships are as follows.\n");
   	alt_putstr("Key_3 = Red | Key_2 = Green, | Key_1 = Blue | Key_0 = Yellow\n\n");
   	alt_putstr("3) If you do not press the key before the color changes you will lose a life.\n");
   	alt_putstr("If you run out of lives the game will be over and you must start from the begining.\n");
   	alt_putstr("We do not do any bullshit saves or checkpoints when you die you die.\n\n");
   	alt_putstr("4) You are givin 10 lives ranging from 2 to -8, so dont mess it up!\n\n");
   	alt_putstr("Please always remeber to have fun and do what Ahmed \"Says\"!\n");
}

