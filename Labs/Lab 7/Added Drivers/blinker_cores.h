#include "chu_init.h"
class BlinkerCore {
public:
   /**
    * register map
    *
    */
   enum {
      DATA_REG = 0 /**< output data register */
   };
   /**
    * constructor.
    *
    */
   BlinkerCore(uint32_t core_base_addr);
   ~BlinkerCore();                  // not used


   /**
    * start blinking at a specific bit position
    *
    * @param bit_pos bit position
    * @param delay desired delay in ms
    *
    */
   void blink(int bit_pos, int delay);

private:
   uint32_t base_addr;
   uint32_t wr_data;      // same as GPO core data reg
};