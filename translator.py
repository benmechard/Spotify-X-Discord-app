from datetime import datetime
from PySide2.QtCore import QObject, Slot

import spotifyapi

import discordapi

class Translator(QObject):
    def __init__(self, parent=None):
        QObject.__init__(self, parent)
        self.currentPlayback = spotifyapi.currentPlayback()
        self.isActive = False
        self.isActiveCheck()

    def isActiveCheck(self):
        if (self.currentPlayback == None):
            self.isActive = False
        else:
            self.isActive = True

    def activate(self):
        if (not self.isActive):
            spotifyapi.activate()

    @Slot()
    def update(self): #make update once a sec
        self.currentPlayback = spotifyapi.currentPlayback()
        self.isActiveCheck()

################################################################################
#                    """SPOTIFY COMMANDS"""
################################################################################
    @Slot()
    def play(self):
        self.activate()
        if spotifyapi.isPlaying():
            spotifyapi.pause()
        else:
            spotifyapi.play()

    @Slot()
    def skip(self):
        self.activate()
        spotifyapi.skip()

    @Slot()
    def skipBack(self):
        self.activate()
        spotifyapi.skipBack()

    @Slot(float)
    def setSongPos(self, percent):
        self.activate()
        spotifyapi.seekTrack(percent) #in ms

    @Slot(float) #"""NEEDS TO BE FIXED"""
    def setVolume(self, volume):
        spotifyapi.setVolume(int(volume * 100))

################################################################################
#                    """SPOTIFY CHECKS"""
################################################################################
    @Slot(result=str)
    def isPlaying(self):
        if(not self.isActive):
            pass
        else:
            if (self.currentPlayback["is_playing"]):
                return "pause"
            else:
                return "play"

    @Slot(result=float)
    def songPos(self): # 0.0 => 0.5 => 1.0
        if(not self.isActive):
            pass
        else:
            length = self.currentPlayback['item']['duration_ms']
            currentPos = self.currentPlayback['progress_ms']
            return(currentPos/length)

    @Slot(result=float)
    def volumeCheck(self):
        if(not self.isActive):
            pass
        else:
            return (self.currentPlayback['device']['volume_percent'] / 100)

    @Slot(result=str)
    def albumArt(self):
        if(not self.isActive):
            pass
        else:
            return self.currentPlayback['item']['album']['images'][2]['url']

    @Slot(result=str)
    def currentSong(self):
        if(not self.isActive):
            pass
        else:
            return self.currentPlayback['item']['name']

################################################################################
#                    """DISCORD CHECKS"""
################################################################################
    @Slot(result=int)
    def ready(self):
        return discordapi.readyFlag

#MSG STUFF
    @Slot(int, result=str)
    def msgContent(self, pos):
        return discordapi.messages[pos].content

    @Slot(int, result=str)
    def authorName(self, pos):
        return str(discordapi.messages[pos].author.display_name)

    @Slot(int, result=str)
    def authorColor(self, pos):
        return '#%02x%02x%02x' % (discordapi.messages[pos].author.color.to_rgb())

    @Slot(int, result=str)
    def msgTime(self, pos):
        return discordapi.messages[pos].created_at.strftime("%a, %H:%M:%S")
    

#CHANNEL STUFF
    @Slot(result=int)
    def numberOfChannels(self):
        return len(discordapi.currentGuild.channels)

    @Slot(int, result=str)
    def channelName(self, pos):
        return discordapi.currentGuild.channels[pos].name


#MEMBER STUFF
    @Slot(result=int)
    def numberOfMembers(self):
        return len(discordapi.currentGuild.members)

    @Slot(int, result=str)
    def memberName(self, pos):
        return discordapi.currentGuild.members[pos].display_name

    @Slot(int, result=str)
    def memberRoleName(self, pos):
        return discordapi.currentGuild.members[pos].role.name

    @Slot(result=int)
    def numberOfRoles(self):
        return len(discordapi.currentGuild.roles)

    @Slot(int, result=str)
    def roleName(self, pos):
        return discordapi.currentGuild.roles[pos].name
