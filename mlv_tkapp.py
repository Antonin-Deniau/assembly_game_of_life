from threading import Thread

from tkinter import * 

from mlv_screen import *
from mlv_debugger import *
from mlv_cpu import *

class TkApp(Tk):
  def __init__(self):
    Tk.__init__(self)

    self.label = Label(text="My little VM")

    self.cpu = Cpu()

    self.cpu.attach(Screen(self)) # a changer
    self.cpu.attach(Debugger("./debugger.log")) # a changer

  def run_binary(self): # a changer
    self.cpu.run()

  def load_binary(self, binary):
    self.cpu.load_in_memory(binary)
