//
//  AutoScroolView.swift
//  SctAppTV
//
//  Created by Rohit.Dwivedi on 02/06/25.
//

import SwiftUI

struct AutoScroolView: View {
    let newsArray = ["img1","img2","img3","news1"]
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var selection = 0
    @Environment(\.dismiss) var dismiss
    @State private var navigate = false
    @State var selectedImg = 0
    @State private var showBox = false

    var body: some View {
        VStack {
            HStack{
                Button {
                   dismiss()
                } label: {
                   // Image(systemName: "arrowshape.backward.fill")
                    Label("Back", systemImage: "arrowshape.backward.fill")
                       // .frame(width: 100, height: 50)
                }
                Spacer()
            }.frame(height: 50)
            Spacer()
            ZStack {
                ForEach (0..<newsArray.count){i in
                    if i == selectedImg {
                        Button {
                            navigate = true
                        } label: {
                        
                        
                            Image("\(newsArray[selectedImg])").resizable().scaledToFit()
                                .transition(.slide)
                                .id(selectedImg)
                           // .animation(.easeInOut(duration: 2.5), value: selectedImg)
                    }
                    }
                }
            }
           
        }
        .onReceive(timer, perform: {_ in
            print(UIScreen.main.bounds.height)
            withAnimation{
                if selectedImg == newsArray.count-1{
                    selectedImg = 0
                }else{
                    selectedImg += 1
                }
            }
        })
        
        
    /*    VStack{
//            HStack{
//                Button {
//                   dismiss()
//                } label: {
//                   // Image(systemName: "arrowshape.backward.fill")
//                    Label("Back", systemImage: "arrowshape.backward.fill")
//                       // .frame(width: 100, height: 50)
//                }
//                Spacer()
//            }.frame(height: 50)
//            Spacer()
        TabView(selection:$selection ){
            ForEach (0..<newsArray.count){i in
//                Button {
//                    navigate = true
//                } label: {
//                    Image("\(newsArray[i])").resizable().scaledToFill()
//                }
                Image("news1").resizable().scaledToFill()
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.smooth, value: selection)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .onReceive(timer, perform: {_ in
                    withAnimation{
                        selection = selection < newsArray.count ? selection + 1 : 0
                    }
                })
        }*/
        .navigationDestination(isPresented: $navigate) {
            NewsDetailView()
        }
        .edgesIgnoringSafeArea([.horizontal,.vertical])
    }
}

#Preview {
    AutoScroolView()
}
