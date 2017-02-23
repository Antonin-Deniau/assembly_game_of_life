from tkinter import * 

from mlv_screen import *
from mlv_debugger import *
from mlv_cpu import *

class TkApp(Tk):
  def __init__(self):
    Tk.__init__(self)

    self.label = Label(text="My little VM")

    self.binary = None

    self.devices = []
    self.devices.append(Screen(self)) # a changer
    self.devices.append(Debugger("./debugger.log")) # a changer

  def run_binary(self): # a changer
    Cpu(self.devices, self.binary).start()

  def load_binary(self, binary):
    self.binary = binary
