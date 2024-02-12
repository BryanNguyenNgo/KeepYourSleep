import SwiftUI

struct StartView: View{
    var body: some View{
        ZStack{
            TabView{
                ContentView()
                    .tabItem { Label("Home", systemImage: "homekit"
                    )}
                ShopView()
                    .tabItem { Label("Shop", systemImage: "cart")}
                AvatarView()
                    .tabItem { Label("Avatar", systemImage: "person.fill")}
                    TipsView()
                        .tabItem { Label("Tips", systemImage:"questionmark.app") }
                    SettingsView()
                        .tabItem { Label("Settings", systemImage: "gear") }
                
                
            }
            
        }
    }
}
