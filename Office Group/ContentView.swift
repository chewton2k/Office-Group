//
//  ContentView.swift
//  Office Group
//
//  Created by Charlton Shih on 8/11/24.
//

import SwiftUI



struct ContentView : View {
    @State private var tabSelection = 1

    
    var body: some View {
        TabView(selection: $tabSelection) {
            HomePage()
                .tag(1)
            Text("Account Settings")
                .tag(2)
            TextRecognition()
                .tag(3)
            GroupView()
                .tag(4)
            Text("Settings tab")
                .tag(5)
        }
        .overlay(alignment: .bottom) {
            CustomTabView(tabSelection: $tabSelection)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
