//
//  temparature_converter.c
//  
//
//  Created by Ahmed Moalim on 5/12/17.
//
//  Program to convert temperature to and From the scales Celsius, Fahrenheit, or Kelvin: 


// Include statments
#include <stdio.h>
#include <string.h>

// Method declerations
float convert_temp(float temp, char* scale, char* convert_scale);


// Main program
int main(void) {
    float temp; // Temperature
    char scale[11]; // Scale of Temperature
    char convert_scale[11]; // Scale to be converted to
   
    // Calls to console to get temp, scale and new scale
    printf("\nPlease input a Temperature value: ");
    scanf("%f", &temp);
      
    printf("Please input the scale of the temperature as either Celsius, Fahrenheit, or Kelvin: ");
    scanf("%s", scale);
      
    printf("Please input the scale to convert to as either Celsius, Fahrenheit, or Kelvin: ");
    scanf("%s", convert_scale);
   
    
    // Call convert_temp to get converted temp and assign value to new_temp
    float new_temp = convert_temp(temp, scale, convert_scale);
    
    // Prints result of conversion
    printf("%.2f %s  ->  %.2f %s\n\n",  temp, scale, new_temp, convert_scale);
    
    return 0;
}


// Converts the passed in temp from the scale to the convert_scale
// and returns the answer.
float convert_temp(float temp, char* scale, char* convert_scale) {
    float new_temp = temp;
    
    if(strcasecmp(scale, "Fahrenheit") == 0) {
        
        if(strcasecmp(convert_scale, "Kelvin") == 0) {
            new_temp =  (temp + 459.67) * 0.556;
        } else if (strcasecmp(convert_scale, "Celsius") == 0) {
            new_temp = (temp - 32) * 0.556;
        }
        
    } else if(strcasecmp(scale, "Celsius") == 0) {
        
        if(strcasecmp(convert_scale, "Fahrenheit") == 0) {
            new_temp = temp * 1.8 + 32;
        } else if (strcasecmp(convert_scale, "Kelvin") == 0) {
            new_temp = temp + 273.15;
        }
        
    } else if(strcasecmp(scale, "Kelvin") == 0) {
        
        if(strcasecmp(convert_scale, "Fahrenheit") == 0) {
            new_temp = temp * 1.8 - 459.67;
        } else if (strcasecmp(convert_scale, "Celsius") == 0) {
            new_temp = temp - 273.15;
        }
    
    }
    
    return new_temp;
}



