import SwiftUI

// Step 3: AlarmListView
struct AlarmListView: View {
    @State private var showingAlarmSheet = false
    @State private var selectedTime = Date()
    @State private var showAddAlarmView = false
    @AppStorage ("gooff") private var alarmgooff = false
    
    @ObservedObject var viewModel: AlarmViewModel
    @ObservedObject var timerManager: AlarmTimerManager
// Create an instance of AlarmTimerManager
    
    init(viewModel: AlarmViewModel) {
        print("AlarmListView init called with viewModel: \(viewModel)")
        self.viewModel = viewModel
        self.timerManager = AlarmTimerManager(viewModel: viewModel) // Initialize AlarmTimerManager
        
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.alarms) { alarm in
                    HStack{
                        
                        VStack{
                            Text("\(alarm.time, formatter: timeFormatter)")
                                .font(.system(size: 25))
                            Text(alarm.label ?? "Alarm")
                            
                        }
                        Spacer()
                        Toggle(isOn: $viewModel.alarms[viewModel.alarms.firstIndex(of: alarm)!].isActive) {
                            // You can add a label or any content here if needed.
                        }
                    }
                    .sheet(isPresented: $alarmgooff) {
                        AlertView(alarm: alarm)
                    }
                }
                 .onDelete(perform: deleteAlarm)
            }
            .navigationBarTitle("Alarms")
            .navigationBarItems(trailing: addButton)
        }
    }

    
    // Step 4: "+" Button
    var addButton: some View {
        NavigationLink(destination: AddAlarmView(isPresented: $showAddAlarmView, viewModel: viewModel)) {
            Image(systemName: "plus")
        }
    }
    
    // Helper function to format time
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    // Step 5: Delete Alarm
    func deleteAlarm(at offsets: IndexSet) {
        viewModel.alarms.remove(atOffsets: offsets)
    }
}
