/*****************************************************************//**
 * @file main_sampler_test.cpp
 *
 * @brief Basic test of nexys4 ddr mmio cores
 *
 * @author p chu
 * @version v1.0: initial release
 *********************************************************************/

// #define _DEBUG
#include "chu_init.h"
#include "gpio_cores.h"
#include "xadc_core.h"
#include "sseg_core.h"
#include "spi_core.h"
#include "i2c_core.h"
#include "ps2_core.h"
#include "ddfs_core.h"
#include "adsr_core.h"
#include "math.h"

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
      sleep_ms(100);
      led_p->write(0, i);
      sleep_ms(100);
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

/**
 * uart transmits test line.
 * @note uart instance is declared as global variable in chu_io_basic.h
 */
void uart_check() {
   static int loop = 0;

   uart.disp("uart test #");
   uart.disp(loop);
   uart.disp("\n\r");
   loop++;
}

/**
 * read FPGA internal voltage temperature
 * @param adc_p pointer to xadc instance
 */

void adc_check(XadcCore *adc_p, GpoCore *led_p) {
   double reading;
   int n, i;
   uint16_t raw;

   for (i = 0; i < 5; i++) {
      // display 12-bit channel 0 reading in LED
      raw = adc_p->read_raw(0);
      raw = raw >> 4;
      led_p->write(raw);
      // display on-chip sensor and 4 channels in console
      uart.disp("FPGA vcc/temp: ");
      reading = adc_p->read_fpga_vcc();
      uart.disp(reading, 3);
      uart.disp(" / ");
      reading = adc_p->read_fpga_temp();
      uart.disp(reading, 3);
      uart.disp("\n\r");
      for (n = 0; n < 4; n++) {
         uart.disp("analog channel/voltage: ");
         uart.disp(n);
         uart.disp(" / ");
         reading = adc_p->read_adc_in(n);
         uart.disp(reading, 3);
         uart.disp("\n\r");
      } // end for
      sleep_ms(200);
   }
}

/**
 * tri-color led dims gradually
 * @param led_p pointer to led instance
 * @param sw_p pointer to switch instance
 */

void pwm_3color_led_check(PwmCore *pwm_p) {
   int i, n;
   double bright, duty;
   const double P20 = 1.2589;  // P20=100^(1/20); i.e., P20^20=100

   pwm_p->set_freq(50);
   for (n = 0; n < 3; n++) {
      bright = 1.0;
      for (i = 0; i < 20; i++) {
         bright = bright * P20;
         duty = bright / 100.0;
         pwm_p->set_duty(duty, n);
         pwm_p->set_duty(duty, n + 3);
         sleep_ms(100);
      }
      sleep_ms(300);
      pwm_p->set_duty(0.0, n);
      pwm_p->set_duty(0.0, n + 3);
   }
}

/**
 * Test debounced buttons
 *   - count transitions of normal and debounced button
 * @param db_p pointer to debouceCore instance
 */

void debounce_check(DebounceCore *db_p, GpoCore *led_p) {
   long start_time;
   int btn_old, db_old, btn_new, db_new;
   int b = 0;
   int d = 0;
   uint32_t ptn;

   start_time = now_ms();
   btn_old = db_p->read();
   db_old = db_p->read_db();
   do {
      btn_new = db_p->read();
      db_new = db_p->read_db();
      if (btn_old != btn_new) {
         b = b + 1;
         btn_old = btn_new;
      }
      if (db_old != db_new) {
         d = d + 1;
         db_old = db_new;
      }
      ptn = d & 0x0000000f;
      ptn = ptn | (b & 0x0000000f) << 4;
      led_p->write(ptn);
   } while ((now_ms() - start_time) < 5000);
}

/**
 * Test pattern in 7-segment LEDs
 * @param sseg_p pointer to 7-seg LED instance
 */

