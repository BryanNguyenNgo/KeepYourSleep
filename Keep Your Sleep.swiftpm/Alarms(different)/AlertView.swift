import SwiftUI
import Subsonic

struct AlertView: View {
    @AppStorage ("background") private var savedbackground = "defaultbackground"
    var alarm: Alarm
    @Environment(\.presentationMode) var presentationMode
    @StateObject var audioManager = SoundManager()
    var body: some View {
        ZStack{
            Image(savedbackground)
            VStack {
                Text(getCurrentDateInSingapore())
                    .font(.system(size: 20))
                     .foregroundColor(.white)
                Text(getCurrentDateTimeInSingapore())
                    .font(.system(size: 40))
                 .foregroundColor(.white)
                Text(alarm.label ?? "Alarm")
                    .font(.system(size: 30))
                 .foregroundColor(.white)
                
                Button {
                    alarm.isPlaying = false
                    audioManager.stopAlarmSound()
                    presentationMode.wrappedValue.dismiss()
                }label:{
                    Text("Stop")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.system(size: 15))
                }
            }
        }
    }
    
    func getCurrentDateInSingapore() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Singapore")
        
        return dateFormatter.string(from: Date())
    }
    func getCurrentDateTimeInSingapore() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Singapore")
        
        return dateFormatter.string(from: Date())
    }


}
