/* Blink Example

   This example code is in the Public Domain (or CC0 licensed, at your option.)

   Unless required by applicable law or agreed to in writing, this
   software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied.
*/
#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/gpio.h"
#include "sdkconfig.h"

/* Can use project configuration menu (idf.py menuconfig) to choose the GPIO to blink,
   or you can edit the following line and set a number here.
*/
//#define BLINK_GPIO CONFIG_BLINK_GPIO
#define BLINK_GPIO 11

int gpios[] = {11, 10, 9, 8, 7, 36, 37, 38, 39, 40, 42};
int GPIO_LEN=11;

void app_main(void)
{
    /* Configure the IOMUX register for pad BLINK_GPIO (some pads are
       muxed to GPIO on reset already, but some default to other
       functions and need to be switched to GPIO. Consult the
       Technical Reference for a list of pads and their default
       functions.)
    */
    /* Set the GPIO as a push/pull output */
    for (int i=0; i<GPIO_LEN; i++) {
        gpio_reset_pin(gpios[i]);
        gpio_set_direction(gpios[i], GPIO_MODE_OUTPUT);
    }

    gpio_set_direction(33, GPIO_MODE_OUTPUT);
    gpio_set_direction(34, GPIO_MODE_OUTPUT);
    gpio_set_level(33, 0);
    gpio_set_level(34, 0);

    while(1) {
        for (int i=0; i<GPIO_LEN; i++) {
            gpio_set_level(gpios[i], 0);
        	printf("Turning off the LED %d\n", gpios[i]);
            vTaskDelay(1000 / portTICK_PERIOD_MS);

        }


        for (int i=0; i<GPIO_LEN; i++) {
            gpio_set_level(gpios[i], 1);
        	printf("Turning om the LED %d\n", gpios[i]);
            vTaskDelay(1000 / portTICK_PERIOD_MS);

        }

    }
}
