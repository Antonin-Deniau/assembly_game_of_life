from unicorn.x86_const import *
from tkinter import * 

#self.root.bind("<Key>", key) KEYBOARD
#  def key(event):
#    print "pressed", repr(event.char)

SCREEN_WIDTH = 100
SCREEN_HEIGHT = 50

PIX_HEIGHT = 8
PIX_WIDTH = 7

WINDOW_WIDTH = SCREEN_WIDTH * PIX_WIDTH
WINDOW_HEIGHT = SCREEN_HEIGHT * PIX_HEIGHT

class Screen:
  def __init__(self, tk):
    self.tk = tk

    self.tk.canvas = Canvas(width=WINDOW_WIDTH, height=WINDOW_HEIGHT, background='black')
    self.tk.canvas.bind("<Button-1>", self.callback)
    self.tk.canvas.pack()

  def callback(self, event):
    print "clicked at", event.x, event.y

  def draw_dots(self, matrix):
    lines = [matrix[i:i + SCREEN_WIDTH] for i in range(0, len(matrix), SCREEN_WIDTH)]

    for x in xrange(SCREEN_HEIGHT):
      for y in xrange(SCREEN_WIDTH):

        try:
          dot = chr(lines[x][y])
          if dot != " ":
            self.tk.canvas.create_text(x * PIX_WIDTH + PIX_WIDTH, y * PIX_HEIGHT + PIX_HEIGHT, text=dot, font="Arial 10", fill="white")
        except:
          "do noting"

  def handle_int(self, uc, intno):
    if intno == 0x1:
      self.draw_screen(uc)

  def draw_screen(self, uc):
    offset = uc.reg_read(UC_X86_REG_RAX)
    matrix = uc.mem_read(offset, SCREEN_WIDTH * SCREEN_HEIGHT)
    self.tk.canvas.delete(ALL)
    self.draw_dots(matrix)
    self.tk.update()