void sseg_check(SsegCore *sseg_p) {
   int i, n;
   uint8_t dp;

   //turn off led
   for (i = 0; i < 8; i++) {
      sseg_p->write_1ptn(0xff, i);
   }
   //turn off all decimal points
   sseg_p->set_dp(0x00);

   // display 0x0 to 0xf in 4 epochs
   // upper 4  digits mirror the lower 4
   for (n = 0; n < 4; n++) {
      for (i = 0; i < 4; i++) {
         sseg_p->write_1ptn(sseg_p->h2s(i + n * 4), 3 - i);
         sseg_p->write_1ptn(sseg_p->h2s(i + n * 4), 7 - i);
         sleep_ms(300);
      } // for i
   }  // for n
      // shift a decimal point 4 times
   for (i = 0; i < 4; i++) {
      bit_set(dp, 3 - i);
      sseg_p->set_dp(1 << (3 - i));
      sleep_ms(300);
   }
   //turn off led
   for (i = 0; i < 8; i++) {
      sseg_p->write_1ptn(0xff, i);
   }
   //turn off all decimal points
   sseg_p->set_dp(0x00);

}

/**
 * Test adxl362 accelerometer using SPI
 */

void gsensor_check(SpiCore *spi_p, GpoCore *led_p) {
   const uint8_t RD_CMD = 0x0b;
   const uint8_t PART_ID_REG = 0x02;
   const uint8_t DATA_REG = 0x08;
   const float raw_max = 127.0 / 2.0;  //128 max 8-bit reading for +/-2g

   int8_t xraw, yraw, zraw;
   float x, y, z;
   int id;

   spi_p->set_freq(400000);
   spi_p->set_mode(0, 0);
   // check part id
   spi_p->assert_ss(0);    // activate
   spi_p->transfer(RD_CMD);  // for read operation
   spi_p->transfer(PART_ID_REG);  // part id address
   id = (int) spi_p->transfer(0x00);
   spi_p->deassert_ss(0);
   uart.disp("read ADXL362 id (should be 0xf2): ");
   uart.disp(id, 16);
   uart.disp("\n\r");
   // read 8-bit x/y/z g values once
   spi_p->assert_ss(0);    // activate
   spi_p->transfer(RD_CMD);  // for read operation
   spi_p->transfer(DATA_REG);  //
   xraw = spi_p->transfer(0x00);
   yraw = spi_p->transfer(0x00);
   zraw = spi_p->transfer(0x00);
   spi_p->deassert_ss(0);
   x = (float) xraw / raw_max;
   y = (float) yraw / raw_max;
   z = (float) zraw / raw_max;
   uart.disp("x/y/z axis g values: ");
   uart.disp(x, 3);
   uart.disp(" / ");
   uart.disp(y, 3);
   uart.disp(" / ");
   uart.disp(z, 3);
   uart.disp("\n\r");
}

/*
 * read temperature from adt7420
 * @param adt7420_p pointer to adt7420 instance
 */
void adt7420_check(I2cCore *adt7420_p, GpoCore *led_p) {
   const uint8_t DEV_ADDR = 0x4b;
   uint8_t wbytes[2], bytes[2];
   //int ack;
   uint16_t tmp;
   float tmpC;

   // read adt7420 id register to verify device existence
   // ack = adt7420_p->read_dev_reg_byte(DEV_ADDR, 0x0b, &id);

   wbytes[0] = 0x0b;
   adt7420_p->write_transaction(DEV_ADDR, wbytes, 1, 1);
   adt7420_p->read_transaction(DEV_ADDR, bytes, 1, 0);
   uart.disp("read ADT7420 id (should be 0xcb): ");
   uart.disp(bytes[0], 16);
   uart.disp("\n\r");
   //debug("ADT check ack/id: ", ack, bytes[0]);
   // read 2 bytes
   //ack = adt7420_p->read_dev_reg_bytes(DEV_ADDR, 0x0, bytes, 2);
   wbytes[0] = 0x00;
   adt7420_p->write_transaction(DEV_ADDR, wbytes, 1, 1);
   adt7420_p->read_transaction(DEV_ADDR, bytes, 2, 0);

   // conversion
   tmp = (uint16_t) bytes[0];
   tmp = (tmp << 8) + (uint16_t) bytes[1];
   if (tmp & 0x8000) {
      tmp = tmp >> 3;
      tmpC = (float) ((int) tmp - 8192) / 16;
   } else {
      tmp = tmp >> 3;
      tmpC = (float) tmp / 16;
   }
   uart.disp("temperature (C): ");
   uart.disp(tmpC);
   uart.disp("\n\r");
   led_p->write(tmp);
   sleep_ms(1000);
   led_p->write(0);
}

