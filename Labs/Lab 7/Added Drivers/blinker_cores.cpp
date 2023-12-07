#include "blinker_cores.h"
#include "timer_core.h"

BlinkerCore::BlinkerCore(uint32_t core_base_addr) {
   base_addr = core_base_addr;
   wr_data = 0;
}

BlinkerCore::~BlinkerCore() {
}

void BlinkerCore::blink(int bit_pos, int delay) {
   io_write(base_addr, bit_pos, delay);
}

         