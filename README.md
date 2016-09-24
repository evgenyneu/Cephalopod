# Cephalopod, a sound fader for AvAudioPlayer written in Swift / iOS, tvOS, macOS and watchOS

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)][carthage]
[![CocoaPods Version](https://img.shields.io/cocoapods/v/Auk.svg?style=flat)][cocoadocs]
[![License](https://img.shields.io/cocoapods/l/Auk.svg?style=flat)](LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/Auk.svg?style=flat)][cocoadocs]
[cocoadocs]: http://cocoadocs.org/docsets/Auk
[carthage]: https://github.com/Carthage/Carthage

This library allows to fade sounds in and out with AvAudioPlayer. One can set duration and velocity of the fade. Velocity can vary from linear to logarithmic.


<img src='https://github.com/evgenyneu/Cephalopod/raw/master/graphics/cuttlefish.jpg' alt='Juvenile cuttlefish camouflaged against the seafloor' width='382'>

*"Juvenile cuttlefish camouflaged against the seafloor". Photo taken by [Raul654](https://en.wikipedia.org/wiki/User:Raul654). Source: [Wikimedia Commons](https://en.wikipedia.org/wiki/File:Camouflage.jpg).*


## Setup (Swift 3.0 / Xcode 8)

<!-- There are three ways you can add Auk to your Xcode project.

#### Add source (iOS 7+)

Simply add two files to your project:

1. Moa image downloader [MoaDistrib.swift](https://github.com/evgenyneu/moa/blob/master/Distrib/MoaDistrib.swift).
2. Auk image slideshow [AukDistrib.swift](https://github.com/evgenyneu/Auk/blob/master/Distrib/AukDistrib.swift).

#### Setup with Carthage (iOS 8+)

1. Add `github "evgenyneu/Auk" ~> 7.0` to your Cartfile.
2. Run `carthage update`.
3. Add `moa` and `Auk` frameworks into your project.

#### Setup with CocoaPods (iOS 8+)

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    target 'Your target name'
    pod 'moa', '~> 8.0'
    pod 'Auk', '~> 7.0' -->



<!-- ### Legacy Swift versions

Setup a [previous version](https://github.com/evgenyneu/Auk/wiki/Legacy-Swift-versions) of the library if you use an older version of Swift. -->



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

The following graph shows how sound volume changes during the fade.

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/ios-fader-formula-graph-logarithmic.png" alt="Sound fade logarithmic velocity function for iOS/Swift" width="457">

### Fade in formula

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/audio-fade-out-formula-logarithmic.png" alt="Sound fade out logarithmic formula" width="160">

### Fade out formula

<img src="https://raw.githubusercontent.com/evgenyneu/sound-fader-ios/master/graphics/audio-fade-in-formula-logarithmic.png" alt="Sound fade in logarithmic formula" width="192">

Where `x` is time and `v` is velocity.

Velocity of 0 creates a linear fade. Values greater than zero produce more logarithmic fade affect. Logarithmic fade sounds more gradual to a human ear. I personally use velocity values from 2 to 5.

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
