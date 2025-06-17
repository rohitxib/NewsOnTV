//
//  NewsDashBord.swift
//  SctAppTV
//
//  Created by Rohit.Dwivedi on 02/06/25.
//

import SwiftUI

struct NewsDashBord: View {
    let newsArray = [NewsObject(uniqueID: 1, name: "Cricket", image: "cricket"),NewsObject(uniqueID: 2, name: "Footbal", image: "football"),NewsObject(uniqueID: 3, name: "Hocky", image: "hocky"),NewsObject(uniqueID: 4, name: "Golf", image: "golf")]
    @FocusState var focusedField: NewsObject?
    @State private var navigate = false
    var body: some View {
        
        VStack {
            HStack{
                Text("Category").fontWeight(.bold)
                Spacer()
            }
            .padding([.top],-80)
           
            ScrollView (.horizontal, showsIndicators: false) {
               
                LazyHStack {
                    ForEach(newsArray, id: \.uniqueID) { newss in
                        Button {
                            navigate = true
                        } label: {
                            VStack{
                                Image(newss.image)
                                    .resizable()
                                    .frame(width: 360, height: 240)
                                Text(newss.name)
                            }
                        }
                        .buttonStyle(.borderless)
                        .focused($focusedField, equals: newss)
                    }
                }
            }
            .frame(height: 320)
            Spacer()
        }.padding(50)
        //.frame(height: 600)
        .onAppear {
            focusedField = newsArray.first
        }
        .navigationDestination(isPresented: $navigate) {
            AutoScroolView()
        }
    }
}

#Preview {
    NewsDashBord()
}

struct NewsObject: Hashable {
    var uniqueID : Int
    var name: String
    var image: String
}
