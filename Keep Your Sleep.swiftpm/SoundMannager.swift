import SwiftUI
import Subsonic
import AVFoundation
class SoundManager: ObservableObject{
    @AppStorage ("Sound") private var savedSound = "Boom.mp3"
    private func playRingSound(isPlaying: Bool) {
        
        play(sound: "\(savedSound)",isPlaying: isPlaying)
    }
    func play(sound: String, isPlaying: Bool) {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
        } catch {
            print(error)
        }
        if isPlaying == true{
            SubsonicController.shared.play(sound: sound, from: .main, volume: 1, repeatCount: 0)
        } else{
            SubsonicController.shared.stopAllManagedSounds()
        }
        
    }
    func stopAlarmSound() {
        playRingSound(isPlaying:false)
    }
}
