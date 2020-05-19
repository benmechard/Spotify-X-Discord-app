#test change

import sys
import os

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, QUrl, Property, Slot

import discordapi

import translator
import time
import asyncio

translator = translator.Translator()
print("running")
discordapi.start()

sys.argv += ['--style', 'material']
app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.rootContext().setContextProperty("translator", translator)

engine.load(os.path.join(os.path.dirname(__file__), "loadingSplash.qml"))
app.exec_()

engine.load(os.path.join(os.path.dirname(__file__), "gui.qml"))

if not engine.rootObjects():
    sys.exit(-1)
sys.exit(app.exec_())
