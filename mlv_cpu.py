from threading import Thread
import time

from unicorn import *
from unicorn.x86_const import *

ADDRESS = 0x0

def run(hook_intr, binary):
  mu = Uc(UC_ARCH_X86, UC_MODE_64)

  mu.mem_map(ADDRESS, 2 * 1024 * 1024)
  mu.reg_write(UC_X86_REG_RSP, ADDRESS + 0x200000)
  mu.reg_write(UC_X86_REG_RBP, ADDRESS + 0x200000)
  mu.hook_add(UC_HOOK_INTR, hook_intr)
  mu.mem_write(ADDRESS, binary)

  mu.emu_start(ADDRESS, ADDRESS + len(binary))

class Cpu():#Thread):
  def __init__(self, devices, binary):
    #Thread.__init__(self)
    self.devices = devices
    self.binary = binary

  def start(self):
    t = Thread(target=run, args=(self.hook_intr, self.binary))
    t.start()

  def hook_intr(self, uc, intno, user_data):
    for device in self.devices:
      device.handle_int(uc, intno)

    if intno == 0x2:
      rax = uc.reg_read(UC_X86_REG_RAX)
      time.sleep(rax / 1000)

    elif intno == 0xFF:
      uc.emu_stop()
