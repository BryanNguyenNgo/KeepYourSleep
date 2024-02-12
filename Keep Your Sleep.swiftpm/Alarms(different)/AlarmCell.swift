//import SwiftUI
//
//struct AlarmEditView: View{
//    @Binding var alarm: Alarm
//    var body: some View {
//        Text(alarm.title)
//    }
//}
import SwiftUI
struct AlarmCell: View {
    @Binding var alarm: Alarm // Binding to the Alarm object
    
    var body: some View {
        HStack {
            Text(alarm.timeString)
            // Display alarm time here
            Spacer()
            Toggle("", isOn: $alarm.isActive) // Use the binding to isEnabled
        }
    }
}

