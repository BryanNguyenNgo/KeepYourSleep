import SwiftUI
// Step 1: Alarm Model
class Alarm: Identifiable, ObservableObject, Equatable{
    let id = UUID()
    @Published var time: Date
    @Published var label: String?
    @Published var isActive: Bool = false
    @Published var isTriggered: Bool = false
    @Published var isPlaying: Bool = false
    
    init(time: Date, label: String?, isActive: Bool, isTriggered: Bool) { // Include isActive in the initializer
        self.time = time
        self.label = label
        self.isActive = isActive
        self.isTriggered = isTriggered// Initialize isActive with the provided value
    }
    var timeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: time)
    }
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.id == rhs.id
    }
}
// Step 2: Alarm ViewModel
class AlarmViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    func toggleIsActive(for alarm: Alarm) {
        if let index = alarms.firstIndex(where: { $0.id == alarm.id }) {
            alarms[index].isActive.toggle()
        }
    }
    func addAlarm(alarm: Alarm) {
        alarms.append(alarm)
    }
    
    func toggleAlarmActivation(alarm: Alarm) {
        if let index = alarms.firstIndex(where: { $0.id == alarm.id }) {
            alarms[index].isActive.toggle()
        }
    }
}

