from unicorn import *
from unicorn.x86_const import *

import time

ADDRESS = 0x0

class Cpu:
  def __init__(self):
    self.mode = UC_MODE_64
    self.devices = []
    self.code = None

    try:
      self.mu = Uc(UC_ARCH_X86, self.mode)
      self.mu.mem_map(ADDRESS, 2 * 1024 * 1024)
      self.mu.reg_write(UC_X86_REG_RSP, ADDRESS + 0x200000)
      self.mu.reg_write(UC_X86_REG_RBP, ADDRESS + 0x200000)
      self.mu.hook_add(UC_HOOK_INTR, self.hook_intr)
    except UcError as e:
      print("ERROR: %s" % e)

  def load_in_memory(self, code):
    self.code = code
    self.mu.mem_write(ADDRESS, self.code)

  def attach(self, device):
    self.devices.append(device)

  def run(self):
    self.mu.emu_start(ADDRESS, ADDRESS + len(self.code))

  def hook_intr(self, uc, intno, user_data):
    for device in self.devices:
      device.handle_int(uc, intno)

    if intno == 0x2: # sleep
      rax = uc.reg_read(UC_X86_REG_RAX)
      time.sleep(rax / 1000)

    elif intno == 0xFF: # exit
      uc.emu_stop()