void ps2_check(Ps2Core *ps2_p) {
   int id;
   int lbtn, rbtn, xmov, ymov;
   char ch;
   unsigned long last;

   uart.disp("\n\rPS2 device (1-keyboard / 2-mouse): ");
   id = ps2_p->init();
   uart.disp(id);
   uart.disp("\n\r");
   last = now_ms();
   do {
      if (id == 2) {  // mouse
         if (ps2_p->get_mouse_activity(&lbtn, &rbtn, &xmov, &ymov)) {
            uart.disp("[");
            uart.disp(lbtn);
            uart.disp(", ");
            uart.disp(rbtn);
            uart.disp(", ");
            uart.disp(xmov);
            uart.disp(", ");
            uart.disp(ymov);
            uart.disp("] \r\n");
            last = now_ms();

         }   // end get_mouse_activitiy()
      } else {
         if (ps2_p->get_kb_ch(&ch)) {
            uart.disp(ch);
            uart.disp(" ");
            last = now_ms();
         } // end get_kb_ch()
      }  // end id==2
   } while (now_ms() - last < 5000);
   uart.disp("\n\rExit PS2 test \n\r");

}

/**
 * play primary notes with ddfs
 * @param ddfs_p pointer to ddfs core
 * @note: music tempo is defined as beats of quarter-note per minute.
 *        60 bpm is 1 sec per quarter note
 * @note "click" sound due to abrupt stop of a note
 *
 */
void ddfs_check(DdfsCore *ddfs_p, GpoCore *led_p) {
   int i, j;
   float env;

   //vol = (float)sw.read_pin()/(float)(1<<16),
   ddfs_p->set_env_source(0);  // select envelop source
   ddfs_p->set_env(0.0);   // set volume
   sleep_ms(500);
   ddfs_p->set_env(1.0);   // set volume
   ddfs_p->set_carrier_freq(262);
   sleep_ms(2000);
   ddfs_p->set_env(0.0);   // set volume
   sleep_ms(2000);
   // volume control (attenuation)
   ddfs_p->set_env(0.0);   // set volume
   env = 1.0;
   for (i = 0; i < 1000; i++) {
      ddfs_p->set_env(env);
      sleep_ms(10);
      env = env / 1.0109; //1.0109**1024=2**16
   }
   // frequency modulation 635-912 800 - 2000 siren sound
   ddfs_p->set_env(1.0);   // set volume
   ddfs_p->set_carrier_freq(635);
   for (i = 0; i < 5; i++) {               // 10 cycles
      for (j = 0; j < 30; j++) {           // sweep 30 steps
         ddfs_p->set_offset_freq(j * 10);  // 10 Hz increment
         sleep_ms(25);
      } // end j loop
   } // end i loop
   ddfs_p->set_offset_freq(0);
   ddfs_p->set_env(0.0);   // set volume
   sleep_ms(1000);
}

/**
 * play primary notes with ddfs
 * @param adsr_p pointer to adsr core
 * @param ddfs_p pointer to ddfs core
 * @note: music tempo is defined as beats of quarter-note per minute.
 *        60 bpm is 1 sec per quarter note
 *
 */
void adsr_check(AdsrCore *adsr_p, GpoCore *led_p, GpiCore *sw_p) {
   const int melody[] = { 0, 2, 4, 5, 7, 9, 11 };
   int i, oct;

   adsr_p->init();
   // no adsr envelop and  play one octave
   adsr_p->bypass();
   for (i = 0; i < 7; i++) {
      led_p->write(bit(i));
      adsr_p->play_note(melody[i], 3, 500);
      sleep_ms(500);
   }
   adsr_p->abort();
   sleep_ms(1000);
   // set and enable adsr envelop
   // play 4 octaves
   adsr_p->select_env(sw_p->read());
   for (oct = 3; oct < 6; oct++) {
      for (i = 0; i < 7; i++) {
         led_p->write(bit(i));
         adsr_p->play_note(melody[i], oct, 500);
         sleep_ms(500);
      }
   }
   led_p->write(0);
   // test duration
   sleep_ms(1000);
   for (i = 0; i < 4; i++) {
      adsr_p->play_note(0, 4, 500 * i);
      sleep_ms(500 * i + 1000);
   }
}

