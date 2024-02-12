import SwiftUI

struct ChangePassView: View{
    @AppStorage ("currentpassword") private var savedcurrentpassword = ""
    @AppStorage ("newpassword") private var savednewpassword = ""
    @Environment(\.dismiss) var dismiss
    @State var goBack = false
    var body: some View{
        Text("Change Password")
            .padding()
            //.background(Color.purple)
            .foregroundColor(.black)
            .cornerRadius(10)
            .font(.system(size:36))
        TextField("Type in your new Password", text: $savednewpassword)
            .padding()
            .background(Color.white)
            .foregroundColor(Color.gray)
            .cornerRadius(10)
            .multilineTextAlignment(.center)
//            .sheet (isPresented: $goBack){
                Button(action:{
                    savedcurrentpassword = savednewpassword
                    savednewpassword = ""
                    print(savedcurrentpassword)
                    dismiss()
                    
                }) {
                    Text("Done")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.system(size: 20))
                }
                
//            }
        
    }
}
