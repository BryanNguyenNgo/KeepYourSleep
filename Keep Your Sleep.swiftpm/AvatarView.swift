import SwiftUI

struct AvatarView: View{
    @AppStorage ("currentavatar") private var savedcurrentavatar = "default.png"
    @AppStorage ("background") private var savedbackground = "defaultbackground"
    @AppStorage ("boughtTopHat") private var savedBoughtTopHat = false
    @AppStorage ("boughtShades") private var savedBoughtShades = false
    @AppStorage ("boughtSleepMask") private var savedBoughtSleepMask = false
    @AppStorage ("boughtBananaCat") private var savedBoughtBananaCat = false
    @StateObject var BoughtHat = GlobalAppData.numberClick
    @AppStorage ("BoughtHat") private var ifBoughtHat = "lock-1"
    @StateObject var BoughtShades = GlobalAppData.numberClick
    @AppStorage ("BoughtShades") private var ifBoughtShades = "lock-1"
    @StateObject var BoughtMask = GlobalAppData.numberClick
    @AppStorage ("BoughtMask") private var ifBoughtMask = "lock-1"
    @StateObject var BoughtCat = GlobalAppData.numberClick
    @AppStorage ("BoughtCat") private var ifBoughtCat = "lock-1"
    
    var body: some View{
        ZStack{
            Image(savedbackground)
            VStack{
                Text("Avatar Editor")
                .foregroundColor(.white)
               // .background(Color.purple)
                .cornerRadius(90)
                .font(.system(size: 25))
                
                Button(action:{
                    if savedBoughtTopHat == true{
                        ifBoughtHat = "Top_Hat.png"
                    }else{
                        ifBoughtHat = "lock-1"
                    }
                    if savedBoughtShades == true{
                        ifBoughtShades = "Rims.png"
                    }else{
                        ifBoughtShades = "lock-1"
                    }
                    if savedBoughtSleepMask == true{
                        ifBoughtMask = "SleepMask.png"
                    }else{
                        ifBoughtMask = "lock-1"
                    }
                    if savedBoughtBananaCat == true{
                        ifBoughtCat = "bananacat.png"
                    }else{
                        ifBoughtCat = "lock-1"
                    }
                }) {
                    
                    Text("Refresh")
                        .cornerRadius(90)
                        .font(.system(size: 25))
                }
                Image(savedcurrentavatar)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                    
                Button(action:{
                    print(savedBoughtShades)
                    if savedBoughtShades == true{
                        savedcurrentavatar = "ShadesAvatar.png"
                    }
                }) {
                    Image(ifBoughtShades)
                    .frame(width: 50, height: 50)
                    .padding()
                }
                Button(action:{
                    print(savedBoughtSleepMask)
                    if savedBoughtSleepMask == true{
                        savedcurrentavatar = "SleepMaskAvatar.png"
                    }
                }) {
                    Image(ifBoughtMask)
                    .frame(width: 50, height: 50)
                    .padding()
                }
                Button(action:{
                    print(savedBoughtTopHat)
                    if savedBoughtTopHat == true{
                        savedcurrentavatar = "TopAvatar.png"
                    }
                }) {
                    Image(ifBoughtHat)
                    .frame(width: 50, height: 50)
                    .padding()
                }
                Button(action:{
                    print(savedBoughtBananaCat)
                    if savedBoughtBananaCat == true{
                        savedcurrentavatar = "bananacat.png"
                    }
                }) {
                    Image(ifBoughtCat)
                        .frame(width: 50, height: 50)
                        .padding()
                }
                Button(action:{
                    savedcurrentavatar = "default.png"
                }) {
                    Text("Reset Avatar")
                        .cornerRadius(90)
                        .font(.system(size: 25))
                }
            }
        }
        
    }
}