/**
 * core test
 * @param led_p pointer to led instance
 * @param sw_p pointer to switch instance
 */
void show_test_id(int n, GpoCore *led_p) {
   int i, ptn;

   ptn = n; //1 << n;
   for (i = 0; i < 20; i++) {
      led_p->write(ptn);
      sleep_ms(30);
      led_p->write(0);
      sleep_ms(30);
   }
}


#define DECLINATION 11.40 


float Max[2], Mid[2], Min[2], X, Y;



//reads measurements in mG
void CMPS2_read_XYZ(I2cCore *pmod) {
	const uint8_t DEV_ADDR =  0x30;
	const uint8_t CTRL_REG= 0x07;
	const uint8_t STATUS_REG= 0x06;
	const uint8_t DATA_ACQ = 0x01;
	uint8_t status ;


	uint8_t wbytes[12], bytes[12];

	wbytes[0] = CTRL_REG;
	wbytes[1] = DATA_ACQ;
	pmod -> write_transaction(DEV_ADDR, wbytes, 2 , 0);
	sleep_ms(10);


  wbytes[0] = STATUS_REG;
  	do{
  		pmod -> write_transaction(DEV_ADDR, wbytes, 1 , 1);
  		pmod -> read_transaction(DEV_ADDR, bytes, 1 , 0);
  		status = bytes[0] & 0x01;
  	}while(status == 0);


   wbytes[0] = 0x00;

   pmod -> write_transaction(DEV_ADDR, wbytes, 1 , 1);
   pmod -> read_transaction(DEV_ADDR, bytes, 6 , 0);




  //initialize array for data
  float measured_data[2];

  //reconstruct raw data
  measured_data[0] = 1.0 * (int)(bytes[1] << 8 | bytes[0]); //x
  measured_data[1] = 1.0 * (int)(bytes[3] << 8 | bytes[2]); //y

  //convert raw data to mG
  for (int i = 0; i < 2; i++) {
    measured_data[i] = 0.48828125 * (float)measured_data[i];
  }

  X = measured_data[0];
  Y = measured_data[1];

  //correct minimum, mid and maximum values
  if (measured_data[0] > Max[0]) { //x max
    Max[0] = measured_data[0];
  }
  if (measured_data[0] < Min[0]) { //x min
    Min[0] = measured_data[0];
  }
  if (measured_data[1] > Max[1]) { //y max
    Max[1] = measured_data[1];
  }
  if (measured_data[1] < Min[1]) { //y min
    Min[1] = measured_data[1];
  }
  for (int i = 0; i < 2; i++) { //mid
    Mid[i] = (Max[i] + Min[i]) / 2;
  }

  return;
}



//initialize the compass
void CMPS2_init(I2cCore *pmod) {
	const uint8_t DEV_ADDR =  0x30;
	const uint8_t CTRL_REG = 0x07;
	const uint8_t SET_ACTION = 0x20;

	uint8_t wbytes[2];



	wbytes[0] = CTRL_REG;
	wbytes[1] = SET_ACTION;
	pmod -> write_transaction(DEV_ADDR, wbytes, 2 , 0);
	sleep_ms(10);

	  //initialize minimum, mid and maximum values
	  for (int i = 0; i < 2; i++) {
	    Max[i] = -32768;  //smallest int on 16 bits
	    Min[i] = 32767;  //largest int on 16 bits
	    Mid[i] = 0;
	  }

}

//sets/resets the sensor, changing the magnetic polarity of the sensing element
void CMPS2_set(bool reset,I2cCore *pmod) {
	const uint8_t DEV_ADDR =  0x30;
	const uint8_t CTRL_REG= 0x07;
	const uint8_t REFILL_CAP = 0x80;
	const uint8_t SET_ACTION = 0x20;
	const uint8_t RST = 0x40;
	uint8_t wbytes[2];


	wbytes[0] = CTRL_REG;
	wbytes[1] = REFILL_CAP;
	pmod -> write_transaction(DEV_ADDR, wbytes, 2 , 0);
	sleep_ms(50);

  if (reset) {
	wbytes[0] = CTRL_REG;
	wbytes[1] = RST;
	pmod -> write_transaction(DEV_ADDR, wbytes, 2 , 0);
	sleep_ms(10);
  }
  else {
	wbytes[0] = CTRL_REG;
	wbytes[1] = SET_ACTION;
	pmod -> write_transaction(DEV_ADDR, wbytes, 2 , 0);
	sleep_ms(10);
  }
  return;
}


