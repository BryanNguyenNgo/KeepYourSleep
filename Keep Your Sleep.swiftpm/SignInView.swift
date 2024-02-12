import SwiftUI


struct SignInView: View{
    @StateObject var currentusername = GlobalAppData.numberClick
    @AppStorage ("currentusername") private var savedcurrentusername = ""
    @StateObject var currentpassword = GlobalAppData.numberClick
    @AppStorage ("currentpassword") private var savedcurrentpassword = ""
    @StateObject var newusername = GlobalAppData.numberClick
    @AppStorage ("newusername") private var savednewusername = ""
    @StateObject var newpassword = GlobalAppData.numberClick
    @AppStorage ("newpassword") private var savednewpassword = ""
    
    
    @State var goHomePage = false
    var body: some View{
        ZStack{
            VStack{
                Text("Keep Your Sleep")
                    .padding()
                    //.background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.system(size:36))
                TextField("Type in your Username", text: $savednewusername)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.gray)
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                    .padding()
                TextField("Type in your Password", text: $savednewpassword)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(Color.gray)
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                Button(action: {
                    savedcurrentusername = savednewusername
                    savedcurrentpassword = savednewpassword
                    goHomePage = true
                    savednewusername = ""
                    savednewpassword = ""
                    
                }){
                    Text("Sign In")
                        .background(Color.purple)
                        .cornerRadius(10)
                        .font(.system(size: 35))
                        .padding()
                        .foregroundColor(.white)
                }
                .sheet(isPresented: $goHomePage){
                    StartView()
                }
            }
        }
        
    }
}
