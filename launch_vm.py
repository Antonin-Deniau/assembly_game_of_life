import r2pipe, sys

r2 = r2pipe.open("./os")

# Conf binaire
r2.cmd("e asm.arch = x86")
r2.cmd("e asm.bits = 64")
r2.cmd("e asm.esil = true")

# Conf esil
r2.cmd("aei")
r2.cmd("aeim 0x2000 0xffff")
r2.cmd("aeip")
r2.cmd("e io.cache=true")
r2.cmd("e cmd.esil.intr=#!pipe python interruption_pipe.py")
r2.cmd("e esil.gotolimit=0xffff")
r2.cmd("aec")

r2.quit()
