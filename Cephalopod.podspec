Pod::Spec.new do |s|
  s.name        = "Cephalopod"
  s.version     = "1.0.1"
  s.license     = { :type => "MIT" }
  s.homepage    = "https://github.com/evgenyneu/Cephalopod"
  s.summary     = "A sound fader for AVAudioPlayer written in Swift."
  s.description  = <<-DESC
                   This library can help fading sounds in and out with AvAudioPlayer. One can set duration and velocity of the fade. Velocity can vary from linear to exponential.
                   DESC
  s.authors     = { "Evgenii Neumerzhitckii" => "sausageskin@gmail.com" }
  s.source      = { :git => "https://github.com/evgenyneu/Cephalopod.git", :tag => s.version }
  s.screenshots  = "https://github.com/evgenyneu/Cephalopod/raw/master/graphics/cephalopod_logo.png"
  s.source_files = "Cephalopod/**/*.swift"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.tvos.deployment_target = "9.0"
end