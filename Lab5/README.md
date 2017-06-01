
LAB 5 ---------------------------------------------

Orders of Business:--------------------------------
1. Implement Serial Communication
2. Figure out how to Display through VGA

3. Program Description: Ahmed
* A series of colors are going to flash onto the monitor through the VGA cable
* After the flash pattern occurs, it waits for our input
* We'll need to press the corresponding keys to match the color pattern flashed
	* If correct, our score increments by 1
	* If not correct, our lives decrement by 1
		* If reaches 0, print "You suck, but we will let you keep playing."
		* Lives counter goes to the negative.
* Starts over for resets.
* Go for high score Nerd!
	
---------------------------------------------------
Bitmasking:

sw 7 6 5 4 3 2 1 0 
char = --------

Mask bit, set last one = 1, others to 0.
Isolate that bit, and:
0 0 0 0 0 0 0 |?&1

( Mask << 3 ) & char
Switch value for SW3. 

User module and use serial communication module 

