# iOS sound fader for AvAudioPlayer written in Swift

This is an iOS utility class that allows to fade in/out sound when playing sounds with `AvAudioPlayer`. It allows to control duration and velocity of the fade. Velocity can vary from linear to logariphmic.

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
```

I would create a property somewhere in my app to keep a strong reference to the fader.

### Fade in

```Swift
fader.fadeIn()
```

### Fade out

```Swift
fader.fadeOut()
```

### Set fade duration and velocity

```Swift
fader.fadeIn(duration: 3, velocity: 2)
```

Velocity of 0 creates a linear fade. Values greater than zero produce more logarithmic fading to make it sound more even to humans ear. I personally use velocity values from 2 to 5.


## Volume functions

The following graph shows functions I am using for calculating the volume for the fade. Green one is for fade in and blue is for fade out.

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/ios-fader-formula-graph-logarithmic.png" alt="Sound fade logarithmic velocity function for iOS/Swift" width="457">

Live graph demo: https://www.desmos.com/calculator/mvd9n5rrii

## Demo app

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/sound-fader-ios-swift.png" alt="Sound fader for iOS written in swift" width="320">

## Attribution

The lovely music was recorded by Carlos Vallejo and downloaded from
http://www.flashkit.com/loops/Easy_Listening/Ill_Be_-Carlos_V-10012/index.php
