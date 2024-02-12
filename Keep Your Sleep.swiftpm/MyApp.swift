import SwiftUI

@main
struct MyApp: App {
    @AppStorage ("background") private var savedbackground = "defaultbackground"
    var body: some Scene {
        
        WindowGroup {
            ZStack{
                Image(savedbackground)
                SignInView()
            }
        }
    }
}
