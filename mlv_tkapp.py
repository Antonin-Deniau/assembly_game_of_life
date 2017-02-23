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

    # threads
    self._thread, self._pause, self._stop = None, False, True

  def action(self):
    self.cpu.load_in_memory(self.binary)
    self.cpu.run()

  #def pause(self):
  #  self._pause = True

  #def stop(self):
  #  if self._thread is not None:
  #   self._thread, self._pause, self._stop = None, False, True

  def run_binary(self): # a changer
    if self._thread is None:
      self._stop = False
      self._thread = Thread(target=self.action)
      self._thread.start()

    self._pause = False

  def load_binary(self, binary):
    self.binary = binary
