//
//  Office_GroupApp.swift
//  Office Group
//
//  Created by Charlton Shih on 8/11/24.
//

import SwiftUI
import SwiftData

@main
struct Office_GroupApp: App {
    let container: ModelContainer = {
        let schema = Schema([GroupInfo.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container) 
    }
}
