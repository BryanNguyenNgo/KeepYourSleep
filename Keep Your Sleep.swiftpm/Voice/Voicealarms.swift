import SwiftUI

struct VoiceAlarm: Identifiable {
    
    let id = UUID()
    var title: String
    var wentOff: Bool = false
    
}
