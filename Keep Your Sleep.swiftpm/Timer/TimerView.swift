
import Dispatch
import Subsonic
import AVFoundation
class TimerManager: ObservableObject {
    //    @Published var remainingTime: TimeInterval = 0
    @StateObject var Time = GlobalAppData.numberClick
    @AppStorage ("Time") var remainingTime: TimeInterval = 0
    @AppStorage ("Sound") private var savedSound = "Boom"
    var timer: DispatchSourceTimer?
    var countdownInterval: Double = 1.0
    func play(sound: String) {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
        } catch {
            print(error)
        }
        SubsonicController.shared.play(sound: sound, from: .main, volume: 1, repeatCount: 0)
    }
    func startCountdown(hours: Int, minutes: Int, seconds: Int) {
        // Calculate the total countdown time in seconds
        let totalSeconds = TimeInterval(hours * 3600 + minutes * 60 + seconds)
        remainingTime = totalSeconds
        // Create a new DispatchSourceTimer with the provided interval
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        
        // Set the timer to repeat and fire every provided interval
        timer?.schedule(deadline: .now(), repeating: countdownInterval)
        
        // Set the timer's event handler
        timer?.setEventHandler { [weak self] in
            guard let self = self else {
                return
            }
            
            // Decrement the remaining time and perform the countdown handler action
            self.remainingTime -= self.countdownInterval
            if self.remainingTime <= 0 {
                // Countdown has reached zero, stop the timer
                self.stopTimer()
                
                play(sound: "\(savedSound)")
            }
        }
        
        // Start the timer
        timer?.resume()
    }
    
    func stopTimer() {
        // Cancel the timer
        timer?.cancel()
        timer = nil
        remainingTime = 0
    }
}

import SwiftUI

struct CountdownTimerView: View {
    @ObservedObject private var timerManager = TimerManager()
    @AppStorage ("background") private var savedbackground = "defaultbackground"
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    @State private var isCountingDown = false
    
    var body: some View {
        ZStack{
            
            VStack {
                Text("Countdown Timer")
                    .font(.title)
                    .padding()
                
                HStack {
                    Text("Hours:")
                    Stepper(value: $hours, in: 0...23) {
                        Text("\(hours) h")
                    }
                }
                
                HStack {
                    Text("Minutes:")
                    Stepper(value: $minutes, in: 0...59) {
                        Text("\(minutes) min")
                    }
                }
                
                HStack {
                    Text("Seconds:")
                    Stepper(value: $seconds, in: 0...59) {
                        Text("\(seconds) sec")
                    }
                }
                
                Button(action: {
                    // Start or restart the countdown when the button is tapped
                    print(formatTime(remainingTime: timerManager.remainingTime))
                    startCountdown()
                }) {
                    Text(isCountingDown ? "Reset" : "Start Countdown")
                }
                //            Button(action:{
                //                timerManager.remainingTime = 0
                //            }){
                //                Text("reset time")
                //            }
                Text(formatTime(remainingTime: timerManager.remainingTime))
                    .font(.title)
                    .padding()
            }
        }
    }
    
    private func startCountdown() {
        if isCountingDown {
            // If already counting down, reset the timer
            timerManager.stopTimer()
            isCountingDown = false
        } else {
            // Start the countdown
            let totalSeconds = hours * 3600 + minutes * 60 + seconds
            timerManager.startCountdown(hours: hours, minutes: minutes, seconds: seconds)
            isCountingDown = true
        }
    }
    
    private func formatTime(remainingTime: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: remainingTime)!
    }
}

struct CountdownTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimerView()
    }
}


