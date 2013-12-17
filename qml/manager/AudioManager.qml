import VPlay 1.0
import QtQuick 1.1

Item {
  id: audioManager

  // Use Sound IDs to play Sounds e.g. audioManager.play(audioManager.idBUTTON)
  property int idBUTTON: 11
  property int idEXPOLOSION: 22
  property int idSHOOT: 33


  // Use Music IDs to play Music. e.g. audioManager.playMusic(audioManager.idMusicBG)
  property int idMusicBG: 111
  property int idMusicINGAME: 222

  function play(clipID) {
    // if settings disable do not play sounds
    if(!settingsManager.sound)
      return

    switch(clipID) {
    case idBUTTON:
      clip.source = "../audio/button.wav"
      break
    case idEXPOLOSION:
      clip.source = "../audio/explosion.wav"
      break
    case idSHOOT:
      clip.source = "../audio/shoot.wav"
      break
    }

    if(settingsManager.vibrate) {
      nativeUtils.vibrate()
    }

    clip.play()
  }

  function playMusic(trackID) {
    // if settings disable do not play sounds
    if(!settingsManager.music)
      return

    switch(trackID) {
    case idMusicBG:
      music.source = "../audio/title_music.wav"
      music.volume = 1
      break
    case idMusicINGAME:
      music.source = "../audio/ingame_music.mp3"
      music.volume = 1
      break
    }

    music.play()
  }

  function stopMusic() {
    music.stop()
  }

  BackgroundMusic {
    id: music
  }

  Sound {
    id: clip
    volume: 1
  }
}
