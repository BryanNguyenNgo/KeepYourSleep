//
import SwiftUI
////This app was originally created from a template from the internet to help students do a countdown for their breaktime during studying. 
////import AVKit
//import Subsonic
////class SettingsViewModel: ObservableObject {
////    @AppStorage("breaktime") var breakTime: String = ""
////    func setBreakTime(breakTime: String) {
////        let breakTime = breakTime
////        // Now you can use the value of breakTime as needed.
////    }
////    func retrieveBreakTime() -> String {
////        return breakTime
////    }
////}
class GlobalAppData: ObservableObject{
    @Published var numGlobal = ""
    @Published var intGlobal = 0
    @Published var strGlobal = ""
    static var numberClick = GlobalAppData()
}
//
//struct NewTimerView: View {
//    //    var sound = SubsonicPlayer(sound: "time up.m4a")
//    //    @ObservedObject private var settingsViewModel = SettingsViewModel()
//    @StateObject var breakTime = GlobalAppData.numberClick
//    @AppStorage ("breakTime") private var savedbreakTime = ""
//    @State var hours: String = ""
//    @State var minutes: String = ""
//    @State var seconds: String = ""
//    @State var timerIsPaused: Bool = true
//    
//    @Binding var alarms: [Alarm]
//    @Environment(\.presentationMode) var presentationMode
//    
//    @State var timer: Timer? = nil
//    
//    @State var target = 60
//    @State var duration = 0
//    //@State var breakTime = ""
//    //    @State var breakTime = ""
//    // Assuming the class definition for SettingsViewModel remains unchanged.    
//    //    @State var hoursremains = 0
//    //    @State var minutesremains = 0
//    //    @State var secondsremains = 0
//    @StateObject var hoursremains = GlobalAppData.numberClick
//    @AppStorage ("hoursremains") private var savedhoursremains = 0
//    //    @State var minutes: Int = 0
//    @StateObject var minutesremains = GlobalAppData.numberClick
//    @AppStorage ("minutesremains") private var savedminutesremains = 0
//    //    @State var seconds: Int = 0
//    @StateObject var secondsremains = GlobalAppData.numberClick
//    @AppStorage ("secondsremains") private var savedsecondsremains = 0
//    
//    
//    //@State var content = UNMutableNotificationContent()
//    //let content = UNMutableNotificationContent()
//    //    @State var audioPlayer : AVAudioPlayer!
//    //    @State var isPlaying = true
//    
//    var body: some View {
//        ZStack {
//            Color(red: 70 / 255, green: 100 / 255, blue: 250 / 255)
//                .ignoresSafeArea()
//            VStack{
//                Button("\(savedbreakTime)"){
//                    savedbreakTime = breakTime.numGlobal
//                }
//                TextField("Sleep time in hours? ", text: $savedbreakTime)
//                
//                    .font(.system(size: 28))
//                    .keyboardType(.decimalPad)
//                    .border(Color.black)
//                    .padding(10)
//                    .multilineTextAlignment(.center)
//                
//                Text("Sleeping time in hours")
//                    .font(.system(size: 22))
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//                    .padding(10)
//                
//                if savedbreakTime != "" {
//                    Text("Time entered is \(savedbreakTime) hours.")
//                }
//                Button("Resume"){
//                    self.startTimer()
//                }
//                Text("Remaining sleep time is \(savedhoursremains):\(savedminutesremains):\(savedsecondsremains)")
//                    .font(.system(size: 28))
//                    .multilineTextAlignment(.center)
//                    .padding()
//                
//                if duration >= target {
//                    Text("Your sleep is over. Please go back to society.")
//                        .font(.system(size: 28))
//                } else {
//                    Text("Take regular naps so that you would not feel tired during work.")
//                        .font(.system(size: 20))
//                        .padding()
//                }
//                Button("Save Timer") {
//                    alarms.append(Alarm(title: "\(hours): \(minutes): \(seconds)"))
//                    presentationMode.wrappedValue.dismiss()
//                }
//                if timerIsPaused {
//                    HStack {
//                        Button(action:{
//                            print("RESeT")
//                            self.restartTimer()
//                            self.stopTimer()
//                        }){
//                            Image(systemName: "circle")
//                                .padding(.all)
//                                .foregroundColor(.black)
//                                .font(.system(size: 75))
//                            
//                        }
//                        .padding(.all)
//                        
//                        Button(action:{
//                            timerIsPaused = false
//                            print("START")
//                            self.startTimer()
//                            
//                        }){
//                            Image(systemName: "play.fill")
//                                .padding(.all)
//                                .foregroundColor(.black)
//                                .font(.system(size: 85))
//                        }
//                        .padding(.all)
//                    }
//                    
//                    //                } else {
//                    //                    Button(action:{
//                    //                        print("STOP")
//                    //                        self.stopTimer()
//                    ////                        timerIsPaused = true
//                    //                    }){
//                    //                        Image(systemName: "stop.fill")
//                    //                            .padding(.all)
//                    //                            .foregroundColor(.black)
//                    //                    }
//                    //                    .padding(.all)
//                    
//                }    
//                //                hoursremains.intGlobal = savedhoursremains
//                
//            }
//            
//        }
//    }
//    func startTimer() {
//        let temp = Int(savedbreakTime) ?? 0
//        if temp >= 1 {
//            savedhoursremains = temp
//            print(savedhoursremains)
//            
//        }
//        if temp < 1 {
//            savedhoursremains = 0
//            savedminutesremains = temp * 60
//        }
//        
//        savedsecondsremains = 0
//        duration = 0
//        target = temp*60
//        timerIsPaused = false
//        timer = Timer.scheduledTimer(withTimeInterval: 1 , repeats: true){ _ in
//            if duration == target {
//                stopTimer()
//                //                self.Notification_sound()
//            }
//            if self.savedsecondsremains == 0 {
//                self.savedsecondsremains += 59
//                if self.savedminutesremains == 0 {
//                    self.savedminutesremains += 59
//                    if self.savedhoursremains > 0 {
//                        self.savedhoursremains -= 1
//                    }
//                } else {
//                    self.savedminutesremains -= 1
//                }
//                duration += 1
//            } else {
//                self.savedsecondsremains -= 1
//                duration += 1
//            }
//            
//        }
//        
//        breakTime.numGlobal = savedbreakTime
//        savedbreakTime = breakTime.numGlobal
//        hoursremains.intGlobal = savedhoursremains
//        minutesremains.intGlobal = savedminutesremains 
//        secondsremains.intGlobal = savedsecondsremains
//        hours = String(savedhoursremains)
//        minutes = String(savedminutesremains)
//        seconds = String(savedsecondsremains)
//        
//    }
//    
//    func stopTimer(){
//        timerIsPaused = true
//        timer?.invalidate()
//        timer = nil
//    }
//    
//    func restartTimer(){
//        savedhoursremains = 0
//        savedminutesremains = 0
//        savedsecondsremains = 0
//        duration = 0
//        target = 0
//        
//    }
//    
//    //    func Notification_sound(){
//    //        let sound = Bundle.main.path(forResource: "time up", ofType: "m4a")
//    //        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
//    //        self.audioPlayer.play()
//    //        
//    //    }
//}
//
//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewAlarmView(alarms: .constant([]))
//    }
//}
//
//
