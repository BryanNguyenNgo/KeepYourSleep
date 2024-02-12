import SwiftUI
struct SettingsView: View{
    @AppStorage ("currentavatar") private var savedcurrentavatar = "default.png"
    @AppStorage ("currentusername") private var savedcurrentusername = ""
    @AppStorage ("currentpassword") private var savedcurrentpassword = ""
    @AppStorage ("background") private var savedbackground = "defaultbackground"
    @State var goChangeUsername = false
    @State var goChangePassword = false
    @Environment(\.dismiss) var dismiss
    //    @StateObject var Colour = GlobalAppData.numberClick
    //    @AppStorage ("Colour") private var accentColour: Color = .accentColor
    @State private var selection = "defaultbackground"
    //    @StateObject var wow = GlobalAppData.numberClick
    //    @AppStorage ("wow") private var savedWow: Color = Color.white
    let backgrounds = ["defaultbackground", "ShootingStar","baldzhong", ]
    
    
    var body: some View{
        ZStack{
            Image(savedbackground)
            
            VStack{
                Text("Settings")
                    .padding()
                    //.background(Color.purple)
                   .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.system(size:25))
                Image(savedcurrentavatar)
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("Username: \(savedcurrentusername)")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                Text("Password: \(savedcurrentpassword)")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                Button(action:{
                    goChangeUsername = true
                    
                }){
                    Text("Change Username")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.system(size:15))
                }
                .sheet(isPresented: $goChangeUsername) {
                    ChangeUserNView()
                }
                Button(action:{
                    goChangePassword = true
                }){
                    Text("Change Password")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.system(size:15))
                }
                .sheet(isPresented: $goChangePassword) {
                    ChangePassView()
                }
                Link(destination: URL(string:"https://docs.google.com/forms/d/e/1FAIpQLSdF1BcxsMOV16WK-krkngkXDwpBn89VAp6UsEBCYsellh_ZzA/viewform")!){
                    Image("Image Asset 1")
                        .resizable()
                        .frame(width: 150, height: 50)
                }
                //                Text("Change background")
                //                Button(action:{
                //                    
                //                }) {
                //                    Image("background2")
                //                        .resizable()
                //                }
                Group{
                    HStack{
                        Picker("Select a background", selection: $selection){
                            ForEach(backgrounds, id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        
                    }
                    //                                Button(action:{
                    //                                    
                    //                                }){
                    //                                    Text("Leave a review!")
                    //                                        
                    //                                }
                    
                    
                    Button(action: {
                        savedbackground = selection
                        
                    }) {
                        Text("Done")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.system(size:15))
                    }
                    Button(action:{
                        savedcurrentusername = ""
                        savedcurrentpassword = ""
                        dismiss()
                        
                    }) {
                        Text("Sign out")
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.system(size:15))
                    }
                    
                }
                
            }
        }
    }
}
