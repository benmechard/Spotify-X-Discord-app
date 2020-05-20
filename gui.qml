import QtQuick 2.7
import QtQuick.Window 2.13
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.0
import "javaTest.js" as RoleFolder

Window {
  id: root
  title: "Discord X Spotify Player"
  width: 1200
  height: 800
  visible: true
  Material.theme: Material.Dark

  function update() {
    translator.update()
    songName.text = translator.currentSong()
    volume.value = translator.volumeCheck()
    songProgress.value = translator.songPos()
  }

  Timer {
    interval: 500; running: true; repeat: true
    onTriggered: root.update()
  }
/////////////////////////DISCORD BAR////////////////////////////////////////////
  Rectangle{
    id: discordBar
    width:parent.width
    anchors{
      top: parent.top
      bottom: spotifyBar.top
    }
/////////////////////////GUILD BAR//////////////////////////////////////////////
    Rectangle{
      id:guildBar
      width: 75
      color: "#222222"
      anchors{
        left: parent.left
        top: parent.top
        bottom: parent.bottom
      }
    }
/////////////////////////CHANNEL BAR////////////////////////////////////////////
    Rectangle{
      id: channelBar
      width: 240
      color: "#333333"
      anchors{
        left: guildBar.right
        top: parent.top
        bottom: parent.bottom
      }
      ListModel {
        id: channelBarModel
        Component.onCompleted: {
          for (var i = 0; i < translator.numberOfChannels(); i++) {
            append({"name": translator.channelName(i)});
          }
        }
      }
      ListView {
        id: channels
        clip: true
        model: channelBarModel
        delegate: Text {
          text: name
          color: "#FFFFFF"
          font.pointSize: 11
          padding: 10
          wrapMode: Text.WordWrap
        }
        flickableDirection: Flickable.VerticalFlick
        ScrollBar.vertical: ScrollBar {}
        anchors {
          top: parent.top
          bottom: parent.bottom
          left: parent.left
          right: parent.right
      }
    }
  }
/////////////////////////MEMBER BAR/////////////////////////////////////////////
    Rectangle{
      id: memberBar
      width: 240
      color: "#333333"
      anchors{
        top: parent.top
        bottom: parent.bottom
        right: parent.right
      }
      
      Column{
        Component.onCompleted:{
          var roles = translator.roleName()
          var rolePos
          for (rolePos in roles){
            RoleFolder.createTextObjects(roles[rolePos], this)

            var members = translator.roleCheck(roles[rolePos])
            var memberPos
            if (members != []){
              for (memberPos in members){
                RoleFolder.createTextObjects(members[memberPos], this)
              }
            }
          }
        }
      }
      /*ListModel {
        id: memberBarChannel
        Component.onCompleted: {
          //for (var i = 0; i < translator.numberOfMembers(); i++) {
            //append({"name": translator.memberName(i)});
          for (var j = 0; j < translator.numberOfRoles(); j++){
            append({"roleName": translator.roleName(j)});
          }
        }
      }
      ListView {
        id: members
        clip: true
        model: memberBarChannel
        delegate: Text {
          text: roleName
          color: "#FFFFFF"
          font.pointSize: 11
          padding: 10
          wrapMode: Text.WordWrap
        }
        flickableDirection: Flickable.VerticalFlick
        ScrollBar.vertical: ScrollBar {}
        anchors {
          top: parent.top
          bottom: parent.bottom
          left: parent.left
          right: parent.right
        }
      }*/
    }
/////////////////////////MESSAGE BAR////////////////////////////////////////////
    Component{
      id: testDelegate
      Item{
        height: msgAuthor.height + msgContent.height + 10
        anchors{
          left: parent.left
          right: parent.right
          leftMargin: 10
          }
        Column{
          id: msgIcon
          Text{
            text: "place\nholder"
            color: "white"
            font.pointSize: 13
          }
        }
        Column{
          anchors{
            left: msgIcon.right
            right: parent.right
            leftMargin: 10
          }
          Row{
            Text{
              id: msgAuthor
              text: author
              color: authorColor
              font.pointSize: 13
              wrapMode: Text.WordWrap
            }
            Text{
              id: msgTime
              text: time
              color: "gray"
              font.pointSize: 8
              wrapMode: Text.WordWrap
              leftPadding: 10
              anchors{
                bottom: parent.bottom
                bottomMargin: 2
                }
            }
          }
          Text{
            id: msgContent
            text: content
            color: "white"
            width: parent.width
            font.pointSize: 13
            wrapMode: Text.Wrap
          }
        }
      }
    }
    Rectangle{
      id: messageBar
      color: "#444444"
      anchors{
        left: channelBar.right
        right: memberBar.left
        top: parent.top
        bottom: parent.bottom
      }
      ListModel {
        id: messageBarModel
        Component.onCompleted: {
          for (var i = 0; i < 100; i++) {
            append({"content": translator.msgContent(i),
                    "author": translator.authorName(i),
                    "authorColor": translator.authorColor(i),
                    "time": translator.msgTime(i)});
          }
        }
      }
      ListView {
        id: messages
        clip: true
        model: messageBarModel
        delegate: testDelegate
        flickableDirection: Flickable.VerticalFlick
        ScrollBar.vertical: ScrollBar {}
        anchors {
          top: parent.top
          bottom: messageInput.top
          left: parent.left
          right: parent.right
        }
      }
/////////////////////////TEXT INPUT/////////////////////////////////////////////
      TextField{
        id: messageInput
        height: 50
        color: "white"
        background: Rectangle{
          color: "#555555"
          radius: 7
        }
        font.pointSize: 11
        anchors{
          left: parent.left
          right: parent.right
          bottom: parent.bottom
          leftMargin: 10
          rightMargin: 10
          bottomMargin: 10
        }
      }
    }
  }

  ///////////////////////SPOTIFY BAR////////////////////////////////////////////
  Rectangle{
    id: spotifyBar
    color: "#323232"
    width:parent.width
    height: 100
    anchors {
      bottom: parent.bottom
    }
    /////////////////////PLAY BUTTON////////////////////////////////////////////
    Button {
      id: playButton
      text: translator.isPlaying()
      width: 60
      anchors{
        horizontalCenter: parent.horizontalCenter
      }
      function playSwitch() {
        if (playButton.text == "play"){
          playButton.text = "pause"
        }
        else{
          playButton.text = "play"
        }
      }
      onClicked: {
        translator.play()
        playButton.playSwitch()
      }
    }
    /////////////////////SKIP BUTTON////////////////////////////////////////////
    Button {
      id: skipButton
      text: "skip"
      width: 60
      anchors{
        left:playButton.right
        leftMargin: 5
      }
      onClicked: {
        translator.skip()
      }
    }
    /////////////////////BACK BUTTON////////////////////////////////////////////
    Button {
      id: backButton
      text: "back"
      width: 60
      anchors{
        right:playButton.left
        rightMargin: 5
      }
      onClicked: {
        translator.skipBack()
      }
    }
    /////////////////////SONG NAME//////////////////////////////////////////////
    Text {
      id: songName
      font.pointSize: 11
      text: translator.currentSong()
      color: "white"
      width: 100
      wrapMode: Text.WordWrap
      anchors {
        left: parent.left
        bottom: parent.bottom
        bottomMargin: 15
        leftMargin: 100
      }
    }
    /////////////////////VOLUME/////////////////////////////////////////////////
    Slider {
      id: volume
      width: 175
      value: translator.volumeCheck()
      live: false
      anchors{
        verticalCenter: parent.verticalCenter
        right: parent.right
        
        rightMargin: 20
      }
      onValueChanged: {
        translator.setVolume(value)
      }
    }
    /////////////////////SONG PROGRESS//////////////////////////////////////////
    Slider {
      id: songProgress
      width: 700
      value: translator.songPos()
      anchors {
        bottom: parent.bottom
        horizontalCenter: parent.horizontalCenter
        bottomMargin: 10
      }
      handle: Rectangle {}
    }
  }
}
