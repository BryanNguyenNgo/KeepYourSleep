import SwiftUI

struct AddAlarmView: View {
    @Binding var isPresented: Bool
    @State private var selectedTime = Date()
    @State private var newAlarmLabel = ""
    @State private var isActive = true
    @ObservedObject var viewModel: AlarmViewModel // Replace with your ViewModel
    @State private var showAlert = false
    @State private var isTriggered = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                TextField("Label (optional)", text: $newAlarmLabel)
                Toggle("Active", isOn: $isActive)
                Button("Save") {
                    if newAlarmLabel == ""{
                        newAlarmLabel = "Alarm"
                    }
                    if isValidTime(selectedTime) {
                        let newAlarm = Alarm(time: selectedTime, label: newAlarmLabel, isActive: isActive, isTriggered: isTriggered)
                        
                        viewModel.addAlarm(alarm: newAlarm) // Replace with your ViewModel's addAlarm method
                        isPresented.toggle()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        showAlert.toggle()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Invalid Time"),
                    message: Text("Please select a future time."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationTitle("Alarms")
        }
        .navigationViewStyle(.stack)
    }
    
    func isValidTime(_ time: Date) -> Bool {
        // Check if the selected time is in the future
        return time > Date()
    }
}
