import QtQuick 2.7
import QtQuick.Window 2.13
import QtQuick.Controls 2.14


Window {
  id: splash
  color: "#333333"
  title: "Loading..."
  width: 640
  height: 480
  flags: Qt.FramelessWindowHint
  visible: true
  function readyCheck() {
      if (translator.ready() == true){
        splash.close()
      }
  }
  Timer {
    interval: 500; running: true; repeat: true
    onTriggered: readyCheck()
  }
  Text {
    text: "Loading . . ."
    color: "#FFFFFF"
    font.pointSize: 40
    anchors{
      horizontalCenter: parent.horizontalCenter
      verticalCenter: parent.verticalCenter
    }
  }
}
