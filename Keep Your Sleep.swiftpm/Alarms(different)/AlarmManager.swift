import SwiftUI
import AVFoundation
import Foundation
import Subsonic

import Combine

class AlarmTimerManager: ObservableObject {
    private var timer: AnyCancellable?
    @AppStorage ("Sound") private var savedSound = "Boom.mp3"
    @StateObject var oints = GlobalAppData.numberClick
    @AppStorage ("oints") private var points = 0
    @StateObject var gooff = GlobalAppData.numberClick
    @AppStorage ("gooff") private var alarmgooff = false
    init(viewModel: AlarmViewModel) {
        self.timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.checkActiveAlarms(viewModel: viewModel)
            }
    }
    
    func getCurrentSystemTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let currentTime = Date()
        let systemTime = dateFormatter.string(from: currentTime)
        
        return systemTime
    }
    
    private func checkActiveAlarms(viewModel: AlarmViewModel) {
        for alarm in viewModel.alarms {
            
            let singaporeTimeZone = TimeZone(identifier: "Asia/Singapore")!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            dateFormatter.timeZone = singaporeTimeZone // Set the time zone to Singapore
            
            let currentTime = Date()
            
            print("Alarm time: \(alarm.time)")
            print("Current time: \(currentTime)")
            
            if alarm.time <= currentTime && alarm.isActive {
                // Debugging: Print information about triggered alarms
                if let label = alarm.label {
                    print("Triggered alarm: \(label) at \(dateFormatter.string(from: alarm.time))")
                } else {
                    print("Triggered alarm at \(dateFormatter.string(from: alarm.time)) (no label)")
                }
                
                // Trigger the ring sound here
                
                
                alarm.isPlaying = true
                playRingSound(isPlaying: alarm.isPlaying)
                
                alarmgooff = true
                //             alarm.isTriggered = true
                points += Int.random(in: 1...15)
                // Debugging: Print information after playing the sound
                if let label = alarm.label {
                    print("Ring sound played for alarm: \(label)")
                } else {
                    print("Ring sound played for alarm (no label)")
                }
                
                // Update alarm activation status
                viewModel.toggleAlarmActivation(alarm: alarm)
                
                // Debugging: Print information after updating activation status
                if let label = alarm.label {
                    print("Activation status for alarm \(label) changed to \(alarm.isActive)")
                } else {
                    print("Activation status for alarm changed to \(alarm.isActive) (no label)")
                }
            }
        }
    }
    
    
    private func playRingSound(isPlaying: Bool) {
        //        if let soundURL = Bundle.main.url(forResource: "Boom", withExtension: "mp3") {
        //            do {
        //                let player = try AVAudioPlayer(contentsOf: soundURL)
        //                player.numberOfLoops = 3 // Adjust as needed
        //                play(sound: "Boom.mp3")
        //                
        //                // Debugging: Print when the ring sound starts playing
        //                print("Ring sound started playing.")
        //            } catch {
        //                // Debugging: Print any errors that occur during audio playback
        //                print("Error playing ring sound: \(error.localizedDescription)")
        //            }
        //        }
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
}
