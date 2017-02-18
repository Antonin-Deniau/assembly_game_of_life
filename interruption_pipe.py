#!/usr/bin/env python
import r2pipe, sys, termios, os

r2 = r2pipe.open()

# Handle interruption
def handle_intr(number):
  if number == 0x1:
    rax = r2.cmd("aer rax")
    print(r2.cmd("pvz @ {}".format(rax)))

  elif number == 0x2:
    text = raw_input()
    rax = r2.cmd("aer rax")
    r2.cmd("w {} @ {}".format(text, rax))

handle_intr(int(sys.argv[1], 0))

r2.quit()
