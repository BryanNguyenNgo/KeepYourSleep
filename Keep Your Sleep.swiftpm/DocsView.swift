import SwiftUI
struct DocsView: View{
    var body: some View{
        Text("How to use Keep Your Sleep (KYS)")
        Text("KYS was made to help people sleep by having engaging and fun features to persuade users to sleep early.")
        Text("KYS was created by a group of students from 2G. This students are Bryan, Alexis, Serafina, Hussein and Eron, my humble king.")
        
        HStack{
            
            Image("Image Asset 2")
                .resizable()
                .frame(width: 300, height: 300)
            Image("Image Asset 3")
                .resizable()
                .frame(width: 300, height: 300)
        }
    }
}
