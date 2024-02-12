//
//import SwiftUI
//
//struct AlarmDetailView: View {
//    @Binding var alarm: Alarm
//    @Binding var AccentColour:Color
//    @AppStorage("breaktime") var savedbreakTime = ""
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
//    var body: some View {
//        VStack{
//            
//            //            TextField("Alarm title", text:$alarm.title)
//            
//            Button {
//                alarm.wentOff.toggle()
//                print(savedbreakTime)
//            }label : {
//                Text("Remaining sleep time is \(savedhoursremains) hours \(savedminutesremains) minutes  \(savedsecondsremains) seconds")
//                    .font(.system(size: 28))
//                    .multilineTextAlignment(.center)
//                    .padding()
//            }
//        }
//        .navigationTitle("\(alarm.title) hours")
//        
//    }
//}
//
//struct AlarmDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmDetailView(alarm: .constant(Alarm(title: "HEY GET OFF THIS PAGE")), AccentColour: .constant(.accentColor))
//    }
//}
//