float CMPS2_getHeading(I2cCore *pmod) {
  float components[2];
  float offsetx, offsety;
  CMPS2_set(false,pmod);   //set the polarity to normal
  CMPS2_read_XYZ(pmod);  //read X, Y, Z components of the magnetic field
  components[0] = X;  //save current results
  components[1] = Y;
  CMPS2_set(true,pmod);   //set the polarity to normal
  CMPS2_read_XYZ(pmod);  //read X, Y, Z components of the magnetic field

  //eliminate offset from all components
  offsetx = components[0] + (X/2.0);
  offsety = components[1] + (Y/2.0);
  X = X - offsetx;
  Y = Y - offsety;

  //variables for storing partial results
  float temp0 = 0;
  float temp1 = 0;
  //and for storing the final result
  float deg = 0;


  //calculate heading from components of the magnetic field
  //the formula is different in each quadrant
  if (components[0] < Mid[0])
  {
    if (components[1] > Mid[1])
    {
      //Quadrant 1
      uart.disp("Quadrant 1\n\n");
      temp0 = components[1] - Mid[1];
      temp1 = Mid[0] - components[0];
      deg = 90 - atan(temp0 / temp1) * (180 / 3.14159);
    }
    else
    {
      //Quadrant 2
      uart.disp("Quadrant 2\n\n");
      temp0 = Mid[1] - components[1];
      temp1 = Mid[0] - components[0];
      deg = 90 + atan(temp0 / temp1) * (180 / 3.14159);
    }
  }
  else {
    if (components[1] < Mid[1])
    {
      //Quadrant 3
      uart.disp("Quadrant 3\n\n");
      temp0 = Mid[1] - components[1];
      temp1 = components[0] - Mid[0];
      deg = 270 - atan(temp0 / temp1) * (180 / 3.14159);
    }
    else
    {
      //Quadrant 4
      uart.disp("Quadrant 4\n\n");
      temp0 = components[1] - Mid[1];
      temp1 = components[0] - Mid[0];
      deg = 270 + atan(temp0 / temp1) * (180 / 3.14159);
    }
  }

   // deg += DECLINATION;
  //correct heading
  deg += DECLINATION;
  if (DECLINATION > 0)
  {
    if (deg > 360) {
      deg -= 360;
    }
  }
  else
  {
    if (deg < 0) {
      deg += 360;
    }
  }

  
  return deg;
}

void CMPS2_decodeHeading(float measured_angle) {
  //decoding heading angle according to datasheet
   if(measured_angle > 337.25 || measured_angle < 22.5) {
      uart.disp("Direction: ");
      uart.disp(measured_angle, 3);
      uart.disp("°\t");
      uart.disp("NORTH.");
      uart.disp("\n\r");
      uart.disp("\n\r");
   }
   else if(measured_angle > 292.5 && measured_angle <= 337.25) {
      uart.disp("Direction: ");
      uart.disp(measured_angle, 3);
      uart.disp("°\t");
      uart.disp(" NORTH-WEST.");
      uart.disp("\n\r");
      uart.disp("\n\r");
   }
   else if(measured_angle > 247.5 && measured_angle <= 292.5) {
      uart.disp("Direction: ");
      uart.disp(measured_angle, 3);
      uart.disp("°\t");
      uart.disp(" WEST.");
      uart.disp("\n\r");
      uart.disp("\n\r");
   }
   else if(measured_angle > 202.5 && measured_angle <= 247.5) {
      uart.disp("Direction: ");
      uart.disp(measured_angle, 3);
      uart.disp("°\t");
      uart.disp(" SOUTH-WEST.");
      uart.disp("\n\r");
      uart.disp("\n\r");
   }
   else if(measured_angle > 157.5 && measured_angle <= 202.5) {
      uart.disp("Direction: ");
      uart.disp(measured_angle, 3);
      uart.disp("°\t");
      uart.disp(" SOUTH.");
      uart.disp("\n\r");
      uart.disp("\n\r");
   }
   else if(measured_angle > 112.5 && measured_angle <= 157.5) {
      uart.disp("Direction: ");
      uart.disp(measured_angle, 3);
      uart.disp("°\t");
      uart.disp(" SOUTH-EAST.");
      uart.disp("\n\r");
      uart.disp("\n\r");
   }
   else if(measured_angle > 67.5 && measured_angle <= 112.5) {
      uart.disp("Direction: ");
      uart.disp(measured_angle, 3);
      uart.disp("°\t");
      uart.disp(" EAST."); 
      uart.disp("\n\r");
      uart.disp("\n\r");
   }
   else if(measured_angle > 0 && measured_angle <= 67.5) {
      uart.disp("Direction: ");
      uart.disp(measured_angle, 3);
      uart.disp("°\t");
      uart.disp(" NORTH-EAST.");
      uart.disp("\n\r");
      uart.disp("\n\r");
   }


}


