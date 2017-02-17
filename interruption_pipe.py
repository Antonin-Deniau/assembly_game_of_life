import r2pipe, sys

r2 = r2pipe.open()

# Handle interruption
def handle_intr(number):
  if number == 0x1:
    sys.stdout.write(r2.cmd("pvz @ rax"))
    sys.stdout.flush()

  elif number == 0x2:
    text = sys.stdin.read(1)
    r2.cmd("w {} @ {}".format(text, r2.cmd("ar rax")))

  elif number == 0xFF:
    print("Exiting vm")
    r2.cmd("qq")

#sys.stdout.write("Sycall")
handle_intr(int(sys.argv[1], 0))

r2.quit()
