# iOS sound fader for AvAudioPlayer written in Swift

This is an iOS utility class that allows to fade sounds in and out with `AvAudioPlayer`. One can set duration and velocity of the fade. Velocity can vary from linear to logarithmic.

## Installation

Copy [iiFaderForAvAudioPlayer.swift](https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/FaderForAvAudioPlayer/iiFaderForAvAudioPlayer.swift) file to your project.

## Usage

### Play an audio file

```Swift
import AVFoundation

let soundURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "my_lovely_horse.mp3", nil, nil)
let player = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
player.play()
player.volume = 0
```

### Instantiate a fader

```Swift
let fader = iiFaderForAvAudioPlayer(player: player)
fader.fadeIn()
fader.fadeOut()
```

I would create a fader property somewhere in my app and keep a strong reference to the fader.

### Set fade duration and velocity

```Swift
fader.fadeIn(duration: 3, velocity: 2)
```

### Supply fade start/end volume, completion callback

```Swift
fader.fade(fromVolume: 0.3, toVolume: 0.7, duration: 3, velocity: 2) { finished in
  // fading finished
}
```

### Set the quality of fade

```Swift
fader.volumeAlterationsPerSecond = 20
```

Larger numbers will produce finer fade effect at expense of CPU juice.

## Volume functions

The following graph shows functions I am using for calculating the volume for the fade.

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/ios-fader-formula-graph-logarithmic.png" alt="Sound fade logarithmic velocity function for iOS/Swift" width="457">

### Fade in formula

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/audio-fade-out-formula-logarithmic.png" alt="Sound fade out logarithmic formula" width="160">

### Fade out formula

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/audio-fade-in-formula-logarithmic.png" alt="Sound fade in logarithmic formula" width="192">

Where `x` is time and `v` is velocity.

Velocity of 0 creates a linear fade. Values greater than zero produce more logarithmic fade affect. Logarithmic function makes the volume increase sound more gradual to a human ear. I personally use velocity values from 2 to 5.

Live graph demo: https://www.desmos.com/calculator/wnstesdf0h

## Demo app

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/sound-fader-ios-swift.png" alt="Sound fader for iOS written in swift" width="320">

## Attribution

The lovely music was recorded by Carlos Vallejo and downloaded from
http://www.flashkit.com/loops/Easy_Listening/Ill_Be_-Carlos_V-10012/index.php
