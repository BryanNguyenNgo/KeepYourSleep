import SwiftUI

struct ChangeUserNView: View{
    @AppStorage ("currentusername") private var savedcurrentusername = ""
    @AppStorage ("newusername") private var savednewusername = ""
    @Environment(\.dismiss) var dismiss
    @State var goBack = false
    var body: some View{
        Text("Change Username")
            .padding()
            //.background(Color.purple)
            .foregroundColor(.black)
            .cornerRadius(10)
            .font(.system(size:36))
        TextField("Type in your new Username", text: $savednewusername)
            .padding()
            .background(Color.white)
            .foregroundColor(Color.gray)
            .cornerRadius(10)
            .multilineTextAlignment(.center)
        //            .sheet (isPresented: $goBack){
        Button(action:{
            savedcurrentusername = savednewusername
            savednewusername = ""
            print(savedcurrentusername)
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
