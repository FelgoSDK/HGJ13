import VPlay 1.0
import QtQuick 1.1

Item {
  id: audioManager

  // Use Sound IDs to play Sounds e.g. audioManager.play(audioManager.idBUTTON)
  property int idBUTTON: 11
  property int idURAD: 22
  property int idURAG: 33
  property int idDRUG: 44
  property int idNEVER: 55
  property int idEND: 66

  // Use Music IDs to play Music. e.g. audioManager.playMusic(audioManager.idMusicBG)
  property int idMusicBG: 111
  property int idMusicFanfare: 222
  property int idMusicCROWD: 333

  function play(clipID) {
    // if settings disable do not play sounds
    if(!settingsManager.sound)
      return

    switch(clipID) {
    case idBUTTON:
      clip.source = "../audio/button.wav"
      break
    case idURAD:
      clip.source = "../audio/ura_d.wav"
      break
    case idURAG:
      clip.source = "../audio/ura_g.wav"
      break
    case idDRUG:
      clip.source = "../audio/drug.wav"
      break
    case idNEVER:
      clip.source = "../audio/never.wav"
      break
    case idEND:
      clip.source = "../audio/end_music.mp3"
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
    case idMusicFanfare:
      music.source = "../audio/end_music.mp3"
      music.volume = 1
      break
    case idMusicCROWD:
      music.source = "../audio/crowd.wav"
      music.volume = 0.2
      break
    }

    music.play()
  }

  function stopMusic() {
    music.stop()
  }

  BackgroundMusic {
    id: music
    autoPlay: false
  }

  Sound {
    id: clip
    volume: 1
  }
}
