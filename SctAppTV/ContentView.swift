//
//  ContentView.swift
//  SctAppTV
//
//  Created by Rohit.Dwivedi on 30/05/25.
//

import SwiftUI

struct ContentView: View {
    let newsArray = ["img1","img3","img2","img1"]
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var selection = 0
    var body: some View {
        TabView {
//           
            NewsDashBord()
                .edgesIgnoringSafeArea(.horizontal)
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
                .tag("news")
            
            Text("Audio")
                .tabItem {
                    Label("Audio", systemImage: "airpodsmax")
                }
                .tag("Audio")
            
            Text("Video")
                .tabItem {
                    Label("Video", systemImage: "video")
                }
                .tag("Audio")
            
            Image("chart1")
            .resizable()
            .aspectRatio(contentMode: .fill)
                .tabItem {
                    Label("Data", systemImage: "chart.line.uptrend.xyaxis")
                }
                .tag("Data")
            
            Text("search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag("search")
        }
    }
}

#Preview {
    ContentView()
}
