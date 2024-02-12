import SwiftUI
import AVFoundation
import Subsonic

struct VoiceDetailView: View{
    @Binding var voice: VoiceAlarm
    @StateObject var Sound = GlobalAppData.numberClick
    @AppStorage ("Sound") private var savedSound = "Boom"
    @State var num = 0
    var body: some View{
        VStack{
            Button{
                play(sound: "\(voice.title).mp3")
                num += 1
                print("Hello x", num)
            }label : {
                Text("Play sound")
                    .font(.system(size: 28))
                    .multilineTextAlignment(.center)
                    .padding()
            }
            Button{
                savedSound = voice.title + ".mp3"
            }label:{
                Text("Set as sound?")
            }
        }
        .navigationTitle("\(voice.title)")
    }
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
}
