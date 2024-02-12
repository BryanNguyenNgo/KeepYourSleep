import SwiftUI

struct ShopView: View{
    @AppStorage ("currentavatar") private var savedcurrentavatar = "default.png"
    @AppStorage ("background") private var savedbackground = "defaultbackground"
//    @StateObject var oints = GlobalAppData.numberClick
    @AppStorage ("oints") private var points = 0

    @State var pointsBeAdded = 0
    @StateObject var boughtTopHat = GlobalAppData.numberClick
    @AppStorage ("boughtTopHat") private var savedBoughtTopHat = false
    @StateObject var Top = GlobalAppData.numberClick
    @AppStorage ("Top") private var TopHat = "Top Hat"
    @StateObject var hades = GlobalAppData.numberClick
    @AppStorage ("hades") private var Shades = "Shades"
    @StateObject var boughtShades = GlobalAppData.numberClick
    @AppStorage ("boughtShades") private var savedBoughtShades = false
    @StateObject var Sleep = GlobalAppData.numberClick
    @AppStorage ("Sleep") private var SleepMask = "Sleep Mask"
    @StateObject var boughtSleepMask = GlobalAppData.numberClick
    @AppStorage ("boughtSleepMask") private var savedBoughtSleepMask = false
    @StateObject var Banana = GlobalAppData.numberClick
    @AppStorage ("Banana") private var bananaCat = "Banana Cat"
    @StateObject var boughtBananaCat = GlobalAppData.numberClick
    @AppStorage ("boughtBananaCat") private var savedBoughtBananaCat = false
    
    var body: some View{
        ZStack{
            Image(savedbackground)
            VStack{
                Text("Points: \(points)")
                //.background(Color.purple)
                    .cornerRadius(90)
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                Button(action:{
                    pointsBeAdded = Int.random(in: 1...15)
                    points += pointsBeAdded
                }){
                    Text("Claim your points")
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(90)
                }
                Text("Shop")
                //.background(Color.purple)
                    .cornerRadius(90)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                Button(action: {
                    if savedBoughtShades == true{
                        Shades = "Item has already been bought"
                    } else{
                        
                        if points >= 15{
                            points -= 15
                            savedBoughtShades = true
                            if savedBoughtShades == true{
                                Shades = "Item has been bought"
                                
                            } 
                            
                        }
                        if savedBoughtShades == false{
                            Shades = "Shades"
                        }
                        
                    }
                }) {
                    Text(Shades)
                        .padding()
                        .background(Color.purple)
                        .font(.system(size: 15))
                        .cornerRadius(90)
                        .foregroundColor(.black)
                    Image("Rims.png")
                        .frame(width: 50, height: 50)
                        .padding()
                    Text("15 points")
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .font(.system(size: 15))
                        .cornerRadius(90)
                }
                Button(action: {
                    if savedBoughtSleepMask == true{
                        SleepMask = "Item already has been bought"
                    } else{
                        
                        if points >= 15{
                            
                            points -= 15
                            savedBoughtSleepMask = true
                            if savedBoughtSleepMask == true{
                                SleepMask = "Item has been bought"
                            }
                            
                        }
                        if savedBoughtSleepMask == false{
                            SleepMask = "Sleep Mask"
                        }
                    }
                }) {
                    Text(SleepMask)
                        .padding()
                        .background(Color.purple)
                        .font(.system(size: 15))
                        .cornerRadius(90)
                        .foregroundColor(.black)
                    Image("SleepMask.png")
                        .frame(width: 50, height: 50)
                        .padding()
                    Text("15 points")
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .font(.system(size: 15))
                        .cornerRadius(90)
                    
                    
                }
                Button(action: {
                    if savedBoughtTopHat == true{
                        TopHat = "Item has already been bought"
                    } else{
                        
                        if points >= 20{
                            points -= 20
                            savedBoughtTopHat = true
                            if savedBoughtTopHat == true{
                                TopHat = "Item has been bought"
                            }
                            
                        }
                        if savedBoughtTopHat == false{
                            TopHat = "TopHat"
                        }
                    }
                }) {
                    Text(TopHat)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .font(.system(size: 15))
                        .cornerRadius(90)
                    Image("Top_Hat.png")
                        .frame(width: 50, height: 50)
                        .padding()
                    Text("20 points")
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .font(.system(size: 15))
                        .cornerRadius(90)
                }
                
                Button(action: {
                    if savedBoughtBananaCat == true{
                        bananaCat = "Item already has been bought"
                    } else{
                        
                        if points >= 100{
                            
                            points -= 100
                            savedBoughtBananaCat = true
                            if savedBoughtBananaCat == true{
                                bananaCat = "Item has been bought"
                            }
                            
                        }
                        if savedBoughtBananaCat == false{
                            bananaCat = "Sleep Mask"
                        }
                    }
                }) {
                    Text(bananaCat)
                        .padding()
                        .background(Color.purple)
                        .font(.system(size: 15))
                        .cornerRadius(90)
                        .foregroundColor(.black)
                    Image("bananacat.png")
                        .frame(width: 50, height: 50)
                        .padding()
                    Text("100 points")
                        .foregroundColor(.black)
                        .background(Color.purple)
                        .font(.system(size: 15))
                        .cornerRadius(90)
                }
                Button(action:{
                    savedBoughtTopHat = false
                    savedBoughtShades = false
                    savedBoughtSleepMask = false
                    savedBoughtBananaCat = false
                    points -= points
                }) {
                    Text("Reset Shop")
                        .foregroundColor(.red)
                        .background(Color.black)
                        .font(.system(size: 25))
                }
            }
        }
    }
}
