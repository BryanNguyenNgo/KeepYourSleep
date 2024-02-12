
import SwiftUI
import Subsonic

struct ContentView: View {
    @StateObject var currentavatar = GlobalAppData.numberClick
    @AppStorage ("currentavatar") private var savedcurrentavatar = "default.png"
    @StateObject var background = GlobalAppData.numberClick
    @AppStorage ("background") private var savedbackground = "defaultbackground"
    @State var isSheetPresented = false
    @State var goSoundAlarm = false
    @State var goSettings = false
    @State var goDocs = false
    @State var goAlarm = false
//    @StateObject var currentusername = GlobalAppData.numberClick
    @AppStorage ("currentusername") private var savedcurrentusername = ""
    @AppStorage ("currentpassword") private var savedcurrentpassword = ""
    //    @StateObject var sound = SubsonicPlayer(sound: "infinite cum.mp4")
    @AppStorage ("breakTime") private var savedbreakTime = ""
    func buttonPressed(){
        print("hello")
    }
    @State var Voice = "Voice"
    // For Alarm button
    
    @StateObject var viewModel = AlarmViewModel()

    var body: some View {
        ZStack {
            Image(savedbackground)
            VStack {
                HStack{
                    Text("Hello \(savedcurrentusername)")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .font(.system(size: 40))
                }
                //              Button(action: {
                //                  goSettings = true
                //            }) {
                //                Image("settings")
                //                    .resizable()
                //                    .scaledToFit()
                //                    .frame(width: 70, height: 70)
                //                    .padding()
                //                    .position(x: 300, y: 100)
                //            }                      
                //            .sheet(isPresented: $goSettings) {
                //                SettingsView()
                //            }
                
                Button(action:{
                    goDocs = true
                }){
                    Image("KYS2")
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                .sheet(isPresented: $goDocs) {
                    DocsView()
                }
                
                
                Text("Keep Your Sleep")
                    .padding()
//                    .background(Color.purple)
                    .foregroundColor(.white)
                    .font(.system(size: 40))
                
                HStack {
                    Spacer()
                    Button(action: {
                        isSheetPresented = true
                    }) {
                        Text("Timer")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.system(size: 30))
                    }
                    .sheet(isPresented: $isSheetPresented) {
                          CountdownTimerView()
                    }
                   // Spacer() // This pushes the button to the left
                    Button(action: {
                        goSoundAlarm = true
                    }) {
                        Text("Alarms")
                            .lineLimit(2)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.system(size: 30))
                    }
                    .sheet(isPresented: $goSoundAlarm) {
                        AlarmListView(viewModel: viewModel)
                    }
                    Spacer() // This pushes the button to the left
                }
                HStack{
                    
                    Button(action: {
                        goSettings = true
                    }) {
                        Text("Music")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.system(size: 20))
                        
                    }
                    .sheet(isPresented: $goSettings) {
                        SoundAlarmView()
                    }
                    Button(action: {
                        goAlarm = true
                    }) {
                        Text(Voice + "\n" + "Alarms" )
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.system(size: 15))
                        
                    }
                    .sheet(isPresented: $goAlarm) {
                        RecordView()
                    }
                }
                    Image(savedcurrentavatar)
                
                    .resizable()
                    .frame(width: 100, height: 100)
            }
        }
    }
}
