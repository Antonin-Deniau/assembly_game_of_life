class Debugger
  def __init__(self, logname):
    self.logname = logname
    self.log = open(self.logname, "w")
    self.p("\n\n*************** DEBUGGER SESSION ****************")

  def handle_int(self, uc, intno):
    if intno == 0x1:
      self.print_infos(uc)

  def self.p(self, string):
    self.log.write(string)
    self.log.flush()

  def handle_exit(self):
    self.log.close()

  def print_infos(self, uc)
    if intno == 0x3:
      self.p("\n\n*** breakpoint ***")
      rdi = uc.reg_read(UC_X86_REG_RDI)
      rsi = uc.reg_read(UC_X86_REG_RSI)
      rsp = uc.reg_read(UC_X86_REG_RSP)
      rbp = uc.reg_read(UC_X86_REG_RBP)
      rax = uc.reg_read(UC_X86_REG_RAX)
      self.p("rdi: 0x{:0>10X} rsi: 0x{:0>10X}  rsp: 0x{:0>10X} rbp: 0x{:0>10X} rax: 0x{:0>10}".format(rdi, rsi, rsp, rbp, rax))
      r10 = uc.reg_read(UC_X86_REG_R10)
      r11 = uc.reg_read(UC_X86_REG_R11)
      r12 = uc.reg_read(UC_X86_REG_R12)
      r13 = uc.reg_read(UC_X86_REG_R13)
      r14 = uc.reg_read(UC_X86_REG_R14)
      self.p("r10: 0x{:0>10X} r11: 0x{:0>10X}  r12: 0x{:0>10X} r13: 0x{:0>10X} r14: 0x{:0>10}".format(r10, r11, r12, r13, r14))
