# Cephalopod, a sound fader for AvAudioPlayer written in Swift - iOS, tvOS and macOS

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)][carthage]
[![CocoaPods Version](https://img.shields.io/cocoapods/v/Cephalopod.svg?style=flat)][cocoadocs]
[![License](https://img.shields.io/cocoapods/l/Cephalopod.svg?style=flat)](LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/Cephalopod.svg?style=flat)][cocoadocs]
[cocoadocs]: http://cocoadocs.org/docsets/Cephalopod
[carthage]: https://github.com/Carthage/Carthage

This library can help fading sounds in and out with AvAudioPlayer. One can set duration and velocity of the fade. Velocity can vary from linear to exponential.

```Swift
cephalopod = Cephalopod(player: player)
cephalopod?.fadeIn()
```


<img src='https://github.com/evgenyneu/Cephalopod/raw/master/graphics/cuttlefish.jpg' alt='Juvenile cuttlefish camouflaged against the seafloor' width='382'>

*Juvenile cuttlefish camouflaged against the seafloor. Photo taken by [Raul654](https://en.wikipedia.org/wiki/User:Raul654). Source: [Wikimedia Commons](https://en.wikipedia.org/wiki/File:Camouflage.jpg).*


## Setup (Swift 3.0 / Xcode 8)

There are three ways you can add Cephalopod to your Xcode project.

#### Add source (iOS 7+)

Simply add the [CephalopodDistrib.swift](https://github.com/evgenyneu/Cephalopod/blob/master/Distrib/CephalopodDistrib.swift) file to your project.


#### Setup with Carthage (iOS 8+)

Alternatively, add `github "evgenyneu/Cephalopod" ~> 1.0` to your Cartfile and run `carthage update`.

#### Setup with CocoaPods (iOS 8+)

If you are using CocoaPods add this text to your Podfile and run `pod install`.

```
use_frameworks!
target 'Your target name'
pod 'Cephalopod', '~> 1.0'
```


<!-- ### Legacy Swift versions

Setup a [previous version](https://github.com/evgenyneu/Auk/wiki/Legacy-Swift-versions) of the library if you use an older version of Swift. -->



## Usage


The following example shows how to play an mp3 file with a fade in effect.

```Swift
import AVFoundation
import Cephalopod // For CocoaPods and Carthage
// ---

var playerInstance: AVAudioPlayer?
var cephalopod: Cephalopod?

override func viewDidLoad() {
  super.viewDidLoad()

  // Create player instance
  guard let path = Bundle.main.path(forResource: "squid", ofType: "mp3") else { return }
  guard let player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path)) else { return }
  playerInstance = player

  // Start audio playback
  player.play()
  player.volume = 0

  // Fade in the sound
  cephalopod = Cephalopod(player: player)
  cephalopod?.fadeIn()
}
```

### Fade in / fade out

```Swift
cephalopod?.fadeIn()
cephalopod?.fadeOut()
```

### Set fade duration and velocity

```Swift
cephalopod?.fadeIn(duration: 3, velocity: 2)
```

### Supply fade start/end volume, completion callback

```Swift
cephalopod?.fade(fromVolume: 0.3, toVolume: 0.7, duration: 3, velocity: 2) { finished in
  print("Fade in finished")
}
```

### Set the quality of fade

```Swift
cephalopod?.volumeAlterationsPerSecond = 20
```

Larger numbers will produce finer fade effect at expense of CPU juice.

## Volume functions

The following graph shows how sound volume changes during the fade.

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/ios-fader-formula-graph-logarithmic.png" alt="Sound fade logarithmic velocity function for iOS/Swift" width="457">

### Fade in formula

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/audio-fade-out-formula-logarithmic.png" alt="Sound fade out logarithmic formula" width="160">

### Fade out formula

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/audio-fade-in-formula-logarithmic.png" alt="Sound fade in logarithmic formula" width="192">

Where `x` is time and `v` is velocity.

Velocity of 0 creates a linear fade. Values greater than zero produce more exponential fade affect. Exponential fade sounds more gradual to a human ear. I personally use velocity values from 2 to 5.

Live graph demo: https://www.desmos.com/calculator/wnstesdf0h

## Demo app

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/sound-fader-ios-swift.png" alt="Sound fader for iOS written in swift" width="320">

## Attribution




## Alternative solutions

<!-- Here is a list of other image slideshow libraries for iOS.


* [kimar/KIImagePager](https://github.com/kimar/KIImagePager)
* [kirualex/KASlideShow](https://github.com/kirualex/KASlideShow)
* [nicklockwood/iCarousel](https://github.com/nicklockwood/iCarousel)
* [nicklockwood/SwipeView](https://github.com/nicklockwood/SwipeView)
* [paritsohraval100/PJR-ScrollView-Slider](https://github.com/paritsohraval100/PJR-ScrollView-Slider)
* [zvonicek/ImageSlideshow](https://github.com/zvonicek/ImageSlideshow)
 -->

## Thanks 👍

<!-- * [eyaldar](https://github.com/eyaldar) added `updatePage` method.
* [Valpertui](https://github.com/Valpertui) added `removePage` and `removeCurrentPage` methods.
 -->
## Credits

* The lovely music was recorded by [Carlos Vallejo](http://www.flashkit.com/loops/Easy_Listening/Ill_Be_-Carlos_V-10012/index.php).

* "Juvenile cuttlefish camouflaged against the seafloor". Photo taken by [Raul654](https://en.wikipedia.org/wiki/User:Raul654). Source: [Wikimedia Commons](https://en.wikipedia.org/wiki/File:Camouflage.jpg).


## License

Cephalopod is released under the [MIT License](LICENSE).

## Feedback is welcome

If you notice any issue, got stuck or just want to chat feel free to create an issue. I will be happy to help you.
