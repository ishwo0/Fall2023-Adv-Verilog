/*****************************************************************//**
 * @file main_vanilla_test.cpp
 *
 * @brief Basic test of 4 basic i/o cores
 *
 * @author p chu
 * @version v1.0: initial release
 *********************************************************************/

//#define _DEBUG
#include "chu_init.h"
#include "gpio_cores.h"

/**
 * blink once per second for 5 times.
 * provide a sanity check for timer (based on SYS_CLK_FREQ)
 * @param led_p pointer to led instance
 */
void timer_check(GpoCore *led_p) {
   int i;

   for (i = 0; i < 5; i++) {
      led_p->write(0xffff);
      sleep_ms(500);
      led_p->write(0x0000);
      sleep_ms(500);
      debug("timer check - (loop #)/now: ", i, now_ms());
   }
}

/**
 * check individual led
 * @param led_p pointer to led instance
 * @param n number of led
 */
void led_check(GpoCore *led_p, int n) {
   int i;

   for (i = 0; i < n; i++) {
      led_p->write(1, i);
      sleep_ms(200);
      led_p->write(0, i);
      sleep_ms(200);
   }
}


/**
 * leds flash according to switch positions.
 * @param led_p pointer to led instance
 * @param sw_p pointer to switch instance
 */
void sw_check(GpoCore *led_p, GpiCore *sw_p) {
   int i, s;

   s = sw_p->read();
   for (i = 0; i < 30; i++) {
      led_p->write(s);
      sleep_ms(50);
      led_p->write(0);
      sleep_ms(50);
   }
}

// getting specific speed function based on switches
int get_speed(GpiCore *sw_p) {

	uint32_t switches;
	uint16_t speed = 0;
    switches = sw_p->read();
    speed = (uint16_t) ((switches & 0x0000001e) >> 1);

   return speed;

}

// grabbing initialize bit based on switches
int get_init(GpiCore *sw_p) {

	uint32_t switches;
	uint16_t init = 0;
    switches = sw_p->read();
    init = (uint16_t) (switches & 0x00000001);

   return init;

}

// chasing LEDs function with led amount, speed, and initialize bit
void led_chase(GpoCore *led_p, int n, int speed, int init) {

   if(init == 1)
	   led_p->write(1, 0);
   else {
	   led_p->write(1, n);
	   sleep_ms(speed);
	   led_p->write(0, n);
	   sleep_ms(speed);
   }
//
//   if(get_init(sw_p) == 1)
//	   led_p->write(1, 0);
//   else {
//	   for (i = 0; i < n*2; i++) {
//		   led_p->write(1, j);
//		   sleep_ms((get_speed(sw_p) ^ 0x000f) + 3);
//		   led_p->write(0, j);
//		   sleep_ms((get_speed(sw_p) ^ 0x000f) + 3);
//		   if (j == n-1)
//			   control = -1;
//		   j += control;
//		   if(get_init(sw_p) == 1)
//			   return;
//
//	   }
//   }

}



/**
 * uart transmits test line.
 * @note uart instance is declared as global variable in chu_io_basic.h
 */
void uart_check(int speed) {

   uart.disp("current speed:");
   uart.disp(speed);
   uart.disp("ms\n\r");

}

//int detect_change(int s_old, int s_new) {
//
//
//	if(s_new != s_old) {
//		uart_check(s_new);
//		return s_new;
//	}
//	else
//		return s_old;
//}

// instantiate switch, led
GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));

int main() {
	static int leds = 0;
	static int control = 1;
   while (1) {
	   uint16_t speed_old;
	   uint16_t speed_new = ( (get_speed(&sw) ^ 0x000f) + 3 );
	   uint16_t init = get_init(&sw);


	   if(speed_new != speed_old) {
		   uart_check(speed_new);
		   speed_old = speed_new;
	   }

	   if (init == 1)
	   	   leds = 0;

	   led_chase(&led, leds, speed_new, init);

	   if(leds == 15)
		   control = -1;
	   if(leds == 0)
		   control = 1;

	   leds += control;

   } //while



//   while (1) {
//      timer_check(&led);
//      led_check(&led, 16);
//      sw_check(&led, &sw);
//      uart_check();
//      debug("main - switch value / up time : ", sw.read(), now_ms());
//   } //while

} //main


