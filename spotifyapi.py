
import os
from dotenv import load_dotenv
import json
import spotipy
import spotipy.util as util

load_dotenv()
CLIENT_SECRET = os.getenv('CLIENT_SECRET')
print("spotify")
# get username
loginUsername = "Dustylishous"
scope = 'user-read-private user-read-playback-state user-modify-playback-state'  # what the program is allowed to modify

# erase cache and prompt for user permission
try:
    token = util.prompt_for_user_token(loginUsername,
                                       scope,
                                       client_id='93b5d79d86644cbe91c43b1367ab3564',
                                       client_secret=CLIENT_SECRET,
                                       redirect_uri='http://google.com/')
except:
    print("error")
    os.remove(f".cache-{loginUsername}")
    token = util.prompt_for_user_token(loginUsername,
                                       client_id='93b5d79d86644cbe91c43b1367ab3564',
                                       client_secret=CLIENT_SECRET,
                                       redirect_uri='http://google.com/')
# create our spotifyObject
spotifyObject = spotipy.Spotify(auth=token)




#commands
def activate():
    spotifyObject.start_playback(device_id="558cbcdb33b1fad8821915123a3701d41ebf1592", context_uri="spotify:user:spotify:playlist:37i9dQZF1E38lu5p5uTI7Y")

def play():
    spotifyObject.start_playback()

def pause():
    spotifyObject.pause_playback()

def skip():
    spotifyObject.next_track()

def skipBack():
    spotifyObject.previous_track()

def seekTrack(pos):  # position in milliseconds
    spotifyObject.seek_track(pos)

def repeat(state):  # track, context, or off
    spotifyObject.repeat(state)

def setVolume(percent):
    spotifyObject.volume(percent)

def search(query):
    spotifyObject.search(query)



#checks
def currentPlayback():
    return spotifyObject.current_playback()

def username():
    return spotifyObject.current_user()['display_name']

def currentSongName():
    return spotifyObject.current_playback()['item']['name']

def currentAlbumArt():
    return spotifyObject.current_playback()['item']['album']['images'][2]['url']

def isActive():
    return spotifyObject.current_playback()['device']['is_active']

def isPlaying():
    return spotifyObject.current_playback()['is_playing']

def volumeCheck():
    return spotifyObject.current_playback()['device']['volume_percent']

def trackID():
    return spotifyObject.current_playback()['item']['album']['id']

def currentPos():
    return spotifyObject.current_playback()['progress_ms']

def songLegnth(): # returns in ms
    return spotifyObject.current_playback()['item']['duration_ms']


#print(json.dumps(VARIABLE, sort_keys=True, indent=4))
