from unicorn.x86_const import *

class Screen:
  def __init__(self, canvas):
    self.canvas = canvas

  def draw_dots(self, matrix):
    lines = [matrix[i:i + width] for i in range(0, len(matrix), width)]

    for x in xrange(SCREEN_WIDTH):
      for y in xrange(SCREEN_HEIGHT):
        dot = chr(lines[x][y])

        try:
          self.canvas.create_text(x * PIX_WIDTH + PIX_WIDTH, y * PIX_HEIGHT + PIX_HEIGHT, text=dot, font="Arial 10", fill="white")
        except:
          self.canvas.create_text(x * PIX_WIDTH + PIX_WIDTH, y * PIX_HEIGHT + PIX_HEIGHT, text="?", font="Arial 10", fill="white")

  def handle_int(self, uc, intno):
    if intno == 0x1:
      self.draw_screen(uc)

  def draw_screen(self, uc):
    offset = self.uc.reg_read(UC_X86_REG_RAX)
    matrix = self.uc.mem_read(offset, SCREEN_WIDTH * SCREEN_HEIGHT)
    self.draw_dots(matrix)
    #self.canvas.refresh()
