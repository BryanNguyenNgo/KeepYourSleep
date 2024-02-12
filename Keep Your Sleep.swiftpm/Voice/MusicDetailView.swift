import SwiftUI
import AVFoundation
import Subsonic

struct MusicDetailView: View{
    @Binding var song: Music
    @State var num = 0
    var body: some View{
        VStack{
            Button{
                play(sound: "\(song.title).mp3")
                num += 1
                print("Hello x", num)
            }label : {
                Text("Play sound")
                    .font(.system(size: 28))
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .navigationTitle("\(song.title)")
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
