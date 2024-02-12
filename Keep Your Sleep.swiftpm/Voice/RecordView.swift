import SwiftUI
import AVFoundation
import Foundation

class AudioRecorder: ObservableObject {
    var audioRecorder: AVAudioRecorder?
    var audioURL: URL?
    var recording = false {
        didSet {
            if recording {
                startRecording()
            } else {
                stopRecording()
            }
        }
    }
    init() {
        setupRecorder()
    }
    func setupRecorder() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let documentsPath = FileManager.default.urls(for: .musicDirectory, in: .userDomainMask)[0]
        // Get the URL of the Playground's Resources folder
        
        audioURL = documentsPath.appendingPathComponent("recording.m4a")
        let recordingSettings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: recordingSettings)
            audioRecorder?.prepareToRecord()
        } catch {
            print("Error setting up audio recorder: \(error.localizedDescription)")
        }
    }
    
    func startRecording() {
        audioRecorder?.record()
    }
    
    func stopRecording() {
        audioRecorder?.stop()
    }
}

struct RecordView: View {
    @AppStorage ("background") private var savedbackground = "defaultbackground"
    @AppStorage ("Sound") private var savedSound = "Boom"
    @ObservedObject var recorder = AudioRecorder()
    
    @State var wow = "Start recording"
    func moveAudioFileToFolder(from audioURL: URL, to targetFolderName: String) {
        // Get the documents directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Specify the target folder URL
        var targetFolderURL: URL
        
        if let audioURL = Bundle.main.url(forResource: "Boom", withExtension: "mp3") {
            // Use audioURL for further operations
            print("Audio file URL: \(audioURL)")
        } else {
            print("Audio file not found in the bundle.")
        }
        
        if let resourcesPath = Bundle.main.resourcePath {
            targetFolderURL = URL(fileURLWithPath: resourcesPath).appendingPathComponent(targetFolderName)
        } else {
            print("Error getting resource path.")
            return
        }
        
        // Ensure the target folder exists
        do {
            try FileManager.default.createDirectory(at: targetFolderURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating folder: \(error.localizedDescription)")
            // Handle the error appropriately
            return
        }
        
        // Create a new URL for the audio file in the target folder
        let audioFileName = audioURL.lastPathComponent
        let destinationURL = targetFolderURL.appendingPathComponent(audioFileName)
        
        // Move the audio file to the target folder
        do {
            try FileManager.default.moveItem(at: audioURL, to: destinationURL)
            print("Audio file moved to: \(destinationURL.path)")
        } catch {
            print("Error moving audio file: \(error.localizedDescription)")
            // Handle the error appropriately
        }
    }

    var body: some View {
        ZStack{
            Image(savedbackground)
            VStack {
                //            if recorder.recording == false {
                //                Button(wow) {
                //                    recorder.startRecording()
                //                }
                //            }
                //            else {
                //                Button("Stop Recording") {
                //                    recorder.stopRecording()
                //                }
                //            }
                Button(action:{
                    if recorder.recording == false{
                        recorder.startRecording()
                        recorder.recording = true
                        wow = "Stop Recording"
                        if let audioURL = recorder.audioURL {
                            moveAudioFileToFolder(from: audioURL, to: "")
                        }

                        
                        
                    } else{
                        recorder.stopRecording()
                        recorder.recording = false
                        wow = "Start Recording"
                    }
                    
                }){
                    Text(wow)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                

                if let audioURL = recorder.audioURL {
                    AudioPlayerView(audioURL: audioURL)
                }
                
            }
            .navigationBarTitle("Voice Recorder")
        }
    }
    
}
struct AudioPlayerView: View {
    @AppStorage ("Sound") private var savedSound = "Boom.mp3"
    var audioURL: URL
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        
        Button("Play Recording") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                audioPlayer?.play()
                print(audioURL)
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        }
        .padding()
        .background(Color.purple)
        .foregroundColor(.white)
        .cornerRadius(10)
        .onDisappear {
            audioPlayer?.stop()
            audioPlayer = nil
        }
        Button("Set as sound?"){
//            savedSound = "recording.m4a"
//            savedSound = audioURL
            
        }
    }
    
}
