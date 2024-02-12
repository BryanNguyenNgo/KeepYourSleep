
import SwiftUI
import AVFoundation
import Subsonic
struct SoundAlarmView: View {
    var body: some View {
                
        SAlarmView()
    }
}
struct SAlarmView: View {
    @State var voicealarms = [VoiceAlarm(title: "Boom", wentOff: false),VoiceAlarm(title:"android", wentOff: false),
                              VoiceAlarm(title: "Emotional Damage", wentOff: false),
                              VoiceAlarm(title: "SODA", wentOff: false),
                              VoiceAlarm(title: "metal pipe", wentOff: false),
                              VoiceAlarm(title: "rap", wentOff: false),
                              VoiceAlarm(title: "ambatukam", wentOff: false),
                              VoiceAlarm(title: "mondayleftme", wentOff: false),
                              VoiceAlarm(title: "did_you_pray_today", wentOff: false),
                              VoiceAlarm(title: "nick-eh-30-intro", wentOff: false)]
    @State var songs = [Music(title: "Beethoven_Sonata_No_31"),
                        Music(title:"rain"),
                        Music(title: "Brandenburg-Concerto-no.-3")
    ]
    @State var isSheetPresented = false
    var body: some View{
        NavigationView {
            HStack{
                List {
                    Text("Ringtones")
                        .font(.system(size: 35))
                        .bold()
                    ForEach($voicealarms) {$voice in 
                        NavigationLink {
                            VoiceDetailView(voice: $voice)
                        } label : {
                            HStack {
                                Text(voice.title)
                                    .strikethrough(voice.wentOff)
                            }
                        }
                    }
                    .onDelete{ indexSet in 
                        voicealarms.remove(atOffsets: indexSet)
                    }
                    .onMove {indices, newOffset in voicealarms.move(fromOffsets: indices, toOffset: newOffset )
                        
                    }
                    
                    //            .toolbar {
                    ////                ToolbarItemGroup(placement: .navigationBarTrailing){
                    //                ToolbarItemGroup(){
                    //                    EditButton()
                    //                    Button {
                    //                        isSheetPresented = true
                    //                    } label: {
                    //                        Image(systemName: "plus")
                    //                    }
                    //                }
                    //            }
                    .sheet (isPresented: $isSheetPresented){
                        //                newVoiceView()
                    }
                }
                List {
                    Text("Sleeping Audio")
                        .font(.system(size: 35))
                        .bold()
                    ForEach($songs) {$song in 
                        NavigationLink {
                            MusicDetailView(song: $song)
                        } label : {
                            HStack {
                                Text(song.title)
                            }
                        }
                    }
                }
            }
        }
        
    }
}
