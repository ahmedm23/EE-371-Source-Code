//
//  delay_calculator.c
//  
//
//  Created by Ahmed Moalim on 5/16/17.
//
//	Program to calculate the delay in a path with the given amout of devices

// Include statments
#include <stdio.h>

// Main program;
int main(void) {
    int devices = 0; // Number of devices in the path
    double device_delay = 5E-9; // Pre-defined delay of a single device

    // Prompts the user for the number of devices in the path 
    // and assigns the value to devices
    printf("\nHow many logic devices are in this single path? ");
    scanf("%d", &devices);
    
    double path_delay = devices * device_delay; // Calculates the delay in this path
    
    // Outputs the results
    printf("The Delay of the path is %.1E secs\n\n", path_delay);
}