void compass_color(PwmCore *pwm_p, float degrees) {
   pwm_p->set_freq(50);
   if(degrees > 337.25 || degrees < 22.5) {
      pwm_p->set_duty(0.0, 2);
      pwm_p->set_duty(1.0, 1);
      pwm_p->set_duty(0.0, 0);
   }
   else {
      pwm_p->set_duty(1.0, 2);
      pwm_p->set_duty(0.0, 1);
      pwm_p->set_duty(0.0, 0);

   }

}

GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));
I2cCore compass(get_slot_addr(BRIDGE_BASE, S4_USER));
XadcCore adc(get_slot_addr(BRIDGE_BASE, S5_XDAC));
PwmCore pwm(get_slot_addr(BRIDGE_BASE, S6_PWM));
DebounceCore btn(get_slot_addr(BRIDGE_BASE, S7_BTN));
SsegCore sseg(get_slot_addr(BRIDGE_BASE, S8_SSEG));
SpiCore spi(get_slot_addr(BRIDGE_BASE, S9_SPI));
I2cCore adt7420(get_slot_addr(BRIDGE_BASE, S10_I2C));
Ps2Core ps2(get_slot_addr(BRIDGE_BASE, S11_PS2));
DdfsCore ddfs(get_slot_addr(BRIDGE_BASE, S12_DDFS));
AdsrCore adsr(get_slot_addr(BRIDGE_BASE, S13_ADSR), &ddfs);


int main() {
   //uint8_t id, ;
   // uint16_t x_offset, y_offset, z_offset;
  CMPS2_init(&compass);

  float measured_angle;
   // timer_check(&led);
   // pmod_calibrate(&compass, &x_offset, &y_offset, &z_offset);
   while (1) {
     measured_angle = CMPS2_getHeading(&compass);
     compass_color(&pwm, measured_angle);
   //   uart.disp("Heading = ");
   //   uart.disp(measured_angle, 16);
   //   uart.disp("°");
   //   uart.disp("\t");
     CMPS2_decodeHeading(measured_angle);
      //  pmod_calibrate(&compass, &x_offset, &y_offset, &z_offset);
      //  compass_check(&compass, &x_offset, &y_offset, &z_offset);
//      show_test_id(1, &led);
//      led_check(&led, 16);
//      sw_check(&led, &sw);
//      show_test_id(3, &led);
//      uart_check();
//      debug("main - switch value / up time : ", sw.read(), now_ms());
//      show_test_id(5, &led);
//      adc_check(&adc, &led);
//      show_test_id(6, &led);
//      pwm_3color_led_check(&pwm);
//      show_test_id(7, &led);
//      debounce_check(&btn, &led);
//      show_test_id(8, &led);
//      sseg_check(&sseg);
//      show_test_id(9, &led);
//      gsensor_check(&spi, &led);
//      show_test_id(10, &led);
      // adt7420_check(&adt7420, &led);
//      show_test_id(11, &led);
//      ps2_check(&ps2);
//      show_test_id(12, &led);
//      ddfs_check(&ddfs, &led);
//      show_test_id(13, &led);
//      adsr_check(&adsr, &led, &sw);
   } //while
} //main

